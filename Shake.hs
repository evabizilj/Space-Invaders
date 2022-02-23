import Development.Shake
import Development.Shake.Command
import Development.Shake.FilePath
import Development.Shake.Util
import Data.List (intercalate)
import System.Environment (getExecutablePath)

design = "project"
topName = "top"
device = "xc7a100tcsg324-1"
xdcFile = "Nexys-4-Master.xdc"

main = shakeArgs shakeOptions $ do
    let srcDir = "src"
    let vhdlDir = "vhdl"
    let bitFile = design <.> "bit"
    scriptDir <- liftIO $ takeDirectory . takeDirectory <$> liftIO getExecutablePath
    vivado <- newResource "Vivado" 1

    want [bitFile]

    phony "build" $ cmd_ "stack build"

    phony "vhdl" $ do
        let src = "src/Example/Project.hs"
        need ["build", src]
        Stdout distDir <- cmd "stack path --dist-dir"
        let buildDir = distDir </> "build"
        cmd_ "stack exec -- clash --vhdl -odir" [buildDir] "-hidir" [buildDir] src

    phony "program" $ do
        need [bitFile]
        withResource vivado 1 $ do
            sendVivado ["cd", scriptDir]
            sendVivado ["current_hw_target", "[get_hw_targets *]"]
            sendVivado ["open_hw_target"]
            sendVivado ["set", "hw_device", "[lindex [get_hw_devices] 0]"]
            sendVivado ["current_hw_device", "$hw_device"]
            sendVivado ["set_property", "PROGRAM.FILE", bitFile, "$hw_device"]
            sendVivado ["program_hw_devices", "$hw_device"]

    "*.bit" %> \out -> do
        need ["vhdl"]
        withResource vivado 1 $ do
            sendVivado ["cd", scriptDir]
            sendVivado ["read_vhdl [ glob", vhdlDir <> "/*/*/*.vhdl", "]"]
            sendVivado ["read_xdc [ glob *.xdc ]"]
            sendVivado ["synth_design", "-name", design, "-top", topName, "-part", device]
            sendVivado ["opt_design"]
            sendVivado ["place_design"]
            sendVivado ["phys_opt_design"]
            sendVivado ["route_design"]
            sendVivado ["write_bitstream", "-force", out]
    where
        sendVivado :: [String] -> Action ()
        sendVivado args = cmd
            (UserCommand "vivado")
            (EchoStdout False)
            (Stdin $ intercalate " " args)
            "nc localhost 12345"
