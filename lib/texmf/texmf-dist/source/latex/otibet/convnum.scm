;;
;; numconv.scm
;; (c) Norbert Preining 1997
;; This file is part of the otibet-package.
;;
;; Converting hex <-> dec <-> oct values
;; hex, oct are STRINGS!!!
;; dec is INTEGER
;;
;; Provides:
;;    (dec->hex INTEGER) -> STRING
;;    (dec->oct INTEGER) -> STRING
;;    (hex->dec STRING) -> INTEGER
;;    (oct->dec STRING) -> INTEGER
;;    (oct->hex STRING) -> STRING
;;    (hex->oct STRING) -> STRING
;;
;; Comment: Not very effective, just a quick hack.
;;
(define (number->hex-digit n)
  (if (and (integer? n) (> n -1) (< n 16))
      (if (< n 10)
	  (string (integer->char (+ n (char->integer #\0))))
	  (string (integer->char (+ n (char->integer #\A) -10))))
      (error 'number->hex-digit 
	     "Argument ~a not a integer or out of range!" n)))

(define (hex-digit->number h)
  (let ((n (- (char->integer (string-ref h 0)) 65)))
    (if (< n 0)
	(+ n 17)
	(+ n 10))))

(define (number->oct-digit n)
  (if (and (integer? n) (> n -1) (< n 8))
      (string (integer->char (+ n (char->integer #\0))))
      (error 'number->oct-digit 
	     "Argument ~a not a integer or out of range!" n)))

(define (oct-digit->number h)
  (- (char->integer (string-ref h 0)) (char->integer #\0)))

(define (dec->hex n)
  (if (= n 0)
      ""
      (letrec ((rem (modulo n 16))
	       (rval (/ (- n rem) 16)))
	(string-append (dec->hex rval) (number->hex-digit rem)))))

(define (hex-list->dec x)
  (if (= (length x) 0)
      0
      (+ (* 16 (hex-list->dec (cdr x))) 
	 (hex-digit->number (string (car x))))))

(define (hex->dec x)
  (hex-list->dec (reverse (string->list x))))

(define (dec->oct n)
  (if (= n 0)
      ""
      (letrec ((rem (modulo n 8))
	       (rval (/ (- n rem) 8)))
	(string-append (dec->oct rval) (number->oct-digit rem)))))

(define (oct-list->dec x)
  (if (= (length x) 0)
      0
      (+ (* 8 (oct-list->dec (cdr x))) 
	 (oct-digit->number (string (car x))))))

(define (oct->dec x)
  (oct-list->dec (reverse (string->list x))))

(define (hex->oct x)
  (dec->oct (hex->dec x)))

(define (oct->hex x)
  (dec->hex (oct->dec x)))