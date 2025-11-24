;;
;; tibovp.scm
;; (c) Norbert Preining 1997
;; This file is part of the otibet-package.
;;
;; Generating the otibetan.ovp file.

(load 'pl2ovp.scm)

;
; args:
;   1: from file tibetan.pl (tibetan also teh name in the MAPFONT)
;   2: to file otibetan.ovp
;   3: shift the characters
;   4: FontDesignSize Value of the ovp-file
;   5: FontAt Value of the MAPFONT entry
(pl->ovp "tibetan" "otibetan" (hex->dec "1000") "10.0" "1.0")

(exit)
