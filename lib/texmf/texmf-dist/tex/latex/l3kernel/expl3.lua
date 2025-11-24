--
-- This is file `expl3.lua',
-- generated with the docstrip utility.
--
-- The original source files were:
--
-- l3luatex.dtx  (with options: `package,lua')
-- 
-- EXPERIMENTAL CODE
-- 
-- Do not distribute this file without also distributing the
-- source files specified above.
-- 
-- Do not distribute a modified version of this file.
-- 
-- File: l3luatex.dtx Copyright (C) 2010-2016 The LaTeX3 Project
--
-- It may be distributed and/or modified under the conditions of the
-- LaTeX Project Public License (LPPL), either version 1.3c of this
-- license or (at your option) any later version.  The latest version
-- of this license is in the file
--
--    http://www.latex-project.org/lppl.txt
--
-- This file is part of the "l3kernel bundle" (The Work in LPPL)
-- and all files in that bundle must be distributed together.
--
-- The released version of this bundle is available from CTAN.
--
-- -----------------------------------------------------------------------
--
-- The development version of the bundle can be found at
--
--    http://www.latex-project.org/svnroot/experimental/trunk/
--
-- for those people who are interested.
--
--%%%%%%%%%
-- NOTE: %%
--%%%%%%%%%
--
--   Snapshots taken from the repository represent work in progress and may
--   not work or may contain conflicting material!  We therefore ask
--   people _not_ to put them into distributions, archives, etc. without
--   prior consultation with the LaTeX3 Project.
--
-- -----------------------------------------------------------------------
l3kernel = l3kernel or { }
local tex_setcatcode    = tex.setcatcode
local tex_sprint        = tex.sprint
local tex_write         = tex.write
local unicode_utf8_char = unicode.utf8.char
local function strcmp (A, B)
  if A == B then
    tex_write("0")
  elseif A < B then
    tex_write("-1")
  else
    tex_write("1")
  end
end
l3kernel.strcmp = strcmp
local charcat_table = l3kernel.charcat_table or 1
local function charcat (charcode, catcode)
  tex_setcatcode(charcat_table, charcode, catcode)
  tex_sprint(charcat_table, unicode_utf8_char(charcode))
end
l3kernel.charcat = charcat
