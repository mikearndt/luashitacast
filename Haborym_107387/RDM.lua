local profile = {}

local fastCastValue = 0.42 -- 20% from traits 22% from gear listed in Precast set

local ninSJMaxMP = 685 -- The Max MP you have when /nin in your idle set
local whmSJMaxMP = 767 -- The Max MP you have when /whm in your idle set
local blmSJMaxMP = 782 -- The Max MP you have when /blm in your idle set
local drkSJMaxMP = nil -- The Max MP you have when /drk in your idle set

local blue_cotehardie = false
local blue_cotehardie_plus_one = false
local dilation_ring = false
local dilation_ring_slot = 'Ring2'

local sets = {
    Idle = {
        Main = 'Terra\'s Staff',
        Range = '',
        Ammo = 'Hedgehog Bomb',
        Head = 'Dls. Chapeau +1',
        Neck = 'Jeweled Collar',
        Ear1 = 'Merman\'s Earring',
        Ear2 = 'Merman\'s Earring',
        Body = 'Dst. Harness +1',
        Hands = 'Dst. Mittens +1',
        Ring1 = 'Sattva Ring',
        Ring2 = 'Jelly Ring',
        Back = 'Umbra Cape',
        -- Waist = 'Warwolf Belt',
        Waist = 'Penitent\'s Rope',
        Legs = 'Blood Cuisses',
        Feet = 'Dst. Leggings +1',
    },
    IdleALT = {
        Main = 'Terra\'s Staff',
        Range = '',
        Ammo = 'Hedgehog Bomb',
        Head = 'Dls. Chapeau +1',
        Neck = 'Jeweled Collar',
        Ear1 = 'Merman\'s Earring',
        Ear2 = 'Merman\'s Earring',
        Body = 'Duelist\'s Tabard',
        Hands = 'Coral Fng. Gnt. +1',
        Ring1 = 'Sattva Ring',
        Ring2 = 'Merman\'s Ring',
        Back = 'Hexerei Cape',
        -- Waist = 'Warwolf Belt',
        Waist = 'Hierarch Belt',
        Legs = 'Blood Cuisses',
        Feet = 'Coral Greaves +1',
    },
    IdleMaxMP = {
        Main = 'Terra\'s Staff',
        Range = '',
        Ammo = 'Hedgehog Bomb',
        Head = 'Dls. Chapeau +1',
        Neck = 'Uggalepih Pendant',
        Ear1 = 'Loquac. Earring',
        Ear2 = 'Magnetic Earring',
        Body = 'Duelist\'s Tabard',
        Hands = 'Zenith Mitts',
        -- Hands = 'Blood Fng. Gnt.',
        Ring1 = 'Sattva Ring',
        Ring2 = 'Vilma\'s Ring',
        Back = 'Umbra Cape',
        Waist = 'Hierarch Belt',
        Legs = 'Blood Cuisses',
        Feet = 'Mahatma Pigaches',
        -- Feet = 'Blood Greaves',
    },
    Resting = {
        Main = 'Dark Staff',
        Range = '',
        Ammo = 'Hedgehog Bomb',
        Head = 'Dls. Chapeau +1',
        Neck = 'Checkered Scarf',
        -- Ear1 = 'Relaxing Earring',
        Ear2 = 'Magnetic Earring',
        Body = 'Errant Hpl.',
        -- Hands = 'Hydra Gloves',
        -- Back = 'Errant Cape',
        Waist = 'Duelist\'s Belt',
        Legs = 'Baron\'s Slops',
        -- Legs = 'Hydra Brais',
        -- Feet = 'Hydra Gaiters',
    },
    Town = {},
    Movement = {
        Head = 'Dls. Chapeau +1',
        Legs = 'Blood Cuisses',
    },

    DT = {
        -- 49% total PDT
        Main = 'Terra\'s Staff',        -- 20
        Range = '',
        Ammo = 'Fortune Egg',
        -- Head = 'Dls. Chapeau +1',
        Head = 'Darksteel Cap +1',      -- 2
        Neck = 'Jeweled Collar',
        Ear1 = 'Merman\'s Earring',
        Ear2 = 'Merman\'s Earring',
        Body = 'Dst. Harness +1',       -- 4
        Hands = 'Dst. Mittens +1',      -- 2
        Ring1 = 'Sattva Ring',          -- 5
        Ring2 = 'Jelly Ring',           -- 5
        Back = 'Umbra Cape',            -- 6
        -- Waist = 'Warwolf Belt',
        Legs = 'Dst. Subligar +1',      -- 3
        Feet = 'Dst. Leggings +1',      -- 2
    },
    DTNight = {
        -- 50% total PDT
        Main = 'Terra\'s Staff',        -- 20
        Range = '',
        Ammo = 'Fortune Egg',
        Head = 'Dls. Chapeau +1',
        Neck = 'Jeweled Collar',
        Ear1 = 'Merman\'s Earring',
        Ear2 = 'Merman\'s Earring',
        Body = 'Dst. Harness +1',       -- 4
        Hands = 'Dst. Mittens +1',      -- 2
        Ring1 = 'Sattva Ring',          -- 5
        Ring2 = 'Jelly Ring',           -- 5
        Back = 'Umbra Cape',            -- 12
        -- Waist = 'Warwolf Belt',
        Legs = 'Blood Cuisses',
        Feet = 'Dst. Leggings +1',      -- 2
    },
    MDT = {
        -- 43% total MDT
        -- Shell IV provides 23% MDT, 20% from gear
        Main = 'Terra\'s Staff',
        Range = '',
        Ammo = 'Fortune Egg',
        Head = 'Dls. Chapeau +1',
        Neck = 'Jeweled Collar',
        Ear1 = 'Merman\'s Earring',     -- 2
        Ear2 = 'Merman\'s Earring',     -- 2
        -- Body = 'Cor. Scale Mail +1',    -- 4
        Hands = 'Coral Fng. Gnt. +1',   -- 2
        Ring1 = 'Sattva Ring',          -- 5
        Ring2 = 'Merman\'s Ring',       -- 4
        Back = 'Hexerei Cape',          -- 3
        Waist = 'Penitent\'s Rope',
        -- Legs = 'Coral Cuisses +1', -- 3
        Feet = 'Coral Greaves +1',      -- 2
    },
    FireRes = {},
    IceRes = {},
    LightningRes = {},
    EarthRes = {},
    WindRes = {},
    WaterRes = {},
    Evasion = {},

    Precast = {
        -- 22% fast cast from gear
        Head = 'Warlock\'s Chapeau',    -- 10
        Ear1 = 'Loquac. Earring',       -- 2
        Body = 'Duelist\'s Tabard',     -- 10
    },
    Casting = {
        -- Default Casting Equipment when using Idle sets
        -- 28% SIRD
        Main = 'Terra\'s Staff',
        -- Main = 'Hermit\'s Wand',        -- 25
        -- Sub = 'Genbu\'s Shield',
        -- Head = 'Nashira Turban',        -- 10
        -- Neck = 'Willpower Torque',      -- 5
        Ear1 = 'Merman\'s Earring',
        Ear2 = 'Magnetic Earring',      -- 8
        Body = 'Warlock\'s Tabard',     -- 12
        Ring1 = 'Sattva Ring',
        Ring2 = 'Jelly Ring',
        Back = 'Umbra Cape',
        Waist = 'Silver Obi +1',        -- 8
        Legs = 'Dst. Subligar +1',
        -- Feet = 'Mountain Gaiters',      -- 5
    },
    SIRD = {
        -- Used on Stoneskin, Blink, Aquaveil and Utsusemi casts
        -- 28% SIRD
        Main = 'Terra\'s Staff',
        -- Main = 'Hermit\'s Wand',        -- 25
        -- Sub = 'Genbu\'s Shield',
        -- Head = 'Nashira Turban',        -- 10
        -- Neck = 'Willpower Torque',      -- 5
        Ear1 = 'Merman\'s Earring',
        Ear2 = 'Magnetic Earring',      -- 8
        Body = 'Warlock\'s Tabard',     -- 12
        Ring1 = 'Sattva Ring',
        Ring2 = 'Jelly Ring',
        Back = 'Umbra Cape',
        Waist = 'Silver Obi +1',        -- 8
        Legs = 'Dst. Subligar +1',
        -- Feet = 'Mountain Gaiters',      -- 5
    },
    Haste = {
        -- Used only on Haste, Refresh, Blink and Utsusemi casts
        Head = 'Warlock\'s Chapeau',
        Ear1 = 'Loquac. Earring',
        Body = 'Duelist\'s Tabard',
        -- Hands = 'Dusk Gloves',
        Waist = 'Swift Belt',
        Legs = 'Nashira Seraweels',
        -- Feet = 'Dusk Ledelsens',
    },
    ConserveMP = {
        Ear2 = 'Magnetic Earring',
    },

    Hate = {
        -- Switches to this set when casting Sleep, Blind, Dispel and Bind if /hate is toggled on
    },
    Cheat_C3HPDown = {},
    Cheat_C4HPDown = {},
    Cheat_HPUp = {},

    Cure = {
        -- -35 enmity
        Ammo = 'Hedgehog Bomb',     -- 1
        Head = "Raven Beret",       -- 8
        -- Neck = 'Benign Necklace',   -- 2
        Neck = 'Promise Badge',
        -- Ear1 = 'Novia Earring',     -- 7
        Ear2 = 'Magnetic Earring',
        Body = 'Raven Jupon',       -- 9
        Hands = 'Raven Bracers',    -- 5
        Ring1 = 'Solace Ring',
        Ring2 = 'Solace Ring',
        Back = 'Red Cape +1',
        Waist = 'Penitent\'s Rope', -- 3
        Legs = 'Raven Hose',        -- 6
        Feet = 'Raven Pigaches',    -- 3
    },
    Cursna = {
        Body = 'Duelist\'s Tabard',
        Legs = 'Warlock\'s Tights',
        -- Back = 'Altruistic Cape',
    },

    Enhancing = {
        Main = 'Water Staff',
        Ammo = 'Hedgehog Bomb',
        Head = 'Warlock\'s Chapeau',
        Neck = 'Enhancing Torque',
        Ear1 = 'Loquac. Earring',
        Ear2 = 'Magnetic Earring',
        Body = 'Errant Hpl.',
        -- Hands = 'Dusk Gloves',
        Ring1 = 'Solace Ring',
        Ring2 = 'Solace Ring',
        -- Back = 'Merciful Cape',
        Waist = 'Swift Belt',
        Legs = 'Warlock\'s Tights',
        -- Feet = 'Dusk Ledelsens',
    },
    Stoneskin = {
        -- Neck = 'Stone Gorget',
        -- Hands = 'Dusk Gloves',
        Back = 'Red Cape +1',
    },
    Spikes = {
        Main = 'Ice Staff',
        Ammo = 'Phtm. Tathlum',
        Head = 'Warlock\'s Chapeau',
        Neck = 'Enhancing Torque',
        Ear1 = 'Novio Earring',
        Ear2 = 'Moldavite Earring',
        Body = 'Errant Hpl.',
        -- Hands = 'Dusk Gloves',
        Ring1 = 'Diamond Ring',
        Ring2 = 'Diamond Ring',
        -- Back = 'Merciful Cape',
        Waist = 'Penitent\'s Rope',
        Legs = 'Warlock\'s Tights',
        Feet = 'Duelist\'s Boots',
    },

    Enfeebling = {
        Head = 'Dls. Chapeau +1',
        Body = 'Errant Hpl.',
        Back = 'Red Cape +1',
        Waist = 'Penitent\'s Rope',
        Legs = 'Mahatma Slops',
    },
    EnfeeblingMND = {
        Ammo = 'Hedgehog Bomb',
        Neck = 'Promise Badge',
        -- Ear1 = 'Cmn. Earring',
        -- Ear2 = 'Cmn. Earring',
        Hands = 'Devotee\'s Mitts',
        Ring1 = 'Solace Ring',
        Ring2 = 'Solace Ring',
        Feet = 'Mahatma Pigaches',
    },
    EnfeeblingINT = {
        Ammo = 'Phtm. Tathlum',
        Neck = 'Checkered Scarf',
        Ear1 = 'Abyssal Earring',
        Ear2 = 'Morion Earring',
        Hands = 'Errant Cuffs',
        Ring1 = 'Diamond Ring',
        Ring2 = 'Diamond Ring',
        Feet = 'Wise Pigaches',
    },
    EnfeeblingACC = {
        Head = 'Dls. Chapeau +1',
        Neck = 'Enfeebling Torque',
        -- Ear2 = 'Enfeebling Earring',
        Body = 'Warlock\'s Tabard',
        -- Back = 'Altruistic Cape',
        Legs = 'Nashira Seraweels',
    },

    Divine = {
        -- Just using my Hate set here for Flash
        },
    Dark = {
        Ammo = 'Phtm. Tathlum',
        -- Head = 'Nashira Turban',
        -- Neck = 'Dark Torque',
        Ear1 = 'Abyssal Earring',
        Ear2 = 'Morion Earring',
        Body = 'Errant Hpl.',
        -- Body = 'Nashira Manteel',
        -- Hands = 'Blood Fng. Gnt.',
        Ring1 = 'Diamond Ring',
        Ring2 = 'Diamond Ring',
        -- Back = 'Merciful Cape',
        Waist = 'Penitent\'s Rope',
        Legs = 'Mahatma Slops',
        -- Feet = 'Nashira Crackows',
    },

    Nuke = {
        Ammo = 'Phtm. Tathlum',
        Head = 'Warlock\'s Chapeau',
        -- Neck = 'Elemental Torque',
        Neck = 'Checkered Scarf',
        Ear1 = 'Abyssal Earring',
        Ear2 = 'Moldavite Earring',
        Body = 'Errant Hpl.',
        Hands = 'Zenith Mitts',
        Ring1 = 'Diamond Ring',
        Ring2 = 'Diamond Ring',
        Back = 'Red Cape +1',
        Waist = 'Penitent\'s Rope',
        Legs = 'Mahatma Slops',
        Feet = 'Duelist\'s Boots',
    },
    NukeACC = {
        Back = 'Merciful Cape',
        Legs = 'Duelist\'s Tights',
        Feet = 'Nashira Crackows',
    },
    NukeDOT = {
        Ear1 = 'Abyssal Earring',
        Ear2 = 'Morion Earring',
        Hands = 'Errant Cuffs',
        Back = 'Red Cape +1',
        -- Back = 'Merciful Cape',
        Legs = 'Duelist\'s Tights',
        Feet = 'Wise Pigaches',
        -- Feet = 'Nashira Crackows',
    },

    Convert = {
        -- Type /vert to equip this set and /lock your gear at the same time.
        Main = 'Light Staff',
        Ammo = 'Hedgehog Bomb',
        Neck = 'Uggalepih Pendant',
        Ear1 = 'Loquac. Earring',
        Ear2 = 'Magnetic Earring',
        Body = 'Duelist\'s Tabard',
        Hands = 'Zenith Mitts',
        Ring1 = 'Sattva Ring',
        Ring2 = 'Vilma\'s Ring',
        -- Back = 'Errant Cape',
        Waist = 'Hierarch Belt',
        Legs = 'Blood Cuisses',
        Feet = 'Mahatma Pigaches',
    },
    ConvertOOR = {
        -- Out of Region Convert Set
        Main = 'Light Staff',
        Ammo = 'Hedgehog Bomb',
        Neck = 'Uggalepih Pendant',
        Ear1 = 'Loquac. Earring',
        Ear2 = 'Magnetic Earring',
        Body = 'Duelist\'s Tabard',
        Hands = 'Zenith Mitts',
        Ring1 = 'Sattva Ring',
        Ring2 = 'Vilma\'s Ring',
        -- Back = 'Errant Cape',
        Waist = 'Hierarch Belt',
        Legs = 'Blood Cuisses',
        Feet = 'Mahatma Pigaches',
    },

    Stun = {
        Main = 'Thunder Staff',
        Ammo = 'Phtm. Tathlum',
        Head = 'Warlock\'s Chapeau',
        -- Neck = 'Dark Torque',
        Ear1 = 'Loquac. Earring',
        Ear2 = 'Abyssal Earring',
        Body = 'Duelist\'s Tabard',
        Hands = 'Errant Cuffs',
        -- Hands = 'Dusk Gloves',
        Ring1 = 'Diamond Ring',
        Ring2 = 'Diamond Ring',
        Back = 'Red Cape +1',
        -- Back = 'Merciful Cape',
        Waist = 'Swift Belt',
        Legs = 'Nashira Seraweels',
        Feet = 'Wise Pigaches',
        -- Feet = 'Dusk Ledelsens',
    },
    StunACC = {
        -- You can also type /csstun to equip this set and /lock your gear
        -- at the same time if you have a tinfoil hat.
        Main = 'Thunder Staff',
        Ammo = 'Phtm. Tathlum',
        -- Head = 'Nashira Turban',
        -- Neck = 'Dark Torque',
        -- Ear1 = 'Dark Earring',
        Ear2 = 'Abyssal Earring',
        -- Body = 'Nashira Manteel',
        Hands = 'Errant Cuffs',
        Ring1 = 'Diamond Ring',
        Ring2 = 'Diamond Ring',
        Back = 'Red Cape +1',
        -- Back = 'Merciful Cape',
        Waist = 'Penitent\'s Rope',
        Legs = 'Mahatma Slops',
        Feet = 'Wise Pigaches',
    },

    TP = {},
    TP_NIN = {},
    WS = {},
    WS_Soil = {},
    WS_Evisceration = {},
    WS_Spirits = {},
    WS_Energy = {},

    LockSet1 = {},
    LockSet2 = {},
    LockSet3 = {},
}
profile.Sets = sets

profile.SetMacroBook = function()
    AshitaCore:GetChatManager():QueueCommand(1, '/macro book 1')
    AshitaCore:GetChatManager():QueueCommand(1, '/macro set 1')
    

    -- Set Keybinds
    local player = gData.GetPlayer()
    if player.SubJob == 'WHM' then
        AshitaCore:GetChatManager():QueueCommand(-1, '/bind \' //regen')
        AshitaCore:GetChatManager():QueueCommand(-1, '/bind ; //erase')
    end
    if player.SubJob == 'DRK' then
        AshitaCore:GetChatManager():QueueCommand(-1, '/bind \' //stun')
    end
end

--[[
--------------------------------
Everything below can be ignored.
--------------------------------
]]

gcmage = gFunc.LoadFile('common\\gcmage.lua')

profile.HandleAbility = function()
    -- You may add logic here
end

profile.HandleItem = function()
    gcinclude.DoItem()
end

profile.HandlePreshot = function()
    -- You may add logic here
end

profile.HandleMidshot = function()
    -- You may add logic here
end

profile.HandleWeaponskill = function()
    local action = gData.GetAction()

    gFunc.EquipSet(sets.WS)
    gcmage.DoFenrirsEarring()

    if (action.Name == 'Savage Blade') or (action.Name == 'Vorpal Blade') or (action.Name == 'Swift Blade') then
        gFunc.EquipSet(sets.WS_Soil)
    end

    if (action.Name == 'Evisceration') then
        gFunc.EquipSet(sets.WS_Soil)
        gFunc.EquipSet(sets.Evisceration)
    end

    if (action.Name == 'Energy Drain') or (action.Name == 'Energy Steal') then
        gFunc.EquipSet(sets.WS_Energy)
    end

    if (action.Name == 'Spirits Within') then
        gFunc.EquipSet(sets.WS_Spirits)
    end
end

profile.OnLoad = function()
    gcmage.Load()
    profile.SetMacroBook()
end

profile.OnUnload = function()
    gcmage.Unload()

    -- Remove keybinds
    AshitaCore:GetChatManager():QueueCommand(-1, '/unbind ;');
    AshitaCore:GetChatManager():QueueCommand(-1, '/unbind \'');
end

profile.HandleCommand = function(args)
    gcmage.DoCommands(args)

    if (args[1] == 'horizonmode') then
        profile.HandleDefault()
    end
end

profile.HandleDefault = function()
    gcmage.DoDefault(ninSJMaxMP, whmSJMaxMP, blmSJMaxMP, nil, drkSJMaxMP)

    local player = gData.GetPlayer()
    if (blue_cotehardie and player.MP <= 40) then
        gFunc.Equip('Body', 'Blue Cotehardie')
    end
    if (blue_cotehardie_plus_one and player.MP <= 50) then
        gFunc.Equip('Body', 'Blue Cotehard. +1')
    end

    gFunc.EquipSet(gcinclude.BuildLockableSet(gData.GetEquipment()))
end

profile.HandlePrecast = function()
    gcmage.DoPrecast(fastCastValue)
end

profile.HandleMidcast = function()
    gcmage.DoMidcast(sets, ninSJMaxMP, whmSJMaxMP, blmSJMaxMP, nil, drkSJMaxMP)

    local action = gData.GetAction()
    if (dilation_ring) then -- Haste is technically MP inefficient but I prefer to just always use it anyway
        if (action.Name == 'Haste' or action.Name == 'Refresh') then
            gFunc.Equip(dilation_ring_slot, 'Dilation Ring')
        end
    end
end

return profile
