;;; cjk-enc.el --- provide a coding system for LaTeX2e CJK package

;; Copyright (C) 1996-2000 Electrotechnical Laboratory, JAPAN.

;; Author: Kenichi HANDA <handa@etl.go.jp>
;;         Werner LEMBERG <wl@gnu.org>
;;         Hin-Tak Leung <htl10@users.sourceforge.net>

;; Keywords: CJK package, LaTeX2e, emacs, xemacs

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.

;;
;; CJK Version 4.8.4 (18-Apr-2015)
;;

;;; Code

;; This file will work with both Emacs (>=20.3) and XEmacs (>=21).  In
;; the following `Emacs' is used for both Emacs and XEmacs except where
;; it differs.

;; XXX: Thai stuff not yet ported to XEmacs.  I don't know whether it
;; makes sense currently to support it because the Thai implementation
;; in XEmacs (version 21.1 and probably the upcoming 21.2) is not
;; complete: For example, there is no correct display handling of IR
;; 166 (this is the right part of TIS-620) in an ISO-2022 data stream,
;; decomposition of precomposed Thai (in xtis character set) doesn't
;; provide linguistic properties, etc.

;; The following tables map from Emacs's character sets to LaTeX2e
;; macros.  Note that not all macros defined here really do exist.  See
;; MULEenc.sty and cjk-enc.txt for further details.
;;
;; MULEenc.sty makes TeX character 0x7F `active' and assigns to it a
;; multiplex command which executes its first argument.  To make the
;; macro expansion robust against \uppercase and \lowercase, only
;; numbers are used as parameters which index the various commands.
;;
;; 0x7F will be used as a parameter delimiting character also.
;;
(defconst cjk-latin-1
  [;0xa0
   "99\177"     "1\177"     "2\177"     "3\177"
   "4\177"      "5\177"     "6\177"     "7\177"
   "8\177\\ "   "9\177"     "10\177"    "11\177"
   "12\177"     "0\177-{}"  "14\177"    "15\177\\ "

   ; 0xb0
   "16\177"     "17\177"    "18\177"    "19\177"
   "20\177\\ "  "21\177"    "22\177"    "23\177"
   "24\177\\ "  "25\177"    "26\177"    "27\177"
   "28\177"     "29\177"    "30\177"    "31\177"

   ; 0xc0
   "32\177A"    "20\177A"   "33\177A"   "34\177A"
   "8\177A"     "0\177\\AA" "0\177\\AE" "24\177C"
   "32\177E"    "20\177E"   "33\177E"   "8\177E"
   "32\177I"    "20\177I"   "33\177I"   "8\177I"

   ; 0xd0
   "0\177\\DJ"  "34\177N"   "32\177O"   "20\177O"
   "33\177O"    "34\177O"   "8\177O"    "38\177"
   "0\177\\O"   "32\177U"   "20\177U"   "33\177U"
   "8\177U"     "20\177Y"   "0\177\\TH" "0\177\\ss"

   ; 0xe0
   "32\177a"    "20\177a"   "33\177a"   "34\177a"
   "8\177a"     "0\177\\aa" "0\177\\ae" "24\177c"
   "32\177e"    "20\177e"   "33\177e"   "8\177e"
   "32\177\\i"  "20\177\\i" "33\177\\i" "8\177\\i"

   ; 0xf0
   "0\177\\dj"  "34\177n"   "32\177o"   "20\177o"
   "33\177o"    "34\177o"   "8\177o"    "45\177"
   "0\177\\o"   "32\177u"   "20\177u"   "33\177u"
   "8\177u"     "20\177y"   "0\177\\th" "8\177y"
  ])

(defconst cjk-latin-2
  [; 0xa0
   "99\177"     "48\177A"   "49\177\\ " "0\177\\L"
   "4\177"      "51\177L"   "20\177S"   "7\177"
   "8\177\\ "   "51\177S"   "24\177S"   "51\177T"
   "20\177Z"    "0\177-{}"  "51\177Z"   "52\177Z"

   ; 0xb0
   "16\177"     "48\177a"   "48\177\\ " "0\177\\l"
   "20\177\\ "  "51\177l"   "20\177s"   "51\177\\ "
   "24\177\\ "  "51\177s"   "24\177s"   "51\177t"
   "20\177z"    "55\177\\ " "51\177z"   "52\177z"

   ; 0xc0
   "20\177R"    "20\177A"   "33\177A"   "49\177A"
   "8\177A"     "20\177L"   "20\177C"   "24\177C"
   "51\177C"    "20\177E"   "48\177E"   "8\177E"
   "51\177E"    "20\177I"   "33\177I"   "51\177D"

   ; 0xd0
   "0\177\\DJ"  "20\177N"   "51\177N"   "20\177O"
   "33\177O"    "55\177O"   "8\177O"    "38\177"
   "51\177R"    "53\177U"   "20\177U"   "55\177U"
   "8\177U"     "20\177Y"   "24\177T"   "0\177\\ss"

   ; 0xe0
   "20\177r"    "20\177a"   "33\177a"   "49\177a"
   "8\177a"     "20\177l"   "20\177c"   "24\177c"
   "51\177c"    "20\177e"   "48\177e"   "8\177e"
   "51\177e"    "20\177\\i" "33\177\\i" "51\177d"

   ; 0xf0
   "0\177\\dj"  "20\177n"   "51\177n"   "20\177o"
   "33\177o"    "55\177o"   "8\177o"    "45\177"
   "51\177r"    "53\177u"   "20\177u"   "55\177u"
   "8\177u"     "20\177y"   "24\177t"   "52\177\\ "
  ])

(defconst cjk-latin-3
  [; 0xa0
   "99\177"     "0\177\\TEXTMALTESEH"   "49\177\\ " "3\177"
   "4\177"      ""                      "33\177H"   "7\177"
   "8\177\\ "   "52\177I"               "24\177S"   "49\177G"
   "33\177J"    "0\177-{}"              ""          "52\177Z"

   ; 0xb0
   "16\177"     "0\177\\textmalteseh"   "18\177"    "19\177"
   "20\177\\ "  "21\177"                "33\177h"   "23\177"
   "24\177\\ "  "0\177\\i"              "24\177s"   "49\177g"
   "33\177\\j"  "29\177"                ""          "52\177z"

   ; 0xc0
   "32\177A"    "20\177A"               "33\177A"   ""
   "8\177A"     "52\177C"               "33\177C"   "24\177C"
   "32\177E"    "20\177E"               "33\177E"   "8\177E"
   "32\177I"    "20\177I"               "33\177I"   "8\177I"

   ; 0xd0
   ""           "34\177N"               "32\177O"   "20\177O"
   "33\177O"    "52\177G"               "8\177O"    "38\177"
   "33\177G"    "32\177U"               "20\177U"   "33\177U"
   "8\177U"     "49\177U"               "33\177S"   "0\177\\ss"

   ; 0xe0
   "32\177a"    "20\177a"               "33\177a"   ""
   "8\177a"     "52\177c"               "33\177c"   "24\177c"
   "32\177e"    "20\177e"               "33\177e"   "8\177e"
   "32\177\\i"  "20\177\\i"             "33\177\\i" "8\177\\i"

   ; 0xf0
   ""           "34\177n"               "32\177o"   "20\177o"
   "33\177o"    "52\177g"               "8\177o"    "45\177"
   "33\177g"    "32\177u"               "20\177u"   "33\177u"
   "8\177u"     "49\177u"               "33\177s"   "52\177\\ "
  ])

(defconst cjk-latin-4
  [; 0xa0
   "99\177"             "48\177A"   "59\177"    "24\177R"
   "4\177"              "34\177I"   "24\177L"   "7\177"
   "8\177\\ "           "51\177S"   "15\177E"   "24\177G"
   "0\177\\TEXTTSTROKE" "0\177-{}"  "51\177Z"   "15\177\\ "

   ; 0xb0
   "16\177"             "48\177a"   "48\177\\ " "24\177r"
   "20\177\\ "          "34\177\\i" "24\177l"   "51\177\\ "
   "24\177\\ "          "51\177s"   "15\177e"   "24\177g"
   "0\177\\texttstroke" "0\177\\NG" "51\177z"   "0\177\\ng"

   ; 0xc0
   "15\177A"            "20\177A"   "33\177A"   "34\177A"
   "8\177A"             "0\177\\AA" "0\177\\AE" "48\177I"
   "51\177C"            "20\177E"   "48\177E"   "8\177E"
   "52\177E"            "20\177I"   "33\177I"   "15\177I"

   ; 0xd0
   "0\177\\DJ"          "24\177N"   "15\177O"   "24\177K"
   "33\177O"            "34\177O"   "8\177O"    "38\177"
   "0\177\\O"           "48\177U"   "20\177U"   "33\177U"
   "8\177U"             "34\177U"   "15\177U"   "0\177\\ss"

   ; 0xe0
   "15\177a"            "20\177a"   "33\177a"   "34\177a"
   "8\177a"             "0\177\\aa" "0\177\\ae" "48\177i"
   "51\177c"            "20\177e"   "48\177e"   "8\177e"
   "52\177e"            "20\177\\i" "33\177\\i" "15\177\\i"

   ; 0xf0
   "0\177\\dj"          "24\177n"   "15\177o"   "24\177k"
   "33\177o"            "34\177o"   "8\177o"    "45\177"
   "0\177\\o"           "48\177u"   "20\177u"   "33\177u"
   "8\177u"             "34\177u"   "15\177u"   "52\177\\ "
  ])

(defconst cjk-latin-5           ; ISO 8859-9
  [; 0xa0
   "99\177"     "1\177"     "2\177"     "3\177"
   "4\177"      "5\177"     "6\177"     "7\177"
   "8\177\\ "   "9\177"     "10\177"    "11\177"
   "12\177"     "0\177-{}"  "14\177"    "15\177\\ "

   ; 0xb0
   "16\177"     "17\177"    "18\177"    "19\177"
   "20\177\\ "  "21\177"    "22\177"    "23\177"
   "24\177\\ "  "25\177"    "26\177"    "27\177"
   "28\177"     "29\177"    "30\177"    "31\177"

   ; 0xc0
   "32\177A"    "20\177A"   "33\177A"   "34\177A"
   "8\177A"     "0\177\\AA" "0\177\\AE" "24\177C"
   "32\177E"    "20\177E"   "33\177E"   "8\177E"
   "32\177I"    "20\177I"   "33\177I"   "8\177I"

   ; 0xd0
   "49\177G"    "34\177N"   "32\177O"   "20\177O"
   "33\177O"    "34\177O"   "8\177O"    "38\177"
   "0\177\\O"   "32\177U"   "20\177U"   "33\177U"
   "8\177U"     "52\177I"   "24\177S"   "0\177\\ss"

   ; 0xe0
   "32\177a"    "20\177a"   "33\177a"   "34\177a"
   "8\177a"     "0\177\\aa" "0\177\\ae" "24\177c"
   "32\177e"    "20\177e"   "33\177e"   "8\177e"
   "32\177\\i"  "20\177\\i" "33\177\\i" "8\177\\i"

   ; 0xf0
   "49\177g"    "34\177n"   "32\177o"   "20\177o"
   "33\177o"    "34\177o"   "8\177o"    "45\177"
   "0\177\\o"   "32\177u"   "20\177u"   "33\177u"
   "8\177u"     "0\177\\i"  "24\177s"   "8\177y"
  ])

(defconst cjk-latin-jisx        ; JIS X 0201 lower half
  [; 0xa0
   ""       "0\177!"   "37\177"   "0\177\\#"
   "39\177" "0\177\\%" "0\177\\&" "40\177"
   "0\177(" "0\177)"   "0\177*"   "0\177+"
   "0\177," "0\177-"   "0\177."   "0\177/"

   ; 0xb0
   "0\1770" "0\1771" "0\1772" "0\1773"
   "0\1774" "0\1775" "0\1776" "0\1777"
   "0\1778" "0\1779" "0\177:" "0\177;"
   "41\177" "0\177=" "42\177" "0\177?"

   ; 0xc0
   "36\177" "0\177A" "0\177B" "0\177C"
   "0\177D" "0\177E" "0\177F" "0\177G"
   "0\177H" "0\177I" "0\177J" "0\177K"
   "0\177L" "0\177M" "0\177N" "0\177O"

   ; 0xd0
   "0\177P" "0\177Q" "0\177R" "0\177S"
   "0\177T" "0\177U" "0\177V" "0\177W"
   "0\177X" "0\177Y" "0\177Z" "0\177["
   "5\177"  "0\177]" "43\177" "44\177"

   ; 0xe0
   "46\177" "0\177a" "0\177b" "0\177c"
   "0\177d" "0\177e" "0\177f" "0\177g"
   "0\177h" "0\177i" "0\177j" "0\177k"
   "0\177l" "0\177m" "0\177n" "0\177o"

   ; 0xf0
   "0\177p" "0\177q" "0\177r" "0\177s"
   "0\177t" "0\177u" "0\177v" "0\177w"
   "0\177x" "0\177y" "0\177z" "47\177"
   "50\177" "54\177" "56\177" ""
  ])

(defconst cjk-cyrillic          ; ISO 8859-5
  [; 0xa0
   "99\177"          "0\177\\CYRYO"       "0\177\\CYRDJE"      "20\177\\CYRG"
   "0\177\\CYRIE"    "0\177\\CYRDZE"      "0\177\\CYRII"       "0\177\\CYRYI"
   "0\177\\CYRJE"    "0\177\\CYRLJE"      "0\177\\CYRNJE"      "0\177\\CYRTSHE"
   "20\177\\CYRK"    "0\177-{}"           "0\177\\CYRUSHRT"    "0\177\\CYRDZHE"

   ; 0xb0
   "0\177\\CYRA"     "0\177\\CYRB"        "0\177\\CYRV"        "0\177\\CYRG"
   "0\177\\CYRD"     "0\177\\CYRE"        "0\177\\CYRZH"       "0\177\\CYRZ"
   "0\177\\CYRI"     "0\177\\CYRISHRT"    "0\177\\CYRK"        "0\177\\CYRL"
   "0\177\\CYRM"     "0\177\\CYRN"        "0\177\\CYRO"        "0\177\\CYRP"

   ; 0xc0
   "0\177\\CYRR"     "0\177\\CYRS"        "0\177\\CYRT"        "0\177\\CYRU"
   "0\177\\CYRF"     "0\177\\CYRH"        "0\177\\CYRC"        "0\177\\CYRCH"
   "0\177\\CYRSH"    "0\177\\CYRSHCH"     "0\177\\CYRHRDSN"    "0\177\\CYRERY"
   "0\177\\CYRSFTSN" "0\177\\CYREREV"     "0\177\\CYRYU"       "0\177\\CYRYA"

   ; 0xd0
   "0\177\\cyra"     "0\177\\cyrb"        "0\177\\cyrv"        "0\177\\cyrg"
   "0\177\\cyrd"     "0\177\\cyre"        "0\177\\cyrzh"       "0\177\\cyrz"
   "0\177\\cyri"     "0\177\\cyrishrt"    "0\177\\cyrk"        "0\177\\cyrl"
   "0\177\\cyrm"     "0\177\\cyrn"        "0\177\\cyro"        "0\177\\cyrp"

   ; 0xe0
   "0\177\\cyrr"     "0\177\\cyrs"        "0\177\\cyrt"        "0\177\\cyru"
   "0\177\\cyrf"     "0\177\\cyrh"        "0\177\\cyrc"        "0\177\\cyrch"
   "0\177\\cyrsh"    "0\177\\cyrshch"     "0\177\\cyrhrdsn"    "0\177\\cyrery"
   "0\177\\cyrsftsn" "0\177\\cyrerev"     "0\177\\cyryu"       "0\177\\cyrya"

   ; 0xf0
   "35\177"          "0\177\\cyryo"       "0\177\\cyrdje"      "20\177\\cyrg"
   "0\177\\cyrie"    "0\177\\cyrdze"      "0\177\\cyrii"       "0\177\\cyryi"
   "0\177\\cyrje"    "0\177\\cyrlje"      "0\177\\cyrnje"      "0\177\\cyrtshe"
   "20\177\\cyrk"    "7\177"              "0\177\\cyrushrt"    "0\177\\cyrdzhe"
  ])

(defconst cjk-greek             ; ISO 8859-7
  [;0xa0
   "99\177"     "0\177<{}"   "0\177>{}"  "3\177"
   ""           ""           "6\177"     "7\177"
   "8\177\\ "   "9\177"      ""          "0\177(("
   "12\177"     "0\177-{}"   ""          "0\177---"

   ; 0xb0
   "16\177"     "17\177"     "18\177"    "19\177"
   "0\177'{}"   "0\177\"'{}" "0\177'A"   "0\177;"
   "0\177'E"    "0\177'H"    "0\177'I"   "0\177))"
   "0\177'O"    "29\177"     "0\177'U"   "0\177'W"

   ; 0xc0
   "0\177\"'i"  "0\177A"     "0\177B"    "0\177G"
   "0\177D"     "0\177E"     "0\177Z"    "0\177H"
   "0\177J"     "0\177I"     "0\177K"    "0\177L"
   "0\177M"     "0\177N"     "0\177X"    "0\177O"

   ; 0xd0
   "0\177P"     "0\177R"     ""          "0\177S"
   "0\177T"     "0\177U"     "0\177F"    "0\177Q"
   "0\177Y"     "0\177W"     "0\177\"I"  "0\177\"U"
   "0\177'a"    "0\177'e"    "0\177'h"   "0\177'i"

   ; 0xe0
   "0\177\"'u"  "0\177a"     "0\177b"    "0\177g"
   "0\177d"     "0\177e"     "0\177z"    "0\177h"
   "0\177j"     "0\177i"     "0\177k"    "0\177l"
   "0\177m"     "0\177n"     "0\177x"    "0\177o"

   ; 0xf0
   "0\177p"     "0\177r"     "0\177c"    "0\177s"
   "0\177t"     "0\177u"     "0\177f"    "0\177q"
   "0\177y"     "0\177w"     "0\177\"i"  "0\177\"u"
   "0\177'o"    "0\177'u"    "0\177'w"   ""
  ])

(defconst cjk-viscii-lower
  [; 0xA0
   ""                    "20\177\\abreve"      "32\177\\abreve"      "71\177\\abreve"
   "20\177\\acircumflex" "32\177\\acircumflex" "73\177\\acircumflex" "71\177\\acircumflex"
   "34\177e"             "71\177e"             "20\177\\ecircumflex" "32\177\\ecircumflex"
   "73\177\\ecircumflex" "34\177\\ecircumflex" "71\177\\ecircumflex" "20\177\\ocircumflex"

   ; 0xB0
   "32\177\\ocircumflex" "73\177\\ocircumflex" "34\177\\ocircumflex" ""
   ""                    "71\177\\ocircumflex" "32\177\\ohorn"       "73\177\\ohorn"
   "71\177i"             ""                    ""                    ""
   ""                    "0\177\\ohorn"        "20\177\\ohorn"       ""

   ; 0xC0
   ""                    ""                    ""                    ""
   ""                    ""                    "73\177\\abreve"      "34\177\\abreve"
   ""                    ""                    ""                    ""
   ""                    ""                    ""                    "32\177y"

   ; 0xD0
   ""                    "20\177\\uhorn"       ""                    ""
   ""                    "71\177a"             "73\177y"             "32\177\\uhorn"
   "73\177\\uhorn"       ""                    ""                    "34\177y"
   "71\177y"             ""                    "34\177\\ohorn"       "0\177\\uhorn"

   ; 0xE0
   "32\177a"             "20\177a"             "0\177\\acircumflex"  "34\177a"
   "73\177a"             "0\177\\abreve"       "34\177\\uhorn"       "34\177\\acircumflex"
   "32\177e"             "20\177e"             "0\177\\ecircumflex"  "73\177e"
   "32\177i"             "20\177i"             "34\177i"             "73\177i"

   ; 0xF0
   "0\177\\dj"           "71\177\\uhorn"       "32\177o"             "20\177o"
   "0\177\\ocircumflex"  "34\177o"             "73\177o"             "71\177o"
   "71\177u"             "32\177u"             "20\177u"             "34\177u"
   "73\177u"             "20\177y"             "71\177\\ohorn"       ""
  ])

(defconst cjk-viscii-upper
  [; 0xA0
   ""                    "20\177\\ABREVE"      "32\177\\ABREVE"      "71\177\\ABREVE"
   "20\177\\ACIRCUMFLEX" "32\177\\ACIRCUMFLEX" "73\177\\ACIRCUMFLEX" "71\177\\ACIRCUMFLEX"
   "34\177E"             "71\177E"             "20\177\\ECIRCUMFLEX" "32\177\\ECIRCUMFLEX"
   "73\177\\ECIRCUMFLEX" "34\177\\ECIRCUMFLEX" "71\177\\ECIRCUMFLEX" "20\177\\OCIRCUMFLEX"

   ; 0xB0
   "32\177\\OCIRCUMFLEX" "73\177\\OCIRCUMFLEX" "34\177\\OCIRCUMFLEX" ""
   ""                    "71\177\\OCIRCUMFLEX" "32\177\\OHORN"       "73\177\\OHORN"
   "71\177I"             ""                    ""                    ""
   ""                    "0\177\\OHORN"        "20\177\\OHORN"       ""

   ; 0xC0
   ""                    ""                    ""                    ""
   ""                    ""                    "73\177\\ABREVE"      "34\177\\ABREVE"
   ""                    ""                    ""                    ""
   ""                    ""                    ""                    "32\177Y"

   ; 0xD0
   ""                    "20\177\\UHORN"       ""                    ""
   ""                    "71\177A"             "73\177Y"             "32\177\\UHORN"
   "73\177\\UHORN"       ""                    ""                    "34\177Y"
   "71\177Y"             ""                    "34\177\\OHORN"       "0\177\\UHORN"

   ; 0xE0
   "32\177A"             "20\177A"             "0\177\\ACIRCUMFLEX"  "34\177A"
   "73\177A"             "0\177\\ABREVE"       "34\177\\UHORN"       "34\177\\ACIRCUMFLEX"
   "32\177E"             "20\177E"             "0\177\\ECIRCUMFLEX"  "73\177E"
   "32\177I"             "20\177I"             "34\177I"             "73\177I"

   ; 0xF0
   "0\177\\DJ"           "71\177\\UHORN"       "32\177O"             "20\177O"
   "0\177\\OCIRCUMFLEX"  "34\177O"             "73\177O"             "71\177O"
   "71\177U"             "32\177U"             "20\177U"             "34\177U"
   "73\177U"             "20\177Y"             "71\177\\OHORN"       ""
  ])


;; The following encodings will be selected (if they occur in the input
;; buffer) at the very beginning of the output buffer to load the
;; corresponding CJK macros.
;;
(defconst cjk-enc-table
  '((chinese-gb2312 . GB)
    (katakana-jisx0201 . SJIS)
    (japanese-jisx0208 . JIS)
    (japanese-jisx0212 . JIS2)
    (korean-ksc5601 . KS)
    (chinese-big5-1 . Bg5)
    (chinese-big5-2 . Bg5)
    (chinese-cns11643-1 . CNS1)
    (chinese-cns11643-2 . CNS2)
    (chinese-cns11643-3 . CNS3)
    (chinese-cns11643-4 . CNS4)
    (chinese-cns11643-5 . CNS5)
    (chinese-cns11643-6 . CNS6)
    (chinese-cns11643-7 . CNS7)))


;; MULEenc's versions of \CJKspace and \CJKnospace
;;
(defconst cjk-space "\17764\177\177")
(defconst cjk-nospace "\17765\177\177")

;; MULEenc's command to insert a word break.
;;
(defconst cjk-word-break "\17761\177\177")


;; Here we have the format specification table which defines what to do
;; for each encoding.
;;
;; Later in the code we check to which group of commands the encoding
;; belongs.  This is done by testing how the encoding and its data is
;; stored, e.g. whether it is a vector, or a cons cell, etc.
;;
(defconst cjk-format-spec-table
  `(
    ;; Cdr part is a vector VEC.  Each character is formatted as:
    ;;
    ;;   (format "\177%s\177" (aref VEC (- char-position-code-1 32)))
    ;;
    (latin-iso8859-1 . ,cjk-latin-1)
    (latin-iso8859-2 . ,cjk-latin-2)
    (latin-iso8859-3 . ,cjk-latin-3)
    (latin-iso8859-4 . ,cjk-latin-4)
    (latin-iso8859-9 . ,cjk-latin-5)
    (latin-jisx0201  . ,cjk-latin-jisx)
    ;; T2A encoding is used for Cyrillic letters.  You must explicitly
    ;; switch between T2 and T1/OT1 encoding.
    (cyrillic-iso8859-5 . ,cjk-cyrillic)
    ;; LGR encoding (resp. its ligatures) is used for Greek letters.
    ;; You must explicitly switch between LGR and T1/OT1 encoding (using
    ;; e.g. Babel's `greek' option).
    (greek-iso8859-7 . ,cjk-greek)
    ;; For Vietnamese a Vietnamese TeX-font has to be used which
    ;; contains ASCII characters too!  You must explicitly switch
    ;; between Vietnamese T5 and T1/OT1 encoding.
    (vietnamese-viscii-lower . ,cjk-viscii-lower)
    (vietnamese-viscii-upper . ,cjk-viscii-upper)

    ;; Cdr part is a cons of header HEAD and formatter FORMAT.  HEAD is
    ;; printed first, then each character is formatted as:
    ;;
    ;;   (format FORMAT char-code-1 [char-code-2])
    ;;
    (katakana-jisx0201 . ("\17770\177\177" . "\177%c\177\177"))
    (japanese-jisx0208 . ("\17766\177\177" . "\177%c\177%d\177"))
    (chinese-gb2312    . ("\17767\177\177" . "\177%c\177%d\177"))
    (chinese-big5-1    . ("\17768\177\177" . "\177%c\177%d\177"))
    (chinese-big5-2    . ("\17768\177\177" . "\177%c\177%d\177"))
    (korean-ksc5601    . ("\17769\177\177" . "\177%c\177%d\177"))

    ;; Cdr part is a formatter string FORMAT.  Each character is
    ;; formatted as:
    ;;
    ;;   (format FORMAT char-code-1 char-code-2)
    ;;
    (japanese-jisx0212  . "\17772\177JIS2\177\177%d\177%d\177")
    (chinese-cns11643-1 . "\17772\177CNS1\177\177%d\177%d\177")
    (chinese-cns11643-2 . "\17772\177CNS2\177\177%d\177%d\177")
    (chinese-cns11643-3 . "\17772\177CNS3\177\177%d\177%d\177")
    (chinese-cns11643-4 . "\17772\177CNS4\177\177%d\177%d\177")
    (chinese-cns11643-5 . "\17772\177CNS5\177\177%d\177%d\177")
    (chinese-cns11643-6 . "\17772\177CNS6\177\177%d\177%d\177")
    (chinese-cns11643-7 . "\17772\177CNS7\177\177%d\177%d\177")

    ;; Cdr part is a list of the form (SYMBOL ARG1 ARG2 ...).  SYMBOL
    ;; indicates how to process the following characters.
    ;;
    (thai-tis620 . (thai
                    "\17757\177\177"    ; Thai start
                    "\17758\177\177"    ; Thai end
                    "\17762\177%d\177"  ; Thai base character
                    "\17760\177%d\177"  ; Thai upper/lower vowel and tone
                    "\17763\177\177"    ; Thai EOL
                    ))
    ))


;; An alist of charsets vs list of features required for processing
;; the corresponding charset.  The feature is loaded then on demand.
;;
(defconst cjk-feature-table
  '((thai-tis620 thai-word)))


;; Create an output encoding called `cjk-coding', using the function
;; cjk-encode to actually convert the output.
;;
(if (featurep 'xemacs)
    (make-coding-system
     'cjk-coding 'no-conversion
     "Coding-system for LaTeX2e CJK Package"
     '(mnemonic "CJK"
       pre-write-conversion cjk-encode))
  (if (< emacs-major-version 23)
      (make-coding-system
       'cjk-coding 0 ?c
       "Coding-system for LaTeX2e CJK Package"
       nil
       '((pre-write-conversion . cjk-encode)))
    (define-coding-system
      'cjk-coding
      "Coding-system for LaTeX2e CJK Package"
      :mnemonic ?c
      :coding-type 'emacs-mule
      :default-char ?
      :charset-list '(ascii
                      latin-iso8859-1
                      latin-iso8859-2
                      latin-iso8859-3
                      latin-iso8859-4
                      cyrillic-iso8859-5
                      greek-iso8859-7
                      thai-tis620
                      vietnamese-viscii-lower
                      vietnamese-viscii-upper
                      latin-jisx0201
                      katakana-jisx0201
                      japanese-jisx0208
                      japanese-jisx0212
                      korean-ksc5601
                      chinese-gb2312
                      chinese-big5-1
                      chinese-big5-2
                      chinese-cns11643-1
                      chinese-cns11643-2
                      chinese-cns11643-3
                      chinese-cns11643-4
                      chinese-cns11643-5
                      chinese-cns11643-6
                      chinese-cns11643-7)
      :pre-write-conversion 'cjk-encode)))

;; XEmacs doesn't have set-buffer-multibyte.
;;
(defmacro cjk-set-buffer-multibyte (arg)
  (if (fboundp 'set-buffer-multibyte)
      `(set-buffer-multibyte ,arg)))


;; The conversion routine.  Its main idea is to analyze the character
;; set for each character and then to do something if the previous
;; character has a different character set.  For Thai, we must
;; additionally find proper word breaks using a large word list.
;;
(defun cjk-encode (from to)
  (let ((old-buf (current-buffer))
        (temp-buf (get-buffer-create " *cjk-tmp*"))
        (work-buf (get-buffer-create " *cjk-work*"))
        (required-features (copy-sequence cjk-feature-table)))
    ;; Initialize all working buffers.
    (set-buffer work-buf)
    (erase-buffer)
    (cjk-set-buffer-multibyte nil)

    (set-buffer temp-buf)
    (erase-buffer)
    (cjk-set-buffer-multibyte t)

    ;; Copy the original contents into TEMP-BUF.
    (insert-buffer-substring old-buf from to)
    (if (and (not (featurep 'xemacs))
             (string< emacs-version "21.0"))
        (progn
          (message "Decomposing...")
          (decompose-region (point-min) (point-max))))

    (let ((enc nil)
          (space-state nil)
          prev-charset charset
          ch ch1 ch2
          format-spec
          (skipped-whitespace nil)
          (last-pos 0))
      ;; Now we go to beginning of TEMP-BUF and start the loop.
      (goto-char (point-min))
      (setq prev-charset 'ascii)

      (while (not (eobp))
        ;; In emacs 23+, the `charset' property holds the original
        ;; encoding value; in emacs 22 and earlier, we get `nil'.
        (setq tpch (get-text-property (point) 'charset))
        (setq ch (following-char))
        (set-buffer work-buf)

        ;; Set CHARSET to the character set of the current character.
        ;; Use text property in preference to `char-charset'.
        (if (not (eq tpch nil))
            (setq charset tpch)
          (setq charset (char-charset ch)))

        ;; Avoid `tis620-2533' (new with emacs 23+); we replace it with
        ;; Thai and ASCII (as a new optional argument to
        ;; `char-charset'.
        (if (eq charset 'tis620-2533)
            (setq charset (char-charset ch '(thai-tis620 ascii))))

        ;; Check whether we have Unicode based input.
        (if (eq charset 'unicode)
            (let ((l (split-char ch)))
              (progn
                ;; Unicode 0x0E00-0x0E7F is Thai. Transform back to TIS620
                (setq ch2 (nth 2 l)
                      ch3 (nth 3 l))
                (if (and (eq ch2 14) (< ch3 128))
                    (setq charset 'thai-tis620
                          ch (encode-char ch 'thai-tis620))))))

        ;; `split-char' in emacs 23+ is sensitive to charset priority.
        (cond ((> emacs-major-version 22)
               (if (not (eq charset 'ascii))
                   (set-charset-priority charset))))

        (if (eq charset 'ascii)
            ;; Not a multibyte character.
            (progn
              ;; Don't modify PREV-CHARSET for whitespace characters.
              (setq skipped-whitespace (string-match "[ \t\n]"
                                                     (string ch)))
              (if (not skipped-whitespace)
                  (setq prev-charset 'ascii))
              (insert ch))

          ;; Now we are at a multibyte character.  Set the following
          ;; variables:
          ;;
          ;;   CH1 -- first character code
          ;;   CH2 -- second character code (of two-byte characters)
          ;;          if any
          (if (or (eq charset 'chinese-big5-1)
                  (eq charset 'chinese-big5-2))
              ;; Emacs uses two special character sets for Big5
              ;; characters.  We must decode the current character to
              ;; get the real Big5 character code.
              (progn
                (setq ch (encode-big5-char ch))
                (if (consp ch)
                    ;; XEmacs
                    (setq ch1 (car ch)
                          ch2 (cdr ch))
                  ;; Emacs
                  (setq ch1 (lsh ch -8)
                        ch2 (logand ch 255)))
                ;; 128 will be later added again.
                (setq ch1 (- ch1 128))
                (setq ch2 (- ch2 128)))
            ;; For all other character sets, split-char does the right
            ;; thing.  Note that CH2 can be zero in case it is a
            ;; single-byte character set.
            (let ((l (split-char ch)))
              (setq ch1 (nth 1 l)
                    ch2 (or (nth 2 l) 0))))

          ;; FORMAT-SPEC tells how to encode this character.
          (setq format-spec (cdr (assq charset cjk-format-spec-table)))
          (if (null format-spec)
              ;; Unsupported character set.  Do nothing.
              nil
            ;; Ok, it is supported.  If this character set is a CJK
            ;; character set (i.e., it is in CJK-ENC-TABLE), we need a
            ;; special header at the beginning of the output file.
            ;; This information is stored in the ENC list.
            (let ((tag (cdr (assq charset cjk-enc-table))))
              (if tag
                  (or (memq tag enc)
                      (setq enc (cons tag enc)))))

            ;; Load all features which are required to handle this
            ;; character set.
            (let ((tail (assq charset required-features)))
              ;; We remove all occurrences of TAIL in the feature list
              ;; to avoid loading packages multiple times.
              (setq required-features (delete tail required-features)
                    tail (cdr tail))
              (while tail
                (require (car tail))
                (setq tail (cdr tail))))

            (cond
             ;; If FORMAT-SPEC has the form (SYMBOL ARG1 ARG2 ...),
             ;; SYMBOL indicates how to process the following
             ;; characters.
             ((and (consp format-spec) (symbolp (car format-spec)))
              (cond
               ((eq (car format-spec) 'thai)
                ;; FORMAT-SPEC has this form:
                ;; (thai START-STRING END-STRING
                ;;       BASE-CHAR-FORMAT COMBINING-CHAR-FORMAT
                ;;       EOL-STRING)
                (let ((base-format (nth 3 format-spec))
                      (combining-format (nth 4 format-spec))
                      pos
                      start
                      end
                      str
                      len
                      (i 0))
                  ;; First, insert the code for starting Thai.
                  (if (not (eq prev-charset charset))
                      (insert (nth 1 format-spec)))
                  ;; Analyze the maximum run of Thai characters in
                  ;; TEMP-BUF and insert `|' at all word boundaries.
                  (set-buffer temp-buf)
                  (setq start (point))
                  ;; "\\ct+" searches for characters which have the
                  ;; category `t', i.e. are Thai characters.
                  (re-search-forward "\\ct+" nil t)
                  (setq end (point-marker))
                  (goto-char start)
                  (thai-break-words "|" end)
                  ;; Extract this run.
                  (setq str (buffer-substring start end)
                        len (length str))
                  (goto-char end)
                  (set-marker end nil)
                  ;; Insert characters in STR one by one while
                  ;; converting `|' to `cjk-word-break' and formatting
                  ;; Thai characters according to FORMAT-SPEC.
                  (set-buffer work-buf)
                  (while (< i len)
                    (setq ch (aref str i)
                          i (1+ i))
                    (if (= ch ?|)
                        (insert cjk-word-break)
                      (let* ((split (split-char ch))
                             (category-set (char-category-set ch)))
                        ;; We now analyze the linguistic category
                        ;; assigned to the current character and take
                        ;; the appropriate format.  Then we add 128
                        ;; for producing TIS-620 output.
                        (insert (format
                                 (if (or (aref category-set ?2)
                                         (aref category-set ?3)
                                         (aref category-set ?4))
                                     combining-format
                                   base-format)
                                 (+ (nth 1 split) 128))))))
                  ;; It depends on the following characters what to do
                  ;; next.  If we have tabs and spaces followed by a
                  ;; Thai character, nothing will be done.  If we have
                  ;; a newline character additionally, we insert a
                  ;; special command which usually expands to
                  ;; `\ignorespaces' (which will suppress all
                  ;; whitespace characters).  In all other cases, we
                  ;; close the Thai block.
                  ;;
                  ;; Reason for this algorithm is the fact that in the
                  ;; Thai language a space isn't used to separate
                  ;; words but to structure a sentence.  A normal line
                  ;; break shall not automatically cause the insertion
                  ;; of a space.  The user has rather to explicitly
                  ;; type one or more space characters in the middle
                  ;; of a line to indicate that he or she really wants
                  ;; a space -- note that usually a Thai space is
                  ;; wider than a Roman space resp. can be stretched
                  ;; more.
                  (set-buffer temp-buf)
                  (if (looking-at "[ \t]+\\ct")
                      (setq str "")
                    (if (looking-at "[ \t]*\n[ \t]*\\ct")
                        (setq str (nth 5 format-spec))
                      (setq str (nth 2 format-spec))))
                  ;; To compensate the forward-char at the end of loop.
                  (forward-char -1)
                  (set-buffer work-buf)
                  (insert str)))))

             ;; We may have to insert the car part of the cons and/or
             ;; space controlling commands (cjk-space/cjk-nospace)
             ;; depending on the current context.
             ;;
             ;; Note that this logic sometimes fails.  In the example
             ;; below, cjk-encode will insert \CJKspace in the comment
             ;; instead of right after the comment.  Since cjk-encode
             ;; should be a low-level function we can't assume that
             ;; `%' is always the TeX comment character.  Only TeX
             ;; itself can reliably detect the current comment
             ;; character.
             ;;
             ;;   Chinese Text
             ;;   % Korean comment
             ;;   Korean Text
             ;;
             ;; Two solutions: Either switch between Korean and other
             ;; languages only outside of a comment, or manually insert
             ;; \CJKspace and \CJKnospace commands as needed.
             ((consp format-spec)
              (if (eq charset 'korean-ksc5601)
                  (or (eq space-state cjk-space)
                      (insert (setq space-state cjk-space)))
                (or (eq space-state cjk-nospace)
                    (insert (setq space-state cjk-nospace))))

              ;; Now insert the the header and character(s)
              ;; according to CJK-FORMAT-SPEC-TABLE.  The CJK
              ;; package needs the characters in GR notation, so
              ;; we add 0x80.
              (if (not (eq prev-charset charset))
                  (insert (car format-spec)))
              (insert (format (cdr format-spec)
                              (+ ch1 128) (+ ch2 128))))

             ;; Since Emacs provides the character sets in GL
             ;; notation, we simply subtract 0x20 to get the proper
             ;; index.
             ((vectorp format-spec)
              (insert (format "\177%s\177"
                              (aref format-spec (- ch1 32)))))

             ;; Otherwise, FORMAT-SPEC is just a formatting
             ;; string.
             (t
              (insert (format format-spec ch1 ch2)))))

          (setq prev-charset charset))

        ;; We have finished the analysis of the character set.  Print
        ;; some progress information if we have done another 1000
        ;; characters.
        (set-buffer temp-buf)
        (if (> (- (point) last-pos) 1000)
            (progn
              (setq last-pos (point))
              (message "Converting: %2d%%"
                       (/ (* 100 (point)) (point-max)))))

        ;; Advance to the next character and loop.
        (forward-char 1))

      ;; The remaining task is to insert an appropriate header at the
      ;; very beginning of the output file.  If ENC isn't empty, we need
      ;; the extra LaTeX commands to load CJK package and to output all
      ;; collected CJK encodings.
      (set-buffer work-buf)
      (goto-char (point-min))
      (if enc
          (progn
            (insert "\\def\\CJKhook{")
            (while enc
              (insert (format "\\CJKenc{%s}" (car enc)))
              (setq enc (cdr enc)))
            (insert "}")
            (insert "\\ifx\\CJKpreproc\\undefined")
            (insert "\\def\\CJKpreproc{cjk-enc}")
            (insert "\\RequirePackage[global]{CJK}")
            (insert "\\AtBeginDocument{\\begin{CJK}{}{}\\CJKspace}")
            (insert "\\AtEndDocument{\\end{CJK}}")
            (insert "\\else\\CJKhook\\fi "))
        (insert "\\ifx\\CJKpreproc\\undefined")
        (insert "\\def\\CJKpreproc{cjk-enc}")
        (insert "\\RequirePackage{MULEenc}")
        (insert "\\fi ")))))


(defun cjk-get-name (filename)
  "Replace the extension of the file name with `.cjk'.
If the extension of FILENAME is `.bib', `-cjk.bib' will be appended
to the file name without extension."

  (concat (file-name-sans-extension filename)
          (if (string-equal (file-name-extension filename) "bib")
              "-cjk.bib"
            ".cjk")))


(defun cjk-write-file ()
  "Save current buffer and <buffername>.cjk in cjk-coding.
Files of the form <buffername>.bib are saved as <buffername>-cjk.bib.

If no file is associated with the buffer, you are asked to specify a
file name."

  (interactive)
  (save-buffer)
  (let* ((bufname (buffer-file-name))
         (newbufname (cjk-get-name bufname)))
    (message "Saving %s and %s" bufname newbufname)
    (let ((coding-system-for-write 'cjk-coding))
      (write-region (point-min) (point-max) newbufname))))


(defun cjk-file-write-file (filename &optional load)
  "Save FILENAME as <FILENAME>.cjk in cjk-coding.
With prefix arg (noninteractively: 2nd arg LOAD), load FILENAME into
current buffer also."

  (interactive
   (let ((file buffer-file-name)
         (file-name nil)
         (file-dir nil))
     (and file
          ;; If we are in LaTeX mode, we present the file associated
          ;; with the current buffer as the default.
          (eq (cdr (assq 'major-mode (buffer-local-variables)))
              'latex-mode)
          (setq file-name (file-name-nondirectory file)
                file-dir (file-name-directory file)))
     ;; Now we build the argument list.
     (list (read-file-name (if current-prefix-arg
                               "Load file and save it in cjk-coding: "
                             "Save file in cjk-coding: ")
                           file-dir file-name nil)
           current-prefix-arg)))

  (setq filename (expand-file-name filename))

  (let (input-buffer
        (new-filename (cjk-get-name filename)))
    (save-excursion
      (setq input-buffer (get-buffer-create " *cjk-temp*"))
      (set-buffer input-buffer)
      (erase-buffer)
      (cjk-set-buffer-multibyte t)
      (insert-file-contents filename)
      (let ((coding-system-for-write 'cjk-coding))
        (write-region (point-min) (point-max) new-filename))))

  (if load
      (find-file filename)))


;; To be independent from AUC TeX, we copy the TeX-in-comment function.

(defvar cjk-tex-esc "\\"
  "The TeX escape character.")


(defconst cjk-comment-start-skip (concat "\\(\\(^\\|[^\\]\\)\\("
                                         (regexp-quote cjk-tex-esc)
                                         (regexp-quote cjk-tex-esc)
                                         "\\)*\\)\\(%+ *\\)")
  "A regexp to identify the beginning of a comment in TeX.")


(defun cjk-tex-in-comment ()
  "Return non-nil if point is in a TeX comment."

  (if (or (bolp)
          (eq (preceding-char) ?\r))
      nil
    (save-excursion
      (let ((pos (point)))
        (re-search-backward "^\\|\r" nil t)
        (or (looking-at cjk-comment-start-skip)
            (re-search-forward cjk-comment-start-skip pos t))))))


(defun cjk-write-all-files (filename &optional load force)
  "Save FILENAME and all files included in FILENAME in cjk-coding.
This function runs `cjk-file-write-file' on each file if necessary.
The inclusion commands scanned for are `\\CJKinput', `\\CJKinclude',
and `\\CJKbibliography'.

With 1 \\[universal-argument] (noninteractively: 2nd arg LOAD),
  load FILENAME into current buffer also.
With 2 \\[universal-argument]'s (noninteractively: 3rd arg FORCE),
  run `cjk-file-write-file' unconditionally.
With 3 \\[universal-argument]'s, do both."

  (interactive
   (let ((file buffer-file-name)
         (file-name nil)
         (file-dir nil))
     (and file
          ;; If we are in LaTeX mode, we present the file associated
          ;; with the current buffer as the default.
          (eq (cdr (assq 'major-mode (buffer-local-variables)))
                'latex-mode)
          (setq file-name (file-name-nondirectory file)
                file-dir (file-name-directory file)))
     ;; Now we build the argument list.
     (setq load (member current-prefix-arg '((4) (64))))
     (setq force (member current-prefix-arg '((16) (64))))
     (list
      (read-file-name (if load
                          "Load file and save it in cjk-coding: "
                        "Save file in cjk-coding: ")
                      file-dir file-name nil)
      load
      force)))

  (let (input-buffer
        (dir (file-name-directory filename))
        (tex-include-regexp "\\\\CJKinclude *{\\(.*\\)}")
        (tex-input-regexp "\\\\CJKinput *{\\(.*\\)}")
        (bib-regexp "\\\\CJKbibliography *{\\(.*\\)}")
        (result '())
        (newresult '()))
    (save-excursion
      ;; First, load the file associated with FILENAME into INPUT-BUFFER
      (setq input-buffer (get-buffer-create " *cjk-temp*"))
      (set-buffer input-buffer)
      (erase-buffer)
      (cjk-set-buffer-multibyte t)
      (insert-file-contents filename)
      (goto-char (point-min))

      ;; Then, search `\CJKinput', `\CJKinclude', and `\CJKbibliography' and
      ;; append the found filenames to the RESULT list.
      (while (re-search-forward tex-include-regexp nil t)
        ;; We assume that the include file name is well behaved and
        ;; doesn't contain a comment character.
        (let ((match (match-string 1)))
          (if (not (cjk-tex-in-comment))
              (setq result (cons (concat match ".tex") result)))))
      (while (re-search-forward tex-input-regexp nil t)
        (let ((match (match-string 1)))
          (if (not (cjk-tex-in-comment))
              (if (string-equal (file-name-sans-extension match) match)
                  (setq result (cons (concat match ".tex") result))
                (setq result (cons match result))))))
      (while (re-search-forward bib-regexp nil t)
        (let ((match (match-string 1)))
          (if (not (cjk-tex-in-comment))
              (setq result (cons (concat match ".bib") result))))))

    ;; Add directory to each element.
    (dolist (elt result)
      (setq newresult (cons (concat dir elt) newresult)))

    ;; Add the master file itself to the list.
    (setq newresult (cons filename newresult))

    ;; Process file by file.
    (dolist (source newresult)
      (if (not (file-readable-p source))
          (message "Can't operate on %s" source)
        (if (or (file-newer-than-file-p source (cjk-get-name source))
                force)
            (cjk-file-write-file source)))))

  (if load
      (find-file filename)))


(defun batch-cjk-write-file ()
  "Run `cjk-file-write-file' on the remaining files if necessary.
Use this from the command line, with `--batch' (or `-batch'); it won't
work in an interactive Emacs.  For example, invoke

  \"emacs -batch -l cjk-enc -f batch-cjk-write-file *.tex\"

Note that if you specify a directory name, all files in this directory
are processed."

  (do-batch-cjk-write-file))


(defun batch-force-cjk-write-file ()
  "Run `cjk-file-write-file' on the remaining files unconditionally.
Use this from the command line, with `--batch' (or `-batch'); it won't
work in an interactive Emacs.  For example, invoke

  \"emacs -b -l cjk-enc -f batch-force-cjk-write-file *.tex\"

Note that if you specify a directory name, all files in this directory
are processed.

This function is useful for Makefiles to let the make program do the
file time management."

  (do-batch-cjk-write-file t))


(defun do-batch-cjk-write-file (&optional force)
  "Run `cjk-file-write-file' on remaining arguments.
If optional argument FORCE is non-nil, run it unconditionally."

  (defvar command-line-args-left)       ; Avoid `free variable' warning.

  (if (not noninteractive)
      (error "`batch-write-cjk-file' is to be used only with --batch"))

  (while command-line-args-left
    (let ((source (car command-line-args-left))
          dest)
      (if (file-directory-p (expand-file-name source))
          ;; Handle all files in directory.
          (let ((files (directory-files source)))
            (while files
              (if (and (not (auto-save-file-name-p (car files)))
                       ;; Replace the directory name saved in `source'
                       ;; with a file name.
                       (setq source
                               (expand-file-name (car files) source))
                       (setq dest (cjk-get-name source))
                       (not (file-directory-p source))
                       (or (file-newer-than-file-p source dest)
                           force))
                  (cjk-file-write-file source))
              (setq files (cdr files))))
        ;; Otherwise, process a single file.
        (if (not (file-readable-p source))
            (message "Can't operate on %s" source)
          (if (or (file-newer-than-file-p source (cjk-get-name source))
                  force)
              (cjk-file-write-file source)))))

    (setq command-line-args-left (cdr command-line-args-left)))

  (message "Done")
  (kill-emacs 0))

;;; EOF
