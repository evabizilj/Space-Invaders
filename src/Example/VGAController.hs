{-# LANGUAGE RecordWildCards #-}

module Example.VGAController (VGASignal, vgaController) where

import Clash.Prelude
import Example.Counter
        
data Timing = Timing
    { pixels     :: Unsigned 16
    , syncPulse  :: Unsigned 16
    , backPorch  :: Unsigned 16
    , frontPorch :: Unsigned 16
    , polarity   :: Bool
    }

h :: Timing
h = Timing
    { pixels     = 1920
    , syncPulse  = 44
    , frontPorch = 88
    , backPorch  = 148
    , polarity   = True
    }

v :: Timing
v = Timing
    { pixels     = 1080
    , syncPulse  = 5
    , frontPorch = 4
    , backPorch  = 36
    , polarity   = True
    }

period :: Timing -> Unsigned 16
period Timing{..} = pixels + syncPulse + frontPorch + backPorch

type VGASignal =
    ( Unsigned 16 -- column
    , Unsigned 16 -- row
    , Bool -- hsync
    , Bool -- vsync
    , Bool) -- display enable

vgaController
    :: HiddenClockResetEnable dom
    => Signal dom VGASignal
vgaController = bundle (row, col, hSync, vSync, en)
    where
        clock = hasClock
        reset = hasReset
        enable = hasEnable
        hCount = counterWithLimit @16 (period h)
        vEnable = toEnable $ fromEnable enable .&&. hCount .==. 0
        vCount = withClockResetEnable clock reset vEnable $
            counterWithLimit @16 (period v)
        row = (\c -> c - backPorch h) <$> hCount
        col = (\c -> c - backPorch v) <$> vCount
        hSync = sync hCount h
        vSync = sync vCount v
        sync count Timing{..} = pure polarity ./=.
            let left = pure $ pixels + frontPorch
                right = pure $ pixels + frontPorch + syncPulse
             in count .<. left .||. count .>=. right
        en = (hCount .<. pure (pixels h)) .&&. (vCount .<. pure (pixels v))
