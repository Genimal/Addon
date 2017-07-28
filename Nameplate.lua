hooksecurefunc("CompactUnitFrame_UpdateName", function(nf)
    if nf:IsForbidden() or not nf:GetName():find("NamePlate%d") then
        return
    end --인스내/공격대 프레임에서 작동 제외.
    if UnitIsFriend("player", nf.unit) then
        if UnitIsPlayer(nf.unit) then
            nf.healthBar:SetStatusBarColor(0,0,1)
        else
            nf.healthBar:SetStatusBarColor(0,1,0)
        end
    end
end) --아군 이름표 색상 예전 파란색으로. NPC 상호작용 가능 여부는 체크 안함.

--CVars--
SetCVar("nameplateShowAll", 1)
SetCVar("nameplateLargeTopInset", -1)
SetCVar("nameplateOtherTopInset", -1)
SetCVar("nameplateLargeBottomInset", -1)
SetCVar("nameplateOtherBottomInset", -1) -- 이름표 거리고정
SetCVar("nameplateMaxDistance", 60)
SetCVar("ShowClassColorInNameplate", 1) --Enemy nameplate
SetCVar("ShowClassColorInFriendlyNameplate", 1) --Friendly nameplate
SetCVar("nameplateShowSelf", 1)
SetCVar("nameplatePersonalShowAlways", 1)
SetCVar("nameplateOccludedAlphaMult", 0.6)
