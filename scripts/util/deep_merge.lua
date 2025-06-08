-- Recursively merge nested tables
local function DeepMerge(dest, src)
    for k, v in pairs(src) do
        if type(v) == "table" and type(dest[k]) == "table" then
            DeepMerge(dest[k], v)
        else
            dest[k] = v
        end
    end
    return dest
end

return DeepMerge