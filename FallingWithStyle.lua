
local _
local portals

--local FWSMacroName = "FWS"
--local FWSMacroIcon = "INV_Misc_QuestionMark"
--local FWSMacroBody = ""
--local FWSMacroperCharacter = "nil" --nil creates a macro available to all characters
--local FWSMacrolocal = 1 --1 saves macro on the server
	
--[[
1 	Warrior 		WARRIOR
2 	Paladin 		PALADIN
3 	Hunter 			HUNTER
4 	Rogue 			ROGUE
5 	Priest 			PRIEST
6 	Death Knight 	DEATHKNIGHT
7 	Shaman 			SHAMAN
8 	Mage 			MAGE
9 	Warlock 		WARLOCK
10 	Monk 			MONK
11 	Druid 			DRUID
12 	Demon Hunter 	DEMONHUNTER 
--]]

-- Items that slow falling.
local items = {
	[107640] = true --Potion of Slow Fall
	[18951] = true -- Evonice's Landin' Pilla
	[109076] = true -- Goblin Glider Kit
}

-- Spells that slow falling.
local spells = {
	[130] = true, --Slow Fall
	[1706] = true, --Levitate
}

local function FWSGenerateMacro(FWSItem)
print("Enter FWS")
	if InCombatLockdown() then return end
	local name,icon,body,isLocal = GetMacroInfo("FWS")
	if name == nil then
		CreateMacro("FWS", "INV_Misc_QuestionMark", "#showtooltip \n/cast "..FWSItem, nil, 1);
		--local macroId = CreateMacro("MyMacro", "Ability_Creature_Disease_01", "/script CastSpellById(1);", nil, 1);
		--body = "#showtooltip \n/cast "..ic.."\n"
	else
		EditMacro("FWS", "", "", "#showtooltip \n/cast "..FWSItem);
	end
end

local function HasItem()

	for bag=0,4 do
		for slot=1,GetContainerNumSlots(bag) do
			local link = GetContainerItemLink(bag, slot)
			icon, itemCount, locked, quality, readable, lootable, itemLink, isFiltered, noValue, itemID = GetContainerItemInfo(bagID, slot)
				local _, stack = GetContainerItemInfo(bag,slot)
				for set,setitems in pairs(items) do
					local thisbest, val = bests[set], setitems[id]
					if val and (not thisbest.val or (thisbest.val < val or thisbest.val == val and thisbest.stack > stack)) then
						thisbest.id, thisbest.val, thisbest.stack = id, val, stack
					end
				end
			end
		end
	end
	
end

local function HasSpell()
	for key, value in pairs(spells) do
		if(IsPlayerSpell(key)) then
				return select(1, GetSpellInfo(key))
		end
	end
end

local function Init()
	local className, classFilename, classID  = UnitClass("player")
	local FWSGlobalMacros, FWSperCharMacros = GetNumMacros() -- max 36 per account, 18 per character
	if FWSGlobalMacros > 35 then
		print("No available Global Macro slots available.") -- I currently plan on only making it a global macro
		return
	end

	if FWSItem == nil then
		return
	else
		FWSGenerateMacro(FWSItem)
	end
end

local FWSframe = CreateFrame("FRAME", "FWSFrame");   
FWSFrame:RegisterEvent("ADDON_LOADED");
FWSFrame:RegisterEvent("PLAYER_ENTERING_WORLD");
FWSFrame:SetScript("OnEvent", Init);
