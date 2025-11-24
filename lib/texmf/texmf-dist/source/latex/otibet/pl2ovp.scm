;;
;; pl2ovp.scm
;; (c) Norbert Preining 1997
;; This file is part of the otibet-package.
;;
;; Converting pl to ovp file with a certain shift amount.
;; The FontDesignSize of the ovp-file can be given, also
;; the FONTAT value of the FONTMAP entry
;;
;; IMPORTANT: LIGTABLE will be deleted (at the moment)!!!!!!
;;
;; Provides:
;; (pl->ovp pl-filename ovp-filename shift ovp-designsize pl-at)
;;
;; pl-filename      The name (with or without extansion) of the input
;; ovp-filename     The name (with or without extension) of the output
;; shift            The value a character in pl-filename will be shifted
;;                  e.g.: in pl: (CHARACTER H 23 ...)
;;                        shift = (hex->dec "1000")
;;                        -> in ovp (CHARACTER H 1023 ... SETCHAR H 23 ...)
;; ovp-designsize   (DESIGNSIZE ...)
;; pl-at            (MAPFONT D 0 ...(FONTAT ...))
;; 
(load 'convnum.scm)

(define (convert-to-dec number mode)
  (let ((num (if (number? number)
		 (number->string number)
		 (symbol->string number))))
    (case (string-ref mode 0)
      (#\H (hex->dec num))
      (#\O (oct->dec num))
      (#\C (char->integer (string-ref num 0))))))

(define (list->sentence low)
  (if (= (length low) 1)
      (if (number? (car low))
	  (number->string (car low))
	  (symbol->string (car low)))
      (string-append (if (number? (car low))
			 (number->string (car low))
			 (symbol->string (car low)))
		     " "
		     (list->sentence (cdr low)))))

(define nextitem '())
(define pl-fontdsize "")

;;
;; pl-read-header
;;
;; liest den pl-file header bis zum ersten CHARACTER ein
;; LIGTABLE wird geloescht!!!
(define (pl-read-header inf outf designsize)
  (let ((ni (if (= (length nextitem) 0)
		(let ((tmp (read inf)))
		  (if (eof-object? tmp)
		      (error 'pl-read-header "Cannot read from Infile")
		      tmp))
		nextitem)))
    (let ((tag (symbol->string (car ni))))
      (cond
       ((or (string=? tag "FAMILY")
	    (string=? tag "COMMENT"))
	(format outf "~a~%" ni)
	(set! nextitem '())
	(pl-read-header inf outf designsize))
       ((string=? tag "FONTDIMEN")
	(set! nextitem '())
	(format outf "(FONTDIMEN~%~a   )~%"
		(list-entries->string (cdr ni) "   "))
	(pl-read-header inf outf designsize))
       ((string=? tag "DESIGNSIZE")
	(set! nextitem '())
	(set! pl-fontdsize (number->string (caddr ni)))
	(format outf "(DESIGNSIZE R ~a)~%" designsize)
	(pl-read-header inf outf designsize))
       ((string=? tag "CODINGSCHEME")
	(format outf "(CODINGSCHEME SHIFTED ~a)~%" (list->sentence (cdr ni)))
	(set! nextitem '())
	(pl-read-header inf outf designsize))
       ((string=? tag "CHARACTER")
	(set! nextitem ni))
       (else
	(set! nextitem '())
	(pl-read-header inf outf designsize))))))


(define (ovp-write-font-mapping outf fontname fontat fontdsize)
  (format outf "(MAPFONT D 0~%   (FONTNAME ~a)~%   (FONTAT R ~a)~%   (FONTDSIZE R ~a)~%   )~%" fontname fontat fontdsize))

(define (list-entries->string lst head)
  (if (= (length lst) 0)
      ""
      (string-append (format #f "~a~a~%" head (car lst))
		     (list-entries->string (cdr lst) head))))

(define (pl-read-character inf outf shift)
  (let ((ni (if (= (length nextitem) 0)
		(read inf)
		nextitem)))
    (if (eof-object? ni)
	#t
	(letrec ((tag (symbol->string (car ni)))
		 (mode (symbol->string (cadr ni)))
		 (val (caddr ni))
		 (decval (convert-to-dec val mode))
		 (rs (if (number? shift) shift
			 (let ((tmp (string->number shift)))
			   (if (integer? tmp) tmp
			       (error 'pl-read-character "Shift not an integer: ~a." shift)))))
		 (restlst (cdddr ni)))
	  (if (not (string=? tag "CHARACTER"))
	      (error 'pl-read-character "Tag ~a wrong, not CHARACTER." tag)
	      (begin
		(format outf
			"(~a H ~a~%~a   (MAP~%      (SELECTFONT D 0)~%      (SETCHAR ~a ~a)~%      )~%   )~%"
			tag
			(dec->hex (+ decval rs))
			(list-entries->string restlst "   ")
			mode
			val)
		(set! nextitem '())
		(pl-read-character inf outf shift)))))))

(define (basename file ext)
  (letrec ((fl (string-length file))
	   (el (string-length ext))
	   (bi (- fl el))
	   (ei fl))
    (begin
      (if (string=? (substring file bi ei) ext)
	  (substring file 0 bi)
	  file))))

;;
;; MAIN FUNCTION
;;
;; pl->ovp pl-filename ovp-filename shift ovp-designsize pl-at
;;
;; pl-filename      The name (with or without extansion) of the input
;; ovp-filename     The name (with or without extension) of the output
;; shift            The value a character in pl-filename will be shifted
;;                  e.g.: in pl: (CHARACTER H 23 ...)
;;                        shift = (hex->dec "1000")
;;                        -> in ovp (CHARACTER H 1023 ... SETCHAR H 23 ...)
;; ovp-designsize   (DESIGNSIZE ...)
;; pl-at            (MAPFONT D 0 ...(FONTAT ...))
;; 
(define (pl->ovp pl-filename ovp-filename shift ovp-designsize pl-at)
  (letrec ((ifnb (basename pl-filename ".pl"))
	   (ofnb (basename ovp-filename ".ovp"))
	   (ifn (string-append ifnb ".pl"))
	   (ofn (string-append ofnb ".ovp"))
	   (inf (open-input-file ifn))
	   (outf (open-output-file ofn)))
    (pl-read-header inf outf ovp-designsize)
    (ovp-write-font-mapping outf
			    ifnb
			    pl-at
			    pl-fontdsize)
    (pl-read-character inf outf shift)
    (close-input-port inf)
    (close-output-port outf)))

; eof