--[[
--------------------------------
Everything below can be ignored.
--------------------------------
]]

gcinclude = gFunc.LoadFile('common\\gcincluderag.lua')

local gcmelee = {}

local isDPS = true

local TpVariantTable = {
    [1] = 'LowAcc',
    [2] = 'HighAcc',
}

local tp_variant = 1

local lastIdleSetBeforeEngaged = ''

local SurvivalSpells = T{ 'Utsusemi: Ichi','Utsusemi: Ni','Blink','Aquaveil','Stoneskin' }

local AliasList = T{
    'tpset','tp','dps',
}

function gcmelee.SetIsDPS(isDPSVal)
    isDPS = isDPSVal
end

function gcmelee.Load()
    gcinclude.SetAlias(AliasList)
    gcinclude.Load(false)
end

function gcmelee.Unload()
    gcinclude.Unload()
    gcinclude.ClearAlias(AliasList)
end

function gcmelee.DoCommands(args)
    if not (AliasList:contains(args[1])) then
        gcinclude.DoCommands(args)
        do return end
    end

    if (args[1] == 'tpset' or args[1] == 'tp') then
        tp_variant = tp_variant + 1
        if (tp_variant > #TpVariantTable) then
            tp_variant = 1
        end
        gcinclude.Message('TP Set', TpVariantTable[tp_variant])
    elseif (args[1] == 'dps') then
        isDPS = not isDPS
        gcinclude.Message('DPS Mode', isDPS)
        if (not isDPS) then
            gcinclude.ToggleIdleSet(lastIdleSetBeforeEngaged)
            lastIdleSetBeforeEngaged = ''
        end
    end
end

function gcmelee.DoDefault()
    local player = gData.GetPlayer()
    local environment = gData.GetEnvironment()

    gcinclude.DoDefaultIdle()

    if (isDPS) then
        if (gcdisplay.IdleSet == 'Normal' or gcdisplay.IdleSet == 'Alternate' or gcdisplay.IdleSet == 'LowAcc' or gcdisplay.IdleSet == 'HighAcc') then
            if (player.Status == 'Engaged') then
                if (lastIdleSetBeforeEngaged == '') then
                    lastIdleSetBeforeEngaged = gcdisplay.IdleSet
                end
                gFunc.EquipSet('TP_' .. TpVariantTable[tp_variant])
                if (gcdisplay.IdleSet ~= TpVariantTable[tp_variant]) then
                    gcinclude.ToggleIdleSet(TpVariantTable[tp_variant])
                end
            end
            if (player.Status == 'Idle' and lastIdleSetBeforeEngaged ~= '') then
                gcinclude.ToggleIdleSet(lastIdleSetBeforeEngaged)
                lastIdleSetBeforeEngaged = ''
            end
        end
    end
end

function gcmelee.DoDefaultOverride()
    gcinclude.DoDefaultOverride(true)
end

function gcmelee.DoPrecast(fastCastValue)
    gcmelee.SetupMidcastDelay(fastCastValue)
    gFunc.EquipSet('Precast')
end

function gcmelee.SetupMidcastDelay(fastCastValue)
    local player = gData.GetPlayer()
    local action = gData.GetAction()
    if (player.SubJob == "RDM") then
         fastCastValue = fastCastValue + 0.15 -- Fast Cast Trait
    end
    local minimumBuffer = 0.25 -- Can be lowered to 0.1 if you want
    local packetDelay = 0.25 -- Change this to 0.4 if you do not use PacketFlow
    local castDelay = ((action.CastTime * (1 - fastCastValue)) / 1000) - minimumBuffer
    if (castDelay >= packetDelay) then
        gFunc.SetMidDelay(castDelay)
    end

    -- print(chat.header('DEBUG'):append(chat.message('Cast delay is ' .. castDelay)))
end

function gcmelee.DoMidcast(sets)
    gcmelee.SetupInterimEquipSet(sets)
    gFunc.EquipSet('Haste')
end

function gcmelee.SetupInterimEquipSet(sets)
    local action = gData.GetAction()

    gFunc.InterimEquipSet(sets.DT)

    if (gcdisplay.IdleSet == 'MDT') then gFunc.InterimEquipSet(sets.MDT) end
    if (gcdisplay.IdleSet == 'FireRes') then gFunc.InterimEquipSet(sets.FireRes) end
    if (gcdisplay.IdleSet == 'IceRes') then gFunc.InterimEquipSet(sets.IceRes) end
    if (gcdisplay.IdleSet == 'LightningRes') then gFunc.InterimEquipSet(sets.LightningRes) end
    if (gcdisplay.IdleSet == 'EarthRes') then gFunc.InterimEquipSet(sets.EarthRes) end

    if (SurvivalSpells:contains(action.Name)) then
        gFunc.InterimEquipSet(sets.SIRD)
    end
end

return gcmelee
