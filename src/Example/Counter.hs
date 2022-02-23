module Example.Counter (counter, counterWithLimit) where

import Clash.Prelude

counter
  :: forall n dom . (KnownNat n, HiddenClockResetEnable dom)
  => Signal dom (Unsigned n)
counter = c
    where
        enable = fromEnable hasEnable
        c = register 0 $ mux enable (c+1) c

counterWithLimit
  :: forall n dom . (KnownNat n, HiddenClockResetEnable dom)
  => Unsigned n              -- limit
  -> Signal dom (Unsigned n) -- count
counterWithLimit limit = c
    where
        enable = fromEnable hasEnable
        c = register 0 $ mux enable inc c
        inc = mux (c + 1 .>=. pure limit) 0 (c + 1)
