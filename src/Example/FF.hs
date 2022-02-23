module Example.FF (srflipflop) where

import Clash.Prelude

srflipflop
    :: HiddenClockResetEnable dom
    => Signal dom Bool -- s
    -> Signal dom Bool -- r
    -> Signal dom Bool -- q
srflipflop s r = q
    where
        q = delay False q'
        q' = s .||. (q .&&. r .==. pure False)
