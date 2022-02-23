module Example.VSync (vSync) where

import Clash.Prelude
import Example.Counter
import Example.FF

syncPulse = 5
displayWidth = 1920
displayHeight = 1080
backPorch = 36
frontPorch = 4

vSync
    :: HiddenClockResetEnable dom
    => Signal dom Bool -- ce
    -> Signal dom (Bool, Bool, Bool, Bool, Bool) -- R G B von vsync
vSync ce = bundle (r, g, b, von, vsync)
    where
        clock = hasClock
        reset = hasReset
        enable = hasEnable
        sig_on = vcount .==. pure (syncPulse - 1)
        sig_off = vcount .==. pure (displayWidth - 1)
        von = (vcount .>=. pure backPorch) .&&. (vcount .<. pure (backPorch + displayHeight))
        r = (vcount .>=. pure backPorch) .&&. (vcount .<. pure (backPorch + 160))
        g = (vcount .>=. pure (backPorch + 160)) .&&. (vcount .<. pure (backPorch + 320))
        b = (vcount .>=. pure (backPorch + 320)) .&&. (vcount .<. pure displayHeight)
        rst = unsafeFromHighPolarity $ unsafeToHighPolarity reset .||. (ce .&&. sig_off)
        en = toEnable $ fromEnable enable .&&. ce .&&. (sig_off .==. pure False)
        vcount = withClockResetEnable clock rst en $ counter @10
        vsync = srflipflop sig_on sig_off
