local profile = {}

local fastCastValue = 0.04 -- Only include Fast Cast e.g. Loquacious Earring, Rostrum Pumps
local fastCastValueSong = 0.37 -- Only include Song Spellcasting Time e.g. Minstrel's Ring, Sha'ir Manteel

local ninSJMaxMP = nil -- The Max MP you have when /nin in your idle set
local whmSJMaxMP = nil -- The Max MP you have when /whm in your idle set
local rdmSJMaxMP = nil -- The Max MP you have when /rdm in your idle set
local blmSJMaxMP = nil -- The Max MP you have when /blm in your idle set

local hpDownTotal = 122 -- The total HP down from Precast_Songs_HPDown set

local minstrels_earring = false
local minstrels_earring_slot = 'Ear2'

local sets = {
    Idle = {
        Main = 'Terra\'s Staff',
        Head = 'Darksteel Cap +1',
        Neck = 'Evasion Torque',
        Ear1 = 'Merman\'s Earring',
        Ear2 = 'Merman\'s Earring',
        Body = 'Dst. Harness +1',
        Hands = 'Dst. Mittens +1',
        Ring1 = 'Sattva Ring',
        Ring2 = 'Jelly Ring',
        Back = 'Umbra Cape',
        Waist = 'Scouter\'s Rope',
        Legs = 'Dst. Subligar +1',
        Feet = 'Dst. Leggings +1',
    },
    IdleALT = {
        Main = 'Terra\'s Staff',
        Head = 'Emperor Hairpin',
        Neck = 'Evasion Torque',
        Ear1 = 'Melody Earring',
        Ear2 = 'Musical Earring',
        Body = 'Raven Jupon',
        Hands = 'Raven Bracers',
        Ring1 = 'Sattva Ring',
        Ring2 = 'Jelly Ring',
        Back = 'Umbra Cape',
        Waist = 'Scouter\'s Rope',
        Legs = 'Raven Hose',
        Feet = 'Dst. Leggings +1',
    },
    IdleMaxMP = {},
    Resting = {
        Main = 'Dark Staff',
        Head = 'Crow Beret',
        Neck = 'Checkered Scarf',
        -- Ear1 = 'Relaxing Earring',
        Ear2 = 'Magnetic Earring',
        Body = 'Errant Hpl.',
        Legs = 'Baron\'s Slops',
    },
    Town = {
        Body = 'Sha\'ir Manteel',
        Neck = 'Jeweled Collar',
    },
    Movement = {},

    DT = { 
        -- 49% total PDT
        Main = 'Terra\'s Staff',    -- 20
        Head = 'Darksteel Cap +1',  -- 2
        Neck = 'Jeweled Collar',
        Ear1 = 'Merman\'s Earring',
        Ear2 = 'Merman\'s Earring',
        Body = 'Dst. Harness +1',   -- 4
        Hands = 'Dst. Mittens +1',  -- 2
        Ring1 = 'Sattva Ring',      -- 5
        Ring2 = 'Jelly Ring',       -- 5
        Back = 'Umbra Cape',        -- 6
        -- Waist = 'Warwolf Belt',
        Legs = 'Dst. Subligar +1',  -- 3
        Feet = 'Dst. Leggings +1',  -- 2
    },
    DTNight = {
        -- 50% total PDT
        Main = 'Terra\'s Staff',    -- 20
        Head = 'Darksteel Cap +1',  -- 2
        Neck = 'Jeweled Collar',
        Ear1 = 'Merman\'s Earring',
        Ear2 = 'Merman\'s Earring',
        Body = 'Dst. Harness +1',   -- 4
        Hands = 'Dst. Mittens +1',  -- 2
        Ring1 = 'Sattva Ring',      -- 5
        Back = 'Umbra Cape',        -- 12
        -- Waist = 'Warwolf Belt',
        Legs = 'Dst. Subligar +1',  -- 3
        Feet = 'Dst. Leggings +1',  -- 2
    },
    MDT = { 
        -- 39% MDT
        -- Shell IV provides 23% MDT + 16% from gear
        Neck = 'Jeweled Collar',
        Ear1 = 'Merman\'s Earring', -- 2
        Ear2 = 'Merman\'s Earring', -- 2
        Ring1 = 'Sattva Ring',      -- 5
        Ring2 = 'Merman\'s Ring',   -- 4
        Back = 'Hexerei Cape',      -- 3
    },
    FireRes = {},
    IceRes = {},
    LightningRes = {},
    EarthRes = {},
    WindRes = {},
    WaterRes = {},
    Evasion = {},

    Precast_Songs_HPDown = {
        -- This set will equip even before precast for songs
        -- in case you require HP Down equipment to trigger Minstrel's Ring
        Head = 'Emperor Hairpin',   -- -15
        Neck = 'Checkered Scarf',   -- -12
        Hands = 'Zenith Mitts',     -- -15
        Ring1 = 'Vilma\'s Ring',    -- -25
        Waist = 'Penitent\'s Rope', -- -20
    },
    Precast = {
       Ear2 = 'Loquac. Earring',
       Feet = 'Rostrum Pumps',
    },
    Precast_Songs = {
        Main = 'Tutelary',          -- 30
        Sub = 'Genbu\'s Shield',    -- 0
        -- Head = 'Genbu\'s Kabuto',    -- 50
        Head = 'Bard\'s Roundlet',  -- 13
        Neck = 'Shield Pendant',    -- 20
        Ear1 = 'Pigeon Earring',    -- 20
        Ear2 = 'Loquac. Earring',
        Body = 'Sha\'ir Manteel',
        Hands = 'Seiryu\'s Kote',   -- 50
        Ring1 = 'Bomb Queen Ring',  -- 45
        Ring2 = 'Minstrel\'s Ring',
        Back = 'Gigant Mantle',     -- 80
        Waist = 'Koenigs Belt',     -- 20
        Legs = 'Sha\'ir Saraweels', -- 20
        Feet = 'Rostrum Pumps',
    },
    Casting = {
        -- Default Casting Equipment when using Idle sets
        Main = 'Terra\'s Staff',
        Range = 'Angel Lyre',
        Neck = 'Evasion Torque',
        Ear1 = 'Merman\'s Earring',
        Ear2 = 'Merman\'s Earring',
        Head = 'Darksteel Cap +1',
        Body = 'Dst. Harness +1',
        Hands = 'Dst. Mittens +1',
        Ring1 = 'Sattva Ring',
        Ring2 = 'Merman\'s Ring',
        Back = 'Umbra Cape',
        -- Waist = 'Powerful Rope',
        Legs = 'Dst. Subligar +1',
        Feet = 'Dst. Leggings +1',
    },
    SIRD = {
        -- Used on Stoneskin, Blink, Aquaveil and Utsusemi casts
        Main = 'Terra\'s Staff',
        Ear1 = 'Magnetic Earring',
        Waist = 'Silver Obi +1',
    },
    Haste = {
        -- Used only on Haste, Refresh, Blink and Utsusemi casts
        Range = 'Angel Lyre',
        Body = 'Sha\'ir Manteel',
        Ear1 = 'Magnetic Earring',
        -- Hands = 'Dusk Gloves',
        Waist = 'Swift Belt',
        -- Legs = 'Byakko\'s Haidate',
        -- Feet = 'Dusk Ledelsens',
    },
    ConserveMP = {
        Ear2 = 'Magnetic Earring',
    },

    Sing_Default = {
        Head = 'Bard\'s Roundlet',
        Neck = 'Wind Torque',
        -- Ear1 = 'Singing Earring',
        Ear1 = 'String Earring',
        Ear2 = 'Musical Earring',
        Hands = 'Chl. Cuffs +1',
        Legs = 'Chl. Cannions +1',
        -- Back = 'Astute Cape',
    },
    Sing_Buff = {
        Main = 'Chanter\'s Staff',
        Body = 'Minstrel\'s Coat',
    },
    Sing_Debuff = {
        Body = 'Errant Hpl.',
        Ring1 = 'Angel\'s Ring',
        Ring2 = 'Angel\'s Ring',
        Back = 'Jester\'s Cape +1',
        Waist = 'Gleeman\'s Belt',
        Feet = 'Sha\'ir Crackows',
    },

    Sing_Ballad_Large = {
        Range = 'Angel Lyre',
    },
    Sing_Ballad_Small = {
        Range = 'Horn +1',
    },
    Sing_Paeon = {
        -- Range = 'Ebony Harp +1',
        Range = 'Angel Lyre',
        Neck = 'String Torque',
    },
    Sing_Mazurka = {
        Range = 'Harlequin\'s Horn',
        -- Ear1 = 'String Earring',
        -- Neck = 'String Torque',
        Hands = 'Sheikh Gages',
    },
    Sing_Minuet = {
        Range = 'Cornette +1',
    },
    Sing_March = {
        Range = 'Faerie Piccolo',
    },
    Sing_Madrigal = {
        Range = 'Traversiere +2',
    },
    Sing_Elegy = {
        Range = 'Horn +1',
        Main = 'Terra\'s Staff',
    },
    Sing_Lullaby = {
        -- Range = 'Nursemaid\'s Harp',
        Range = 'Mary\'s Horn',
        Main = 'Light Staff',
        Legs = 'Mahatma Slops',
    },
    Sing_HordeLullaby_Large = {
        -- Range = 'Nursemaid\'s Harp',
        Range = 'Mary\'s Horn',
        Main = 'Light Staff',
        -- Ear1 = 'String Earring',
        -- Neck = 'String Torque',
        Legs = 'Mahatma Slops',
    },
    Sing_HordeLullaby_Small = {
        Range = 'Mary\'s Horn',
        Main = 'Light Staff',
        -- Ear1 = 'String Earring',
        -- Neck = 'String Torque',
        Legs = 'Mahatma Slops',
    },
    Sing_SleepRecast = {
        Hands = 'Sheikh Gages',
    },
    Sing_FinaleRequiem = {
        Range = 'Hamelin Flute',
        Main = 'Light Staff',
    },
    Sing_Carol = {
        Range = 'Crumhorn +1',
    },
    Sing_Mambo = {
        Range = 'Gemshorn +1',
    },
    Sing_Prelude = {
        Range = 'Angel\'s Flute +1',
    },
    Sing_Threnody = {
        Range = 'Sorrowful Harp',
        Ear1 = 'String Earring',
        Neck = 'String Torque',
        Legs = 'Mahatma Slops',
    },
    Sing_Hymnus = {
        Range = 'Angel Lyre',
    },

    Cure = {
        Main = 'Light Staff',
        Ammo = 'Hedgehog Bomb', 
        Head = 'Raven Beret',
        Neck = 'Justice Badge',
        Ear2 = 'Magnetic Earring',
        Body = 'Raven Jupon',
        Hands = 'Raven Bracers',
        Ring1 = 'Solace Ring',
        Ring2 = 'Solace Ring',
        Back = 'Red Cape +1',
        Waist = 'Penitent\'s Rope',
        Legs = 'Raven Hose',
        Feet = 'Mahatma Pigaches',
    },
    Cursna = {},

    Enhancing = {
        Ear2 = 'Magnetic Earring',
    },
    Stoneskin = {
        Range = 'Angel Lyre',
        Main = 'Chanter\'s Staff',
        Head = 'Raven Beret',
        -- Neck = 'Stone Gorget',
        Neck = 'Justice Badge',
        -- Ear1 = 'Geist Earring',
        Ear1 = 'Loquac. Earring',
        Ear2 = 'Magnetic Earring',
        Body = 'Errant Hpl.',
        Hands = 'Devotee\'s Mitts',
        Ring1 = 'Solace Ring',
        Ring2 = 'Solace Ring',
        Back = 'Red Cape +1',
        Waist = 'Penitent\'s Rope',
        Legs = 'Mahatma Slops',
        -- Feet = 'Suzaku\'s Sune-ate',
        Feet = 'Mahatma Pigaches',
    },
    Spikes = {},

    Enfeebling = {
        Neck = 'Enfeebling Torque',
        Back = 'Red Cape +1',
        Waist = 'Penitent\'s Rope',
        Legs = 'Mahatma Slops',
    },
    EnfeeblingMND = {},
    EnfeeblingINT = {},
    EnfeeblingACC = {},

    Divine = {},
    Dark = {},

    Nuke = {},
    NukeACC = {},
    NukeDOT = {},

    LockSet1 = {},
    LockSet2 = {},
    LockSet3 = {},

    TP = {},
    TP_NIN = {},
    WS = {},
}
profile.Sets = sets

profile.SetMacroBook = function()
    AshitaCore:GetChatManager():QueueCommand(1, '/macro book 2')
    AshitaCore:GetChatManager():QueueCommand(1, '/macro set 1')
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
    gFunc.EquipSet(sets.WS)
    gcmage.DoFenrirsEarring()
end

local songModes = {'March x2', 'Minuet x2', 'Madrigal x2', 'March & Minuet', 'March & Madrigal'}
local currentSongMode = 1

local function setSongs()
    local mode = songModes[currentSongMode]

    if mode == 'March x2' then
        AshitaCore:GetChatManager():QueueCommand(1, '/bind 1 /ma "Advancing March" <me>')
        AshitaCore:GetChatManager():QueueCommand(1, '/bind 2 /ma "Victory March" <t>')
    elseif mode == 'Minuet x2' then
        AshitaCore:GetChatManager():QueueCommand(1, '/bind 1 /ma "Valor Minuet IV" <t>')
        AshitaCore:GetChatManager():QueueCommand(1, '/bind 2 /ma "Valor Minuet III" <t>')
    elseif mode == 'Madrigal x2' then
        AshitaCore:GetChatManager():QueueCommand(1, '/bind 1 /ma "Blade Madrigal" <t>')
        AshitaCore:GetChatManager():QueueCommand(1, '/bind 2 /ma "Sword Madrigal" <t>')
    elseif mode == 'March & Minuet' then
        AshitaCore:GetChatManager():QueueCommand(1, '/bind 1 /ma "Valor Minuet IV" <t>')
        AshitaCore:GetChatManager():QueueCommand(1, '/bind 2 /ma "Victory March" <t>')
    elseif mode == 'March & Madrigal' then
        AshitaCore:GetChatManager():QueueCommand(1, '/bind 1 /ma "Sword Madrigal" <t>')
        AshitaCore:GetChatManager():QueueCommand(1, '/bind 2 /ma "Victory March" <t>')
    end
    AshitaCore:GetChatManager():AddChatMessage(6, false, string.format('\31\100Songs: %s', mode))
end

profile.OnLoad = function()
    gcmage.Load()
    profile.SetMacroBook()
    -- Set songs & modes
    gcinclude.SetAlias(T{'sballad','shorde','srecast','songs'})
    local function createToggle()
        gcdisplay.CreateToggle('SmallBallad', false)
        gcdisplay.CreateToggle('SmallHorde', false)
        gcdisplay.CreateToggle('SleepRecast', false)
    end
    createToggle:once(2)
    setSongs()

    -- Always on songs:
    AshitaCore:GetChatManager():QueueCommand(-1, '/bind 3 /ma "Mages Ballad II" <me>')
    AshitaCore:GetChatManager():QueueCommand(-1, '/bind 4 /ma "Mages Ballad" <me>')
    AshitaCore:GetChatManager():QueueCommand(-1, '/bind [ /ma "Chocobo Mazurka" <me>')

    -- Add WHM subjob specific bind
    local player = gData.GetPlayer()
    if player.SubJob == 'WHM' then
        AshitaCore:GetChatManager():QueueCommand(-1, '/bind \' //dia2')
    end
end

profile.OnUnload = function()
    gcmage.Unload()
    gcinclude.ClearAlias(T{'sballad','shorde','srecast','songs'})

    -- Remove keybinds
    AshitaCore:GetChatManager():QueueCommand(-1, '/unbind 1');
    AshitaCore:GetChatManager():QueueCommand(-1, '/unbind 2');
    AshitaCore:GetChatManager():QueueCommand(-1, '/unbind 3');
    AshitaCore:GetChatManager():QueueCommand(-1, '/unbind 4');
    AshitaCore:GetChatManager():QueueCommand(-1, '/unbind [');
    AshitaCore:GetChatManager():QueueCommand(-1, '/unbind ;');
    AshitaCore:GetChatManager():QueueCommand(-1, '/unbind \'');
end

profile.HandleCommand = function(args)
    if (args[1] == 'sballad') then
        gcdisplay.AdvanceToggle('SmallBallad')
        gcinclude.Message('SmallBallad', gcdisplay.GetToggle('SmallBallad'))
    elseif (args[1] == 'shorde') then
        gcdisplay.AdvanceToggle('SmallHorde')
        gcinclude.Message('SmallHorde', gcdisplay.GetToggle('SmallHorde'))
    elseif (args[1] == 'srecast') then
        gcdisplay.AdvanceToggle('SleepRecast')
        gcinclude.Message('SleepRecast', gcdisplay.GetToggle('SleepRecast'))
    elseif (args[1] == 'songs') then
        currentSongMode = (currentSongMode % #songModes) + 1
        setSongs()
    else
        gcmage.DoCommands(args)
    end

    if (args[1] == 'horizonmode') then
        profile.HandleDefault()
    end
end

profile.HandleDefault = function()
    gcmage.DoDefault(ninSJMaxMP, whmSJMaxMP, blmSJMaxMP, rdmSJMaxMP, nil)

    local player = gData.GetPlayer()
    if (minstrels_earring and player.HPP <= 25) then
        gFunc.Equip(minstrels_earring_slot, 'Minstrel\'s Earring')
    end

    gFunc.EquipSet(gcinclude.BuildLockableSet(gData.GetEquipment()))
end

profile.HandlePrecast = function()
    local action = gData.GetAction()
    if (action.Type == 'Bard Song') then
        local player = gData.GetPlayer()
        local weakened = player.Status:contains('weakened')

        if (player.HP > (player.MaxHP - hpDownTotal)) and not weakened then
            gFunc.ForceEquipSet('Precast_Songs_HPDown')
        end
        gFunc.EquipSet(sets.Precast_Songs)
        local totalFastCast = 1 - (1 - fastCastValueSong) * (1 - fastCastValue)
        gcmage.DoPrecast(totalFastCast)
    else
        gcmage.DoPrecast(fastCastValue)
    end
end

profile.HandleMidcast = function()
    gcmage.DoMidcast(sets, ninSJMaxMP, whmSJMaxMP, blmSJMaxMP, rdmSJMaxMP, nil)

    local action = gData.GetAction()
    if (action.Type == 'Bard Song') then
        gFunc.EquipSet(sets.Sing_Default)

        if string.match(action.Name, 'Threnody') then
            gFunc.EquipSet(sets.Sing_Debuff)
            gFunc.EquipSet(sets.Sing_Threnody)
        elseif string.match(action.Name, 'Elegy') then
            gFunc.EquipSet(sets.Sing_Debuff)
            gFunc.EquipSet(sets.Sing_Elegy)
        elseif string.match(action.Name, 'Foe Lullaby') then
            gFunc.EquipSet(sets.Sing_Debuff)
            gFunc.EquipSet(sets.Sing_Lullaby)
            if (gcdisplay.GetToggle('SleepRecast')) then
                gFunc.EquipSet(sets.Sing_SleepRecast)
            end
        elseif string.match(action.Name, 'Horde Lullaby') then
            gFunc.EquipSet(sets.Sing_Debuff)
            gFunc.EquipSet(sets.Sing_HordeLullaby_Large)
            if (gcdisplay.GetToggle('SmallHorde')) then
                gFunc.EquipSet(sets.Sing_HordeLullaby_Small)
            end
            if (gcdisplay.GetToggle('SleepRecast')) then
                gFunc.EquipSet(sets.Sing_SleepRecast)
            end
        elseif (action.Name == 'Magic Finale') or string.match(action.Name, 'Requiem') then
            gFunc.EquipSet(sets.Sing_Debuff)
            gFunc.EquipSet(sets.Sing_FinaleRequiem)
        elseif string.match(action.Name, 'Carol') then
            gFunc.EquipSet(sets.Sing_Buff)
            gFunc.EquipSet(sets.Sing_Carol)
        elseif string.match(action.Name, 'Ballad') then
            gFunc.EquipSet(sets.Sing_Buff)
            gFunc.EquipSet(sets.Sing_Ballad_Large)
            if (gcdisplay.GetToggle('SmallBallad')) then
                gFunc.EquipSet(sets.Sing_Ballad_Small)
            end
        elseif string.match(action.Name, 'Minuet') then
            gFunc.EquipSet(sets.Sing_Buff)
            gFunc.EquipSet(sets.Sing_Minuet)
        elseif string.match(action.Name, 'March') then
            gFunc.EquipSet(sets.Sing_Buff)
            gFunc.EquipSet(sets.Sing_March)
        elseif string.match(action.Name, 'Madrigal') then
            gFunc.EquipSet(sets.Sing_Buff)
            gFunc.EquipSet(sets.Sing_Madrigal)
        elseif string.match(action.Name, 'Mambo') then
            gFunc.EquipSet(sets.Sing_Buff)
            gFunc.EquipSet(sets.Sing_Mambo)
        elseif string.match(action.Name, 'Prelude') then
            gFunc.EquipSet(sets.Sing_Buff)
            gFunc.EquipSet(sets.Sing_Prelude)
        elseif string.match(action.Name, 'Hymnus') then
            gFunc.EquipSet(sets.Sing_Buff)
            gFunc.EquipSet(sets.Sing_Hymnus)
        elseif (action.Name == 'Chocobo Mazurka') then
            gFunc.EquipSet(sets.Sing_Buff)
            gFunc.EquipSet(sets.Sing_Mazurka)
        elseif string.match(action.Name, 'Paeon') then
            gFunc.EquipSet(sets.Sing_Buff)
            gFunc.EquipSet(sets.Sing_Paeon)
        end
    end
end

return profile
