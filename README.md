# ParadoxParser

ParadoxParser is a library to parse configuration and save games from Paradox games
using the Clausewitz Engine. It was developed with EU4 in mind but should support
most of the games using this engine.

The lib can be somewhat slow on large files, taking around 5s on my machine for a 25M
save.

This does not support Ironman Mode saves (binary format) or compressed saves, for
compressed files you will need to uncompress them using `unzip` or a library that
supports the PZ compression format.

## Installation

  1. Add `paradox_parser` to your list of dependencies in `mix.exs`:

        def deps do
          [{:paradox_parser, "~> 1.0.0"}]
        end

  2. Update your dependencies using `mix deps.get`

## Usage

```elixir
# Try to parse a save game
{:ok, data} = ParadoxParser.read_file("save_game.eu4")
# Try to parse the culture data, throws on error
data = ParadoxParser.read_file!("Europa\ Universalis\ IV/common/cultures/00_cultures.txt")
```

The library also has a `read_string` function should you need to parse a file on the
fly but make sure to convert it to UTF-8 before (using `codepagex` or similar) since
CE files are using ISO-8859-X by default.