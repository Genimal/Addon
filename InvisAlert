-- 시시한 투명 물약 사용 알림
InvisAlertDB = InvisAlertDB or {}
local defaults = {
all = false,
alarm = true,
warn = true
}
local temp = {}
local buttons = {}

local alert=CreateFrame("Frame")
alert:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
alert:SetScript("OnEvent",function(_,_,_,combatEvent,_,_,sourceName,sourceFlags,sourceRaidFlags,destGUID,destName,destFlags, destRaidFlags,spellID,spellName,_,param1)
if combatEvent=="SPELL_AURA_APPLIED" and spellID == 216805 then --Detect Potion of Trivial Invisibility (216805)
	if InvisAlertDB.all == true or (InvisAlertDB.all == false and (bit.band(destFlags,COMBATLOG_OBJECT_REACTION_HOSTILE)==COMBATLOG_OBJECT_REACTION_HOSTILE)) then
	for i=1, GetNumGroupMembers() do local name, rank, _, _, _, _ = GetRaidRosterInfo(i)
	if InvisAlertDB.alarm == true then PlaySoundKitID(26080) end -- Sound ID
		if name==UnitName("player") and InvisAlertDB.warn == true then
			SendChatMessage("투명 물약 사용 ▶ "..destName, (IsInRaid() and rank>=1) and "RAID_WARNING" or IsInGroup(2) and "INSTANCE_CHAT" or "YELL")
		elseif InvisAlertDB.warn == false then
			RaidNotice_AddMessage(RaidWarningFrame,"투명 물약!!",ChatTypeInfo["RAID_WARNING"]);print("\124cffff4800투명 물약 사용 ▶ \124r"..destName)
		end
	end
	end
end
end) -- 물약 사용은 source와 dest. 구분이 의미없지만 다른 기술 추가시 꼭 신경써서 확인할 것.

--옵션창 시작
local addOnName = ...

-- main panel
local panel = CreateFrame('Frame', nil, InterfaceOptionsFramePanelContainer)
panel.name = addOnName
panel:RegisterEvent('PLAYER_LOGIN')
panel:SetScript('OnEvent', function()
	InvisAlertDB = InvisAlertDB or defaults

	for key, value in pairs(defaults) do
		if(InvisAlertDB[key] == nil) then
			InvisAlertDB[key] = value
		end
	end
end)

function panel:okay()
	for key, value in pairs(temp) do
		InvisAlertDB[key] = value
	end
end
function panel:cancel()
	table.wipe(temp)
end
function panel:default()
	table.wipe(temp)
end
function panel:refresh()
	for key, button in pairs(buttons) do
		button:SetChecked(InvisAlertDB[key])
	end
end
local CreateCheckButton
	do local function ClickCheckButton(self)
		if(self:GetChecked()) then
			temp[self.key] = true
		else
			temp[self.key] = false
		end
	end

	function CreateCheckButton(parent, key, realParent)
		local CheckButton = CreateFrame('CheckButton', nil, parent, 'InterfaceOptionsCheckButtonTemplate')
		CheckButton:SetHitRectInsets(0, 0, 0, 0)
		CheckButton:SetScript('OnClick', ClickCheckButton)
		CheckButton.realParent = realParent
		CheckButton.key = key

		buttons[key] = CheckButton

		return CheckButton
	end
end

panel:SetScript('OnShow', function(self)
	local Title = self:CreateFontString(nil, nil, 'GameFontNormalLarge')
	Title:SetPoint('TOPLEFT', 16, -16)
	Title:SetText(addOnName)

	local Description = self:CreateFontString(nil, nil, 'GameFontHighlightSmall')
	Description:SetPoint('TOPLEFT', Title, 'BOTTOMLEFT', 0, -8)
	Description:SetJustifyH('LEFT')
	Description:SetText("이 창은 채팅창에 /ia 혹은 /투물 을 입력해도 열립니다.")
	self.Description = Description

	local IAButton1 = CreateCheckButton(self, 'all')
	IAButton1:SetPoint('TOPLEFT', Description, 'BOTTOMLEFT', -2, -10)
	IAButton1.Text:SetText('아군 대상도 포함')

	local IAButton2 = CreateCheckButton(self, 'alarm')
	IAButton2:SetPoint('TOPLEFT', IAButton1, 'BOTTOMLEFT', 0, -8)
	IAButton2.Text:SetText('소리 알람 듣기')

	local IAButton3 = CreateCheckButton(self, 'warn')
	IAButton3:SetPoint('TOPLEFT', IAButton2, 'BOTTOMLEFT', 0, -8)
	IAButton3.Text:SetText('다른 사람에게도 출력')
	panel:refresh()
	self:SetScript('OnShow', nil)
end)

InterfaceOptions_AddCategory(panel)

SlashCmdList["IA"] = function()
	InterfaceOptionsFrame_OpenToCategory(panel)
	InterfaceOptionsFrame_OpenToCategory(panel) -- 이유는 모르겠지만 한번만 입력할 경우 최초 실행시 알맞은 탭이 열리지 않음.
 end

SLASH_IA1, SLASH_IA2 = "/ia", "/투물"
