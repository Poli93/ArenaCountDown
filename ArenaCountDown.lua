-- /script countdown = 60

local hidden = false
local countdown = -1
local lastShown = nil

local ACDFrame = CreateFrame("Frame", "ACDFrame", UIParent)
function ACDFrame:OnEvent(event, ...)
    if self[event] then
        self[event](self, ...)
    end
end
ACDFrame:SetScript("OnEvent", ACDFrame.OnEvent)
ACDFrame:RegisterEvent("CHAT_MSG_BG_SYSTEM_NEUTRAL")

local ACDNumFrame = CreateFrame("Frame", "ACDNumFrame", UIParent)
ACDNumFrame:SetSize(256, 64)
ACDNumFrame:SetPoint("CENTER", UIParent, "CENTER", 115, 250)
ACDNumFrame:Show()

local ACDText = ACDNumFrame:CreateFontString("ACDText", "OVERLAY")
ACDText:SetPoint("LEFT", ACDNumFrame, "LEFT", 0, 0)

ACDText:SetFont("Fonts\\FRIZQT__.TTF", 21, "OUTLINE")

ACDText:SetShadowColor(0, 0, 0, 1)
ACDText:SetShadowOffset(1, -1)

ACDText:SetJustifyH("LEFT")

ACDFrame:SetScript("OnUpdate", function(self, elapsed)
    if countdown > 0 then
        hidden = false

        local newValue = math.floor(countdown - elapsed)

        if newValue ~= lastShown and newValue >= 0 then
            lastShown = newValue

            if newValue == 0 then
                ACDText:SetText("")
                ACDNumFrame:Hide()
            else
                ACDText:SetText(tostring(newValue))
                ACDNumFrame:Show()
            end
        end

        countdown = countdown - elapsed
    elseif not hidden then
        hidden = true
        lastShown = nil
        ACDText:SetText("")
        ACDNumFrame:Hide()
    end
end)

function ACDFrame:CHAT_MSG_BG_SYSTEM_NEUTRAL(msg)

    if string.find(msg, "One minute until the Arena battle begins!", 1, true) then
        countdown = 61
    elseif string.find(msg, "Thirty seconds until the Arena battle begins!", 1, true) then
        countdown = 31
    elseif string.find(msg, "Fifteen seconds until the Arena battle begins!", 1, true) then
        countdown = 16
    end

    if countdown > 0 then
        lastShown = nil
        ACDNumFrame:Show()
    end
end
