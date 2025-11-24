;;; cjk-enc.el --- provide a coding system for LaTeX2e CJK package

;; Copyright (C) 1996, 1998 Electrotechnical Laboratory, JAPAN.

;; Author: Kenichi HANDA <handa@etl.go.jp>
;;         Werner LEMBERG <wl@gnu.org>

;; Keywords: CJK package, LaTeX2e, mule

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

;; The following tables map from Mule's internal encoding to LaTeX2e
;; macros.  Note that not all macros defined here really do exist. See
;; MULEenc.sty and cjk-enc.txt for further details.
;;
;; The active TeX character 0x80 is defined as a multiplex command which
;; executes its first argument. To make the macro expansion robust
;; against \uppercase and \lowercase, numbers are used as parameters which
;; index the various commands.
;;
;; 0xFF will be used as a parameter delimiting character.

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
(defconst cjk-enc-table
  (let ((vec (make-vector 256 nil)))
    (aset vec lc-cn "GB")
    (aset vec lc-kana "SJIS")
    (aset vec lc-jp "JIS")
    (aset vec lc-jp2 "JIS2")
    (aset vec lc-kr "KS")
    (aset vec lc-big5-1 "Bg5")
    (aset vec lc-big5-2 "Bg5")
    (aset vec lc-cns1 "CNS1")
    (aset vec lc-cns2 "CNS2")
    (aset vec lc-cns3 "CNS3")
    (aset vec lc-cns4 "CNS4")
    (aset vec lc-cns5 "CNS5")
    (aset vec lc-cns6 "CNS6")
    (aset vec lc-cns7 "CNS7")
    vec))

(defconst cjk-space "\17764\177\177")
(defconst cjk-nospace "\17765\177\177")

;; here we have the format specification table which defines what to do
;; for each encoding.
(defconst cjk-format-spec-table
  (let ((vec (make-vector 256 nil)))
    ;; Element is a vector VEC.  Each character is formatted as:
    ;;  (format "\177%s\177" (aref VEC (- char-code 160)))
    (aset vec lc-ltn1 cjk-latin-1)
    (aset vec lc-ltn2 cjk-latin-2)
    (aset vec lc-ltn3 cjk-latin-3)
    (aset vec lc-ltn4 cjk-latin-4)
    (aset vec lc-ltn5 cjk-latin-5)
    (aset vec lc-roman cjk-latin-jisx)
    ;; T2A encoding is used for Cyrillic letters.  You must explicitly
    ;; switch between T2 and T1/OT1 encoding.
    (aset vec lc-crl cjk-cyrillic)
    ;; LGR encoding (resp. its ligatures) is used for Greek letters.  You
    ;; must explicitly switch between LGR and T1/OT1 encoding (using
    ;; e.g. Babel's `greek' option).
    (aset vec lc-grk cjk-greek)
    ;; for Vietnamese a Vietnamese TeX-font has to be used which contains
    ;; ASCII characters too!  You must explicitly switch between Vietnamese
    ;; T5 and T1/OT1 encoding.
    (aset vec lc-vn-1 cjk-viscii-lower)
    (aset vec lc-vn-2 cjk-viscii-upper)

    ;; Element is a cons of header HEAD and formatter FORMAT.  HEAD is
    ;; printed first, then each character is formatted as:
    ;;  (format FORMAT char-code-1 char-code-2)
    (aset vec lc-kana '("\17770\177\177" . "\177%c\177\177"))
    (aset vec lc-jp '("\17766\177\177" . "\177%c\177%d\177"))
    (aset vec lc-cn '("\17767\177\177" . "\177%c\177%d\177"))
    (aset vec lc-big5-1 '("\17768\177\177" . "\177%c\177%d\177"))
    (aset vec lc-big5-2 '("\17768\177\177" . "\177%c\177%d\177"))
    (aset vec lc-kr '("\17769\177\177" . "\177%c\177%d\177"))

    ;; Element is a formatter string FORMAT.  Each character is
    ;; formatted as:
    ;;  (format FORMAT char-code-1 char-code-2)
    (aset vec lc-jp2  "\17772\177JIS2\177\177%d\177%d\177")
    (aset vec lc-cns1 "\17772\177CNS1\177\177%d\177%d\177")
    (aset vec lc-cns2 "\17772\177CNS2\177\177%d\177%d\177")
    (aset vec lc-cns3 "\17772\177CNS3\177\177%d\177%d\177")
    (aset vec lc-cns4 "\17772\177CNS4\177\177%d\177%d\177")
    (aset vec lc-cns5 "\17772\177CNS5\177\177%d\177%d\177")
    (aset vec lc-cns6 "\17772\177CNS6\177\177%d\177%d\177")
    (aset vec lc-cns7 "\17772\177CNS7\177\177%d\177%d\177")
    vec))


(make-coding-system
 '*cjk-coding* 0 ?c
 "Coding-system for LaTeX2e CJK Package" 1)


(put '*cjk-coding* 'pre-write-conversion 'cjk-encode)


(defun cjk-encode (from to)
  (save-excursion
    (save-restriction
      (narrow-to-region from to)
      (let ((mc-flag t)
            (re-multibyte-char "[\177-\237][\240-\177]+")
            (enc (make-vector 256 nil))
            (space-state nil)
            (require-cjk-execute nil)
            prev-lc lc ch ch1 ch2 format-spec)
        (goto-char (point-min))
        (if (null (let (mc-flag) (re-search-forward re-multibyte-char nil t)))
            ;; No multilingual text.  Nothing to do.
            nil
          (goto-char (match-beginning 0))
          (setq prev-lc lc-ascii)
          (while (not (eobp))
            ;; Now we are at a multibyte character.
            ;; Set the following variables:
            ;;   LC  -- leading char
            ;;   CH1 -- first char code
            ;;   CH2 -- second char code (of two byte chars)
            (setq ch (following-char))
            (delete-char 1)
            (setq lc (char-component ch 0))
            (if (or (= lc lc-big5-1) (= lc lc-big5-2))
                ;; Mule has special encoding for Big5 characters.  We
                ;; must decode them to the normal Big5 codes.
                (let ((vec (g2b ch)))
                  (setq ch1 (aref vec 0) ch2 (aref vec 1)))
              (setq ch1 (char-component ch 1)
                    ch2 (char-component ch 2)))

            ;; FORMAT-SPEC tells how to encode this character.
            (setq format-spec (aref cjk-format-spec-table lc))
            (if (null format-spec)
                ;; Unsupported character set.
                nil
              ;; Ok, it is supported.  If this character set is one of
              ;; CJK, we need a special header at the beginning of the
              ;; file.
              (if (aset enc lc (aref cjk-enc-table lc))
                  (setq require-cjk-execute t))

              (cond ((consp format-spec)
                     ;; We may have to insert the car part of the cons
                     ;; and/or space controlling commands
                     ;; (cjk-space/cjk-nospace) depending on the current
                     ;; context.
                     (if (= lc lc-kr)
                         (or (eq space-state cjk-space)
                             (insert (setq space-state cjk-space)))
                       (or (eq space-state cjk-nospace)
                           (insert (setq space-state cjk-nospace))))
                     (if (/= prev-lc lc)
                         (insert (car format-spec)))
                     (insert (format (cdr format-spec) ch1 ch2)))

                    ((vectorp format-spec)
                     (insert (format "\177%s\177"
                                     (aref format-spec (- ch1 160)))))
                    (t ; FORMAT-SPEC is just a formatting string.
                     (insert (format format-spec ch1 ch2)))))

            ;; Prepare the next loop.
            (setq prev-lc lc)
            ;; Skip spaces, etc.
            (skip-chars-forward " \t\n")
            ;; If there are any ASCII chars, skip them also, but set
            ;; PREV-LC to LC-ASCII.
            (if (and (< (following-char) 128)
                     (let (mc-flag)
                       (re-search-forward re-multibyte-char nil 'move)))
                (progn
                  (goto-char (match-beginning 0))
                  (setq prev-lc lc-ascii))))

          ;; Now, insert an appropriate header at the head of the file.
          (goto-char (point-min))
          (if require-cjk-execute
              (let ((i 128))
                (insert "\\def\\CJKhook{")
                (while (< i 256)
                  (if (aref enc i)
                      (insert (format "\\CJKenc{%s}" (aref enc i))))
                  (setq i (1+ i)))
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
            (insert "\\fi ")))))))


(defun cjk-write-file ()
  "Save current buffer and <buffername>.cjk in *cjk-coding*.
Files of the form <buffername>.bib are saved as <buffername>-cjk.bib"

  (interactive)
  (let ((bufname (buffer-file-name))
        body
        extension
        newbufname)
    (save-buffer)
    (string-match "\\(.*\\)\\(\\.[^/]*$\\)" bufname)
    (setq body (match-string 1 bufname)
          extension (match-string 2 bufname))
    (setq newbufname
      (concat body
        (if (string-equal extension ".bib")
            "-cjk.bib"
          ".cjk")))
    (message "Saving %s and %s" bufname newbufname)
    (let ((set-file-coding-system *cjk-coding*))
      (write-region (point-min) (point-max) newbufname))))


;;; EOF
