--
-- This is file `fmp-doc.hs',
-- generated with the docstrip utility.
--
-- The original source files were:
--
-- fmp.dtx  (with options: `examples')
-- 
-- Example source code for the FMP package
-- 
module FMPDoc where
import FMP
import FMPTree

example1           = binom 5
    where
    ce             = circle empty
    binom 0        = node ce []
    binom n        = node ce [edge (binom i)
                              | i <- [(n-1),(n-2)..0]]
                     #setAlign AlignRight

example2           = box (math "U" |||
                          ooalign [toPicture [cArea a 0.7,
                                              cArea b 0.7,
                                              cArea ab 0.4],
                                   bOverA])
    where
    cArea a c      = toArea a #setColor c
    bOverA         = column [math "B" #setBGColor white,
                             vspace 50,
                             math "A" #setBGColor white]
    a              = transformPath (scaled 30) fullcircle
    b              = transformPath (scaled 30 & shifted (0,-30))
                     fullcircle
    ab             = buildCycle a b

