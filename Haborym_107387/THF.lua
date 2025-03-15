local profile = {}

local fastCastValue = 0.07 -- 7% from gear

local ta_rogue_armlets = false

local sets = {
    Idle = {
        Head = 'Optical Hat',
        Neck = 'Evasion Torque',
        Ear1 = 'Merman\'s Earring',
        Ear2 = 'Merman\'s Earring',
        Body = 'Scp. Harness +1',
        Hands = 'War Gloves +1',
        Ring1 = 'Sattva Ring',
        Ring2 = 'Jelly Ring',
        Back = 'Boxer\'s Mantle',
        Legs = 'Raven Hose',
        Waist = 'Scouter\'s Rope',
        Feet = 'Dance Shoes',
    },
    IdleALT = {
        Head = 'Darksteel Cap +1',
        Neck = 'Evasion Torque',
        Ear1 = 'Merman\'s Earring',
        Ear2 = 'Merman\'s Earring',
        Body = 'Dst. Harness +1',
        Hands = 'Dst. Mittens +1',
        Ring1 = 'Sattva Ring',
        Ring2 = 'Jelly Ring',
        Waist = 'Scouter\'s Rope',
        Legs = 'Dst. Subligar +1',
        Feet = 'Dst. Leggings +1',
    },
    Resting = {
        Neck = 'Checkered Scarf',
    },
    Town = {
        Head = 'Rabbit Cap',
        Neck = 'Jeweled Collar',
    },
    Movement = {},

    DT = {
        -- 23% PDT
        Head = 'Darksteel Cap +1',  -- 2
        Body = 'Dst. Harness +1',   -- 4
        Hands = 'Dst. Mittens +1',  -- 2
        Ring1 = 'Sattva Ring',      -- 5
        Ring2 = 'Jelly Ring',       -- 5
        Legs = 'Dst. Subligar +1',  -- 3
        Feet = 'Dst. Leggings +1',  -- 2
    },
    MDT = {
        -- 40% MDT
        -- Shell IV provides 23% MDT, 17% from gear
        Neck = 'Jeweled Collar',
        Ear1 = 'Merman\'s Earring', -- 2
        Ear2 = 'Merman\'s Earring', -- 2
        Ring1 = 'Sattva Ring',      -- 5
        Ring2 = 'Merman\'s Ring',   -- 4
    },
    FireRes = {},
    IceRes = {},
    LightningRes = {},
    EarthRes = {},
    WindRes = {},
    WaterRes = {},

    Evasion = {
        Head = 'Optical Hat',
        Neck = 'Evasion Torque',
        Ear1 = 'Drone Earring',
        Ear2 = 'Musical Earring',
        Body = 'Scp. Harness +1',
        Hands = 'War Gloves +1',
        Ring1 = 'Sattva Ring',
        Back = 'Boxer\'s Mantle',
        Waist = 'Scouter\'s Rope',
        Legs = 'Raven Hose',
        Feet = 'Dance Shoes',
    },

    Precast = {
        Ear1 = 'Loquac. Earring',   -- 2
        Legs = 'Homam Cosciales',   -- 5
    },
    SIRD = {
    },
    Haste = {
        -- Used for Utsusemi cooldown
        Head = 'Panther Mask',
        Ear1 = 'Loquac. Earring',
        Body = 'Rapparee Harness',
        Hands = 'Homam Manopolas',
        Waist = 'Swift Belt',
        Legs = 'Homam Cosciales',
        Feet = 'Homam Gambieras',
    },

    LockSet1 = {},
    LockSet2 = {},
    LockSet3 = {},

    TP_LowAcc = {
        Head = 'Panther Mask',
        Neck = 'Love Torque',
        Ear1 = 'Brutal Earring',
        Ear2 = 'Stealth Earring',
        Body = 'Rapparee Harness',
        Hands = 'Homam Manopolas',
        Ring1 = 'Toreador\'s Ring',
        Ring2 = 'Toreador\'s Ring',
        Back = 'Forager\'s Mantle',
        Waist = 'Swift Belt',
        Legs = 'Homam Cosciales',
        Feet = 'Homam Gambieras',
    },
    TP_HighAcc = {
        Head = 'Optical Hat',
        Neck = 'Love Torque',
        Ear1 = 'Brutal Earring',
        Ear2 = 'Stealth Earring',
        Body = 'Rapparee Harness',
        Hands = 'Homam Manopolas',
        Ring1 = 'Toreador\'s Ring',
        Ring2 = 'Toreador\'s Ring',
        Back = 'Forager\'s Mantle',
        Waist = 'Tilt Belt',
        Legs = 'Homam Cosciales',
        Feet = 'Homam Gambieras',
    },
    TP_Eva = {
        Head = 'Optical Hat',
        Neck = 'Evasion Torque',
        Ear1 = 'Musical Earring',
        -- Ear1 = 'Brutal Earring',
        Ear2 = 'Stealth Earring',
        Body = 'Scp. Harness +1',
        Hands = 'War Gloves +1',
        Ring1 = 'Toreador\'s Ring',
        Ring2 = 'Toreador\'s Ring',
        Back = 'Boxer\'s Mantle',
        Waist = 'Scouter\'s Rope',
        Legs = 'Raven Hose',
        Feet = 'Dance Shoes',
    },
    TP_NIN = {},

    WS = {
        Head = 'Emperor Hairpin',
        Neck = 'Love Torque',
        Ear1 = 'Brutal Earring',
        Ear2 = 'Merman\'s Earring',
        Body = 'Dargon Harness',
        Hands = 'War Gloves +1',
        Ring1 = 'Spinel Ring',
        Ring2 = 'Spinel Ring',
        Back = 'Forager\'s Mantle',
        Waist = 'R.K. Belt +1',
        Legs = 'Republic Subligar',
        Feet = 'Bounding Boots',
    },
    WS_Evisceration = {
        Head = 'Emperor Hairpin',
        Neck = 'Love Torque',
        Ear1 = 'Brutal Earring',
        Ear2 = 'Pixie Earring',
        Body = 'Dargon Harness',
        Hands = 'War Gloves +1',
        Ring1 = 'Spinel Ring',
        Ring2 = 'Spinel Ring',
        -- Ring1 = 'Toreador\'s Ring',
        -- Ring2 = 'Toreador\'s Ring',
        Back = 'Forager\'s Mantle',
        Waist = 'Life Belt',
        -- Waist = 'R.K. Belt +1',
        Legs = 'Homam Cosciales',
        -- Legs = 'Republic Subligar',
        Feet = 'Bounding Boots',
    },
    WS_SharkBite = {},

    SA = {
        -- DEX
        Head = 'Emperor Hairpin',
        Neck = 'Love Torque',
        Ear1 = 'Merman\'s Earring',
        Ear2 = 'Pixie Earring',
        Body = 'Dargon Harness',
        Hands = 'San. Gloves',
        Ring1 = 'Spinel Ring',
        Ring2 = 'Spinel Ring',
        Back = 'Assassin\'s Cape',
        Waist = 'R.K. Belt +1',
        Legs = 'Republic Subligar',
        Feet = 'Bounding Boots',  
    },
    TA = {
        -- AGI
        Head = 'Emperor Hairpin',
        Neck = 'Love Torque',
        Ear1 = 'Drone Earring',
        Ear2 = 'Drone Earring',
        Body = 'Dargon Harness',
        Hands = 'San. Gloves',
        Ring1 = 'Sattva Ring',
        Ring2 = 'Emerald Ring',
        Back = 'Assassin\'s Cape',
        Waist = 'R.K. Belt +1',
        Legs = 'Republic Subligar',
        Feet = 'Bounding Boots',
    },
    SATA = {
        Head = 'Emperor Hairpin',
        Neck = 'Love Torque',
        Ear1 = 'Drone Earring',
        Ear2 = 'Pixie Earring',
        Body = 'Dargon Harness',
        Hands = 'San. Gloves',
        Ring1 = 'Sattva Ring',
        Ring2 = 'Spinel Ring',
        Back = 'Assassin\'s Cape',
        Waist = 'R.K. Belt +1',
        Legs = 'Republic Subligar',
        Feet = 'Bounding Boots',
    },

    Flee = {
        Feet = 'Rogue\'s Poulaines',
    },
    Hide = {},
    Steal = {
        Head = 'Rogue\'s Bonnet',
        Hands = 'Thief\'s Kote',
        Feet = 'Rogue\'s Poulaines',
    },
    Mug = {
        Head = 'Rogue\'s Bonnet',
        Feet = 'Rogue\'s Poulaines',
    },

    TH = {
        Neck = 'Nanaa\'s Charm',
        Hands = 'Assassin\'s Armlets',
    },

    Ranged = {
        Head = 'Optical Hat',
        Ear1 = 'Drone Earring',
        Ear2 = 'Drone Earring',
        Body = 'Rapparee Harness',
        Ring1 = 'Coral Ring',
        Ring2 = 'Merman\'s Ring',
        Back = 'Forager\'s Mantle',
        Waist = 'R.K. Belt +1',
        Legs = 'Republic Subligar',
        Feet = 'Homam Gambieras',
    },
    Ranged_INT = {
        Head = 'Optical Hat',
        Neck = 'Checkered Scarf',
        Ear1 = 'Abyssal Earring',
        Ear2 = 'Morion Earring',
        Body = 'Rapparee Harness',
        Ring1 = 'Diamond Ring',
        Ring2 = 'Diamond Ring',
        Back = 'Forager\'s Mantle',
        Waist = 'R.K. Belt +1',
        Legs = 'Republic Subligar',
        Feet = 'Homam Gambieras',
    },
}
profile.Sets = sets

profile.SetMacroBook = function()
    AshitaCore:GetChatManager():QueueCommand(1, '/macro book 3')
    AshitaCore:GetChatManager():QueueCommand(1, '/macro set 1')
end

--[[
--------------------------------
Everything below can be ignored.
--------------------------------
]]

local saOverride = 0
local taOverride = 0

gcmelee = gFunc.LoadFile('common\\gcmelee.lua')

profile.HandleAbility = function()
    local action = gData.GetAction()
    if (action.Name == 'Flee') then
        gFunc.EquipSet(sets.Flee)
    elseif (action.Name == 'Hide') then
        gFunc.EquipSet(sets.Hide)
    elseif (action.Name == 'Steal') then
        gFunc.EquipSet(sets.Steal)
    elseif (action.Name == 'Mug') then
        gFunc.EquipSet(sets.Mug)
    elseif (action.Name == 'Sneak Attack') then
        saOverride = os.clock() + 2
    elseif (action.Name == 'Trick Attack') then
        taOverride = os.clock() + 2
    end

    if (gcdisplay.GetToggle('TH')) then
        gFunc.EquipSet(sets.TH)
    end
end

profile.HandleItem = function()
    gcinclude.DoItem()
end

profile.HandlePreshot = function()
    -- You may add logic here
end

profile.HandleMidshot = function()
    gFunc.EquipSet(sets.Ranged)

    local ammo = ((gData.GetEquipment())['Ammo'])['Name']
    if (ammo == 'Bloody Bolt') then
        gFunc.EquipSet(sets.Ranged_INT)
    end

    if (gcdisplay.GetToggle('TH')) then
        gFunc.EquipSet(sets.TH)
    end
end

profile.HandleWeaponskill = function()
    gFunc.EquipSet(sets.WS)

    local action = gData.GetAction()
    if (action.Name == 'Evisceration') then
        gFunc.EquipSet(sets.WS_Evisceration)
    elseif (action.Name == 'Shark Bite') then
        gFunc.EquipSet(sets.WS_SharkBite)
    end

    local ta = gData.GetBuffCount('Trick Attack')
    if (ta > 0) or (os.clock() < taOverride) then
        if (ta_rogue_armlets) then
            gFunc.Equip('Hands', 'Rogue\'s Armlets +1')
        end
    end

    gcmelee.DoFenrirsEarring()
end

profile.OnLoad = function()
    gcmelee.Load()
    profile.SetMacroBook()

    gcinclude.SetAlias(T{'th'})
    local function createToggle()
        gcdisplay.CreateToggle('TH', false)
    end
    createToggle:once(2)

    -- BIND KEYS
    AshitaCore:GetChatManager():QueueCommand(-1, '/bind \' //bully <t>')
    AshitaCore:GetChatManager():QueueCommand(-1, '/bind ; /ra <t>')
    AshitaCore:GetChatManager():QueueCommand(-1, '/bind [ /fl;/sl blink')
    AshitaCore:GetChatManager():QueueCommand(-1, '/bind l /th')
    AshitaCore:GetChatManager():QueueCommand(-1, '/bind 1 /equip ammo "Acid Bolt";/echo > Acid Bolts')
    AshitaCore:GetChatManager():QueueCommand(-1, '/bind 2 /equip ammo "Bloody Bolt";/echo > Bloody Bolts')
    AshitaCore:GetChatManager():QueueCommand(-1, '/bind 3 /equip ammo "Sleep Bolt";/echo > Sleep Bolts')
    
end

profile.OnUnload = function()
    gcmelee.Unload()
    gcinclude.ClearAlias(T{'th'})

    -- UNBIND KEYS
    AshitaCore:GetChatManager():QueueCommand(-1, '/unbind \'');
    AshitaCore:GetChatManager():QueueCommand(-1, '/unbind ;');
    AshitaCore:GetChatManager():QueueCommand(-1, '/unbind [');
    AshitaCore:GetChatManager():QueueCommand(-1, '/unbind l');
    AshitaCore:GetChatManager():QueueCommand(-1, '/unbind 1');
    AshitaCore:GetChatManager():QueueCommand(-1, '/unbind 2');
    AshitaCore:GetChatManager():QueueCommand(-1, '/unbind 3');
end

profile.HandleCommand = function(args)
    if (args[1] == 'th') then
        gcdisplay.AdvanceToggle('TH')
        gcinclude.Message('TH', gcdisplay.GetToggle('TH'))
    else
        gcmelee.DoCommands(args)
    end

    if (args[1] == 'horizonmode') then
        profile.HandleDefault()
    end

     -- Add bolt type display when using number keys
     if (args[1] == 'bolt') then
        local boltType = args[2]
        if boltType then
            gcinclude.Message('Bolt Type', string.ucfirst(boltType))
        end
    end
end

profile.HandleDefault = function()
    gcmelee.DoDefault()

    local player = gData.GetPlayer()
    if (player.SubJob == 'NIN' and player.Status == 'Engaged') then
        gFunc.EquipSet('TP_NIN')
    end

    gcmelee.DoDefaultOverride()

    local sa = gData.GetBuffCount('Sneak Attack')
    local ta = gData.GetBuffCount('Trick Attack')

    if (sa == 1 and ta == 1) or (os.clock() < saOverride and os.clock() < taOverride) then
        gFunc.EquipSet(sets.SATA)
    elseif (sa == 1) or (os.clock() < saOverride) then
        gFunc.EquipSet(sets.SA)
    elseif (ta == 1) or (os.clock() < taOverride) then
        gFunc.EquipSet(sets.TA)
    end

    gFunc.EquipSet(gcinclude.BuildLockableSet(gData.GetEquipment()))

    if (player.Status == 'Engaged' and gcdisplay.GetToggle('TH')) then
        gFunc.EquipSet(sets.TH)
    end
end

profile.HandlePrecast = function()
    gcmelee.DoPrecast(fastCastValue)
end

profile.HandleMidcast = function()
    gcmelee.DoMidcast(sets)

    local action = gData.GetAction()
    if (action.Skill ~= 'Ninjutsu' and gcdisplay.GetToggle('TH')) then
        gFunc.EquipSet(sets.TH)
    end
end

return profile
