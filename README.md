# TonyRE

TonyRE is a source port of the Tony Hawk's Underground source code to modern systems.

## Building

TonyRE currently only targets Windows.

The build system is entirely CMake. So building is pretty simple.

```bash
cmake -B build
cmake --build build
```

Make sure you compile in 32-bit mode, as the game will not run in 64-bit mode.

## Additional notes

I'm not interested in pulling in any Bink 1.0 decoder as a dependency, so you'll need the music and streams in `.wav` format.

If you have the PS2 version, you can extract `.wav` files from the `.wad` files using [TonyWad](https://github.com/cuckydev/TonyWad).

The `music` and `streams` folders go under `Game/Data`.

## Contributing

Have something to contribute to the project? Feel free to open a pull request!

Consider joining our [Discord Server](https://discord.gg/TvyX2jxAX8) to discuss the project and get help with development.
