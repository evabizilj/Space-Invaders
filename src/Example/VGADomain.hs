module Example.VGADomain (SystemDomain, VGADomain, inVgaDomain) where

import Clash.Prelude
import Clash.Explicit.Signal (unsafeSynchronizer)
import Clash.Xilinx.ClockGen

createDomain vSystem{vName = "SystemDomain", vResetPolarity = ActiveLow, vPeriod = hzToPeriod 100_000_000}

createDomain vSystem{vName = "VGADomain", vResetPolarity = ActiveLow, vPeriod = hzToPeriod 148_500_000}

inVgaDomain
    :: HiddenClockResetEnable SystemDomain
    => (HiddenClockResetEnable VGADomain => r)
    -> r
inVgaDomain = withClockResetEnable vgaClock vgaReset vgaEnable
    where
        sysClock = hasClock
        sysReset = hasReset
        -- sysEnable = hasEnable
        vgaClock :: Clock VGADomain
        vgaReset :: Reset VGADomain
        vgaEnable :: Enable VGADomain
        (vgaClock, vgaEnable) = clockWizard (SSymbol @"clkWiz100to148") sysClock sysReset
        sysResetSignal = unsafeToHighPolarity sysReset
        vgaResetSignal = unsafeSynchronizer sysClock vgaClock sysResetSignal
        vgaReset = unsafeFromHighPolarity vgaResetSignal