# Rag's RDM / BLM luashitacast

A combined RDM / BLM luashitacast for HorizonXI that was originally based off of https://github.com/GetAwayCoxn/Luashitacast-Profiles

SMN to come as I level it :P

# How to Use

- Edit Equipment Sets in RDM.lua or BLM.lua. You may delete either of these if you're only looking for a lua one of the jobs.
- Edit Elemental Staves (NQ vs HQ), Obis and some conditional gear in gcmage.lua
- Turn On / Off Additional Commands and Logging in gcincluderag.lua
- The midcast delay assumes you use the PacketFlow plugin. If you don't use PacketFlow, adjust the value in gcmage.lua

- If you define a specific mainhand in regular sets, it will still equip the correct stave if you have them listed in gcmage.lua
- FallbackSub set is used only if you wish to define a Sub to fall back to using due to not having a complete set of Elemental Staves.

## Default Commands:
```
[Regular Toggles]
/lock   - locks or unlocks all equipment.
/kite   - toggles Kite set on/off.
          /kite always takes precedence over any other set overrides active.
          e.g. if you have /kite and /fireres toggled on, 
          it will equip the kite set instead of or on top of the fire resistance set.
          this allows you to gain 12% move speed while keeping up most of your fire resistance.
/oor    - forces use of Master Caster Bracelets / Republican Gold Medal.
          you can toggle this on when you are in areas where these are active.

[Additional Toggles]
/nuke   - toggles Elemental Magic between regular DMG and MACC sets.
/idle   - toggles between using 2 different idle sets (REG and ALT).

[Overrides] (Changes your idle set to use these sets instead)
/dt             - toggles DT set on/off.
/mdt            - toggles MDT set on/off.
/iceres /ires   - toggles Ice Resistance set on/off.
/fireres /fres  - toggles Fire Resistance set on/off.
/earthres /eres - toggles Earth Resistance set on/off.
/windres /wres  - toggles Wind Resistance set on/off.
/lightningres /lres /thunderres /tres - toggles Lightning Resistance set on/off.

[Special Commands]
/warpme - equips a warp cudgel and uses it after 30 seconds and locks equipment. 
          use /lock to unlock again.
```

## Additional Commands for RDM:
```
[Regular Toggles]
/fight  - equips the TP set and locks weapon and sub (or unlocks weapon and sub).
          you can still use /vert and /lock while /fight is toggled on.
/hate   - causes your cures, sleeps, blinds, dispels and binds to equip +enmity set on cast.

[Special Sets]
/vert   - equips the Convert set and locks equipment. 
          use /lock to unlock again.
/csstun - equips the Stun set and locks equipment (For Chainspell Stunning).
          use /lock to unlock again.
```

## Additional Commands for BLM:
```
[Regular Toggles]
/yellow - equips gear to lower HP before finishing casts to trigger Sorcerer's Ring.
          This is on by default.
/mb     - equips gear that gives bonuses to magic burst damage when casting nukes.
```

## Additional Commands (Shorterhand):

If you enable the Shorterhand setting in gcincluderag.lua, additional /commands will work.

- shorterhand.lua is effectively just a pass through to shorthand you can define your own /commands in
- using shorthand syntax like 'me' or partial names will work. e.g. "/i me" will cast invisible on yourself.

```
/c4 - Cure IV
/c3 - Cure III
/c2 - Cure II
/c  - Cure
/i  - Invisible
/s  - Sneak
/ss - Stoneskin
/b  - Blink
/a  - Aquaveil
```

## Additional Notes

LuAshitacast provides functionality to automatically equip Level Sync gear.

This luashitacast intentionally does NOT make use of this functionality to make it easier for first time users to be able to copy paste their own gear sets in place of mine.

I may provide some additional /lock type sets similar to /vert and /csstun to poorly mimic the same utility in the future or you could look to doing this yourself.

e.g. /lockset1 /lockset2 /lockset3
