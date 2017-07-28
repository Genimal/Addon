--spell alert

local alert=CreateFrame("Frame")
alert:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
alert:SetScript("OnEvent",
 function(_,_,_,combatEvent,_,_,sourceName,sourceFlags,sourceRaidFlags,destGUID,destName,destFlags, destRaidFlags,spellID,spellName,_,param1)

 if sourceName==UnitName("player") and combatEvent=="SPELL_INTERRUPT" then
  print("\124cffff0000차단\124r : "..destName.."의 "..GetSpellLink(param1)) -- 차단

 elseif sourceName==UnitName("player") and combatEvent=="SPELL_DISPEL" and (bit.band(destFlags,COMBATLOG_OBJECT_REACTION_FRIENDLY)==COMBATLOG_OBJECT_REACTION_FRIENDLY) then
  print("\124cff00ff00해제\124r : "..destName.."의 "..GetSpellLink(param1)) -- 해제(아군)

 elseif sourceName==UnitName("player") and combatEvent=="SPELL_DISPEL" and (bit.band(destFlags,COMBATLOG_OBJECT_REACTION_HOSTILE)==COMBATLOG_OBJECT_REACTION_HOSTILE) then 
 print("\124cffff0000해제\124r : "..destName.."의 "..GetSpellLink(param1)) -- 해제(적)

 elseif sourceName==UnitName("player") and combatEvent=="SPELL_STOLEN" then
  print("\124cffff0000훔치기\124r : "..destName.."의 "..GetSpellLink(param1)) -- 훔치기

 elseif destName==UnitName("player") and combatEvent=="SPELL_MISSED" and param1=="REFLECT" then
  print("\124cffff0000반사\124r : "..sourceName.."의 "..GetSpellLink(spellID)) -- 반사
 end
end
)
