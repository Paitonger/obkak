-- 17.04
function dEvents.checkFolder()
    if not file.Exists('devents', 'DATA') then
        file.CreateDir('devents')
    end
end

dEvents.stripPresets = {}

function dEvents.readStripPresets()
    if not file.Exists('devents/strips.txt', 'DATA') then return end

    local data = util.JSONToTable(file.Read('devents/strips.lua', 'DATA') or '[]')
    dEvents.stripPresets = data
end

function dEvents.writeStripPresets()
    local json = util.TableToJSON(dEvents.stripPresets, true)
    file.Write('devents/strips.txt', json)
end

dEvents.checkFolder()
dEvents.readStripPresets()