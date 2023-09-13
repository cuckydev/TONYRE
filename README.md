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

## Contributing

Have something to contribute to the project? Feel free to open a pull request!

Consider joining our [Discord Server](https://discord.gg/TvyX2jxAX8) to discuss the project and get help with development.

## Current major issues

- This will only compile in 32-bit mode
- Backend unfinished
- Game depends on hack to clear class memory on construction automatically (see Code/Core/Support/Class.cpp)
- Create-A-Park crashes
