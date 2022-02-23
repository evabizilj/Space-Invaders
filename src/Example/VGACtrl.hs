module Example.VGACtrl (RgbComponent, vgaCtrl) where

import Clash.Prelude
import Example.VSync
import Example.HSync

type RgbComponent = BitVector 4

vgaCtrl
    :: HiddenClockResetEnable dom
    => Signal dom (RgbComponent, RgbComponent, RgbComponent, Bool, Bool) -- R G B hsync vsync
vgaCtrl = bundle (vgaR, vgaG, vgaB, hsync, vsync)
    where
        (ce, hon, hsync) = unbundle hSync
        (r, g, b, von, vsync) = unbundle $ vSync ce
        vgaR = pure 0b1111
        vgaG = pure 0b0000
        vgaB = pure 0b1111
