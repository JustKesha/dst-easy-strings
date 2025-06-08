local DeepMerge = require("util.deep_merge")

--- Return table
local CUSTOM_STRINGS = {}

--- Table Format: `{ PREFAB_NAME = { NAME = "", GENERIC = "", ... }, ... }`
CUSTOM_STRINGS.CACHE = {}

--- Merges strings for given prefabs to `CACHE`
--- @param data table `{ PREFAB_NAME = { NAME = "", GENERIC = "", ... }, ... }`
function CUSTOM_STRINGS.CreateCustomStrings(data)
    CUSTOM_STRINGS.CACHE = DeepMerge(CUSTOM_STRINGS.CACHE, data)
end

-- Adds/Replaces strings for given prefab to `CACHE`
--- @param name string
--- @param data table `{ NAME = "", GENERIC = "", ... }`
function CUSTOM_STRINGS.Add(name, data)
    CUSTOM_STRINGS.CACHE[name] = data
end

--- Converts custom strings table to `GLOBAL.STRINGS` format
--- @param custom_strings table
--- @return table
function CUSTOM_STRINGS.FormatCustomStrings(custom_strings)
    local STRINGS_DATA = {
        NAMES = {},
        CHARACTERS = { GENERIC = { DESCRIBE = {} } }
    }

    for item_id, strings in pairs(custom_strings) do
        if strings.NAME then
            STRINGS_DATA.NAMES[item_id] = strings.NAME
        end

        if strings.GENERIC then
            STRINGS_DATA.CHARACTERS.GENERIC.DESCRIBE[item_id] = strings.GENERIC
        end

        for char_name, text in pairs(strings) do
            if char_name ~= "NAME" and char_name ~= "GENERIC" then
                STRINGS_DATA.CHARACTERS[char_name] = STRINGS_DATA.CHARACTERS[char_name] or { DESCRIBE = {} }
                STRINGS_DATA.CHARACTERS[char_name].DESCRIBE[item_id] = text
            end
        end
    end

    return STRINGS_DATA
end

--- Merges your custom strings to `GLOBAL.STRINGS`, if no strings table given will merge from `CACHE`
--- @param global_strings table
--- @param custom_strings table?
function CUSTOM_STRINGS.MergeCustomStrings(global_strings, custom_strings)
    custom_strings = custom_strings or CUSTOM_STRINGS.CACHE
    custom_strings = CUSTOM_STRINGS.FormatCustomStrings(custom_strings)

    global_strings = DeepMerge(global_strings, custom_strings)
end

--- Merges cached strings to `GLOBAL.STRINGS`<br>
--- Syntax sugar for `MergeCustomStrings`
--- @param global_strings table
function CUSTOM_STRINGS.Merge(global_strings)
    CUSTOM_STRINGS.MergeCustomStrings(global_strings)
end

--- Merges strings from the specified lua file into `GLOBAL.STRINGS`<br>
--- The file should return a table of `CACHE` format<br>
--- By default looks for `"custom_strings"`
--- @param global_strings table
--- @param module_path? string module path for the `require` call
function CUSTOM_STRINGS.MergeFromFile(global_strings, module_path)
    module_path = module_path or "custom_strings"

    CUSTOM_STRINGS.MergeCustomStrings(global_strings, require(module_path))
end

return CUSTOM_STRINGS