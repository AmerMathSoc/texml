;;; $Id: rcs.el,v 1.6 1995/08/02 10:59:53 schrod Exp $
;;;----------------------------------------------------------------------

;;;
;;; AUC-TeX style hook for rcs style option
;;;
;;; (history at end)


(TeX-add-style-hook "rcs"
  (function
   (lambda ()
     (LaTeX-add-environments "rcslog")
     (TeX-add-symbols
       ;; public interface
       "RCS"				; define \RCS... tag
       "RCSTime"			; holds time of Date field
       "RCSdate"			; typeset date
       "RCSID"				; put RCS field in footline
       "RCSdef"				; like \RCS, & output on console
       "settime"			; local in env rcslog: set rev time
       "rcsAuthor"			; maps uid to full name
       "rcsLogIntro"			; intro text to rev log
       ;; protected interface
       "RcsEmptyValue"			; used as value for unexpanded fields
       "RcsHandleDate"			; handler for Date field
       "RcsLogStyle"			; define style of RCS log
       "RcsLogListStyle"		; define style of log list
       "RcsLogHeading"			; heading of RCS log
       "RcsLogDate"			; how the date is typeset
       "RcsLogTime"			; how the time is typeset
       ;; internationalization
       "RcsLogHeadingName"		; text in heading of RCS log
       "RcsUnknownFile"			; used if Log value is empty
       "RcsEmptyLog"			; used as empty Log text
       "RcsLogRevision"			; `real name' of \Revision
       ;; protected observers -- must not be redefined
       "RCS_keyword"			; keyword of last parsed field
       "RCS_value"			; value of last parsed field
       "RCS_get_author"			; get the full name of an author
       )
     )))


;;;======================================================================
;;
;; $Log: rcs.el,v $
;; Revision 1.6  1995/08/02  10:59:53  schrod
;;     \RcsLoadHook & \RcsLoaded don't exist any more.
;;
;; Revision 1.5  1993/11/08  20:17:18  schrod
;;     New tag in protected interface: \RcsLogListStyle
;;
;; Revision 1.4  1993/11/02  21:10:22  schrod
;;     New tag in public interface: \RCSdef
;;
;; Revision 1.3  1993/11/02  18:45:43  schrod
;;     New tag in public interface: \RCSID
;;
;; Revision 1.2  1993/11/02  16:15:08  schrod
;;     Adapted to interface of StyleRevision 2.3.
;;
;; Revision 1.1  1993/10/29  18:14:47  schrod
;;     Preliminary version, doesn't care about macro args.
;;
