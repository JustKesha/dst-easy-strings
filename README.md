# 📖 DST - Easy Custom Strings

A lightweight utility for managing prefab name and description strings in Don't Starve Together (DST) mods. Simplifies the process of adding strings to the `GLOBAL.STRINGS` table, reducing boilerplate code by up to 50%. Also provides functionality to organize strings in separate files.

## Overview
Tired of this?

```lua
GLOBAL.STRINGS.NAMES.MYPREFAB = "Grass Juice"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.MYPREFAB = "Grass? In liquid form? Hmm... the texture is... unsettling."
GLOBAL.STRINGS.CHARACTERS.WILLOW.DESCRIBE.MYPREFAB = "Tastes like burnt lawn clippings. I kinda like it!"
GLOBAL.STRINGS.CHARACTERS.WOLFGANG.DESCRIBE.MYPREFAB = "Is not meat, but is... green? Tiny drink for tiny muscles!"
GLOBAL.STRINGS.CHARACTERS.WENDY.DESCRIBE.MYPREFAB = "The essence of withering life... fitting."
```

Try this:

```lua
local Strings = require("util.strings")

Strings.Add("MYPREFAB", {
    NAME = "Grass Juice",
    GENERIC = "Grass? In liquid form? Hmm... the texture is... unsettling.",
    WILLOW = "Tastes like burnt lawn clippings. I kinda like it!",
    WOLFGANG = "Is not meat, but is... green? Tiny drink for tiny muscles!",
    WENDY = "The essence of withering life... fitting.",
})

Strings.Merge(GLOBAL.STRINGS)
```

## API References

### Core Concepts
The utility maintains an internal cache of strings in a simplified format, then provides methods to convert and merge these into the proper `GLOBAL.STRINGS` structure.

### Methods

- `Add` —
Adds or replaces strings for a single prefab in the cache. Takes the prefab name and its associated strings.

- `Merge` —
Convenience method that merges the cached strings into `GLOBAL.STRINGS`. Syntax sugar for `MergeCustomStrings`.

- `MergeFromFile` —
Loads strings from an external Lua file and merges them into `GLOBAL.STRINGS`. The file should return a table in cache format.

- `CreateCustomStrings` —
Merges strings for multiple prefabs into the internal cache. Accepts data in the cache format.

- `FormatCustomStrings` —
Converts the simplified strings table into the proper `GLOBAL.STRINGS` format. Handles:
  - Prefab names
  - Generic descriptions
  - Character-specific descriptions

- `MergeCustomStrings` —
Primary method that merges custom strings into the global strings table. Can operate on either:
  - The internal cache (default)
  - A provided custom strings table of cache format


### Data Structure

Strings are stored in a simplified nested table structure — Cache Format:
```lua
{
    PREFAB_NAME = {
        NAME = "Display Name",
        GENERIC = "Generic Description",
        CHARACTER_NAME = "Character-specific Description",
        ...
    },
    ...
}
