# Space Invaders
This project contains an implementation of the classic game [Space Invaders][space-invaders] for Xilinx FPGA with VGA and USB keyboard.

The implementation language is almost purely [Clash][clash-lang], with some Xilinx metadata files.

The development board this project was built with is the [Digilent Nexys 4][nexys4] with a [Xilinx Artix 7][artix7] FPGA.

[space-invaders]: https://en.wikipedia.org/wiki/Space_Invaders
[clash-lang]: https://clash-lang.org/
[nexys4]: https://reference.digilentinc.com/reference/programmable-logic/nexys-4/
[artix7]: https://www.xilinx.com/products/silicon-devices/fpga/artix-7.html

# Dependencies
- Make
- chronic: `<manager> install chronic`
- unbuffer from the package moreutils: `<manager> install moreutils`
- Stack: https://docs.haskellstack.org/en/stable/install_and_upgrade/

# Building and testing this project

Run `make` or `make vhdl` to convert the Haskell sources to VHDL. The VHDL will be placed in the `vhdl/` directory.

Run `make bitstream` to convert VHDL sources to a Xilinx bitstream. If you did not create VHDL first, this command will build it for you. The bitstream will be placed in the file `project.bit`.

Run `make program` to program the bitstream to the first connected FPGA it finds. If you did not create the bitstream first, this command will build it for you.

# Documentation

- Clash User Guide: https://clash-lang.readthedocs.io/en/latest/index.html
- Clash Tutorial: https://hackage.haskell.org/package/clash-prelude/docs/Clash-Tutorial.html
- Clash reference documentation: https://hackage.haskell.org/package/clash-prelude/docs/Clash-Prelude.html
- Clash examples: https://hackage.haskell.org/package/clash-prelude/docs/Clash-Examples.html
- Example Clash VGA project: https://github.com/gergoerdi/clash-pong
