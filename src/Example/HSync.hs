module Example.HSync (hSync) where

import Clash.Prelude
import Example.Counter
import Example.FF

syncPulse = 44
displayWidth = 1920
displayHeight = 1080
backPorch = 148
frontPorch = 88

hSync
    :: HiddenClockResetEnable dom
    => Signal dom (Bool, Bool, Bool) -- ce, hon, hsync
hSync = bundle (ce, hon, hsync)
    where
        clock = hasClock
        reset = hasReset
        enable = hasEnable
        sig_on = hcount .==. pure (syncPulse - 1)
        sig_off = hcount .==. pure (displayWidth - 1)
        hon = (hcount .>=. pure backPorch) .&&. (hcount .<. pure (backPorch + displayHeight))
        rst = unsafeFromHighPolarity $ unsafeToHighPolarity reset .||. sig_off
        hcount = withClockResetEnable clock rst enable $ counter @12
        hsync = withClockResetEnable clock rst enable $ srflipflop sig_on sig_off
        ce = sig_off
