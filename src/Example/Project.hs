module Example.Project (topEntity) where

import Clash.Prelude

import Example.VGADomain
import Example.VGAController

type RGBComponent = BitVector 4
type Coordinate = (Unsigned 16, Unsigned 16, Bool)
type Pixel = (RGBComponent, RGBComponent, RGBComponent)

{-# ANN topEntity
  (Synthesize
    { t_name   = "top"
    , t_inputs = PortName <$> [ "clk_sys", "btnCpuReset" ]
    , t_output = PortProduct "" $ PortName <$> [ "vgaRed", "vgaBlue", "vgaGreen", "Hsync", "Vsync" ]
    }) #-}

topEntity
  :: Clock SystemDomain
  -> Reset SystemDomain
  -> Signal VGADomain (
        RGBComponent, -- R
        RGBComponent, -- G
        RGBComponent, -- B
        Bool, -- hsync
        Bool) -- vsync
topEntity sysClock sysReset = bundle (red, green, blue, hSync, vSync)
    where
        sysEnable :: Enable SystemDomain
        sysEnable = enableGen

        (col, row, hSync, vSync, vgaEn) = unbundle vga

        vga :: Signal VGADomain VGASignal
        vga = withClockResetEnable sysClock sysReset sysEnable $ inVgaDomain vgaController

        (red, green, blue) = unbundle $ draw <$> bundle (row, col, vgaEn)

draw :: Coordinate -> Pixel
draw (_,_,False) = (0,0,0)
draw (x,y,True) | x > 100 && x < 200 && y > 100 && y < 200 = (0b1111,0,0b1111)
                | otherwise = (0b1111,0b111,0)

