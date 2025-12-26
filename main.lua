local Players = game:GetService("Players")
local player = Players.LocalPlayer
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")

if player.PlayerGui:FindFirstChild("PRIMEHubGUI") then return end

-- KEY SYSTEM SETTINGS
local KeySystemEnabled = true
local KeySettings = {
Title = "PRIME Hub",
Subtitle = "Key System",
Note = "Click 'Get Key' button to obtain the key",
FileName = "PRIMEHub_Key",
SaveKey = true,
GrabKeyFromSite = true,
Key = {"https://pastebin.com/raw/CD4DyVWc"}
}

local function getSavedKey()
if readfile then
local success, result = pcall(function()
return readfile(KeySettings.FileName .. ".txt")
end)
if success and result then
return result
end
end
return nil
end

local function saveKeyToFile(key)
if writefile then
pcall(function()
writefile(KeySettings.FileName .. ".txt", key)
end)
end
end

local function getKeyFromSite(url)
local success, result = pcall(function()
return game:HttpGet(url, true)
end)
if success and result then
return result:gsub("%s+", ""):gsub("\n", ""):gsub("\r", "")
end
return nil
end

local savedKey = getSavedKey()

-- Key GUI
local KeyGui = Instance.new("ScreenGui")
KeyGui.Name = "PRIMEHubKeyGUI"
KeyGui.ResetOnSpawn = false
KeyGui.Parent = player:WaitForChild("PlayerGui")

local KeyFrame = Instance.new("Frame")
KeyFrame.Size = UDim2.new(0, 400, 0, 250)
KeyFrame.Position = UDim2.new(0.5, -200, 0.5, -125)
KeyFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
KeyFrame.BorderSizePixel = 0
KeyFrame.Parent = KeyGui

Instance.new("UICorner", KeyFrame).CornerRadius = UDim.new(0, 12)

local KeyStroke = Instance.new("UIStroke")
KeyStroke.Thickness = 2
KeyStroke.Color = Color3.fromRGB(0, 255, 255)
KeyStroke.Parent = KeyFrame

local KeyGradient = Instance.new("UIGradient")
KeyGradient.Color = ColorSequence.new({
ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 255)),
ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
})
KeyGradient.Rotation = 45
KeyGradient.Parent = KeyFrame

local KeyTitle = Instance.new("TextLabel")
KeyTitle.Size = UDim2.new(1, 0, 0, 50)
KeyTitle.BackgroundTransparency = 1
KeyTitle.Text = KeySettings.Title .. " - " .. KeySettings.Subtitle
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyTitle.TextSize = 20
KeyTitle.Parent = KeyFrame

local KeyNote = Instance.new("TextLabel")
KeyNote.Size = UDim2.new(1, -20, 0, 30)
KeyNote.Position = UDim2.new(0, 10, 0, 50)
KeyNote.BackgroundTransparency = 1
KeyNote.Text = KeySettings.Note
KeyNote.Font = Enum.Font.Gotham
KeyNote.TextColor3 = Color3.fromRGB(200, 200, 200)
KeyNote.TextSize = 12
KeyNote.TextWrapped = true
KeyNote.Parent = KeyFrame

local KeyBox = Instance.new("TextBox")
KeyBox.Size = UDim2.new(0, 350, 0, 40)
KeyBox.Position = UDim2.new(0.5, -175, 0, 90)
KeyBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
KeyBox.BorderSizePixel = 0
KeyBox.PlaceholderText = "Enter Key Here..."
KeyBox.Text = ""
KeyBox.Font = Enum.Font.Gotham
KeyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyBox.TextSize = 16
KeyBox.Parent = KeyFrame

Instance.new("UICorner", KeyBox).CornerRadius = UDim.new(0, 8)

-- Auto-remove spaces when typing
KeyBox:GetPropertyChangedSignal("Text"):Connect(function()
local text = KeyBox.Text
local cleanText = text:gsub(" ", "")
if text ~= cleanText then
KeyBox.Text = cleanText
end
end)

local GetKeyBtn = Instance.new("TextButton")
GetKeyBtn.Size = UDim2.new(0, 350, 0, 40)
GetKeyBtn.Position = UDim2.new(0.5, -175, 0, 145)
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 200)
GetKeyBtn.Text = "Get Key"
GetKeyBtn.Font = Enum.Font.GothamBold
GetKeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
GetKeyBtn.TextSize = 18
GetKeyBtn.BorderSizePixel = 0
GetKeyBtn.Parent = KeyFrame

Instance.new("UICorner", GetKeyBtn).CornerRadius = UDim.new(0, 8)

local SubmitKeyBtn = Instance.new("TextButton")
SubmitKeyBtn.Size = UDim2.new(0, 350, 0, 40)
SubmitKeyBtn.Position = UDim2.new(0.5, -175, 0, 200)
SubmitKeyBtn.BackgroundColor3 = Color3.fromRGB(50, 220, 50)
SubmitKeyBtn.Text = "Submit Key"
SubmitKeyBtn.Font = Enum.Font.GothamBold
SubmitKeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitKeyBtn.TextSize = 18
SubmitKeyBtn.BorderSizePixel = 0
SubmitKeyBtn.Parent = KeyFrame

Instance.new("UICorner", SubmitKeyBtn).CornerRadius = UDim.new(0, 8)

GetKeyBtn.MouseButton1Click:Connect(function()
setclipboard("https://direct-link.net/1462308/RRaO8s6Woee8")
game.StarterGui:SetCore("SendNotification", {
Title = "PRIME Hub",
Text = "Key link copied to clipboard!",
Duration = 5
})
end)

local function verifyKey(inputKey)
local cleanInput = inputKey:gsub("%s+", ""):gsub("\n", ""):gsub("\r", "")

for _, keyValue in pairs(KeySettings.Key) do
if KeySettings.GrabKeyFromSite then
local siteKey = getKeyFromSite(keyValue)
if siteKey and cleanInput == siteKey then
return true
end
else
local cleanKey = keyValue:gsub("%s+", ""):gsub("\n", ""):gsub("\r", "")
if cleanInput == cleanKey then
return true
end
end
end

return false
end

local keyVerified = false

if KeySettings.SaveKey and savedKey and verifyKey(savedKey) then
keyVerified = true
KeyGui:Destroy()
else
SubmitKeyBtn.MouseButton1Click:Connect(function()
SubmitKeyBtn.Text = "Checking..."
SubmitKeyBtn.BackgroundColor3 = Color3.fromRGB(200, 150, 0)

wait(0.3)

local inputKey = KeyBox.Text
if verifyKey(inputKey) then
keyVerified = true
if KeySettings.SaveKey then
saveKeyToFile(inputKey:gsub("%s+", ""))
end
game.StarterGui:SetCore("SendNotification", {
Title = "PRIME Hub",
Text = "Key Verified! Loading...",
Duration = 3
})
wait(0.3)
KeyGui:Destroy()
else
SubmitKeyBtn.Text = "Submit Key"
SubmitKeyBtn.BackgroundColor3 = Color3.fromRGB(50, 220, 50)
game.StarterGui:SetCore("SendNotification", {
Title = "PRIME Hub",
Text = "Invalid Key! Check Pastebin link",
Duration = 3
})
end
end)

repeat wait() until keyVerified
end

-- GAME LOGIC
local LocalPlayer = player
local Remotes = game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 10)

if not Remotes then
warn("Remotes not found!")
end

local TapButtonClick = Remotes and Remotes:FindFirstChild("TapButtonClick")
local TreeClick = Remotes and Remotes:FindFirstChild("TreeClick")
local AxeSwing = Remotes and Remotes:FindFirstChild("AxeSwing")
local CollectCoin = Remotes and Remotes:FindFirstChild("CollectCoin")
local Prestige = Remotes and Remotes:FindFirstChild("Prestige")
local ClickWateringCan = Remotes and Remotes:FindFirstChild("ClickWateringCan")
local ClaimWaterPurifier = Remotes and Remotes:FindFirstChild("ClaimWaterPurifier")
local WaterPurifier = Remotes and Remotes:FindFirstChild("WaterPurifier")

local TIMING = {
TAP_SPEED = 0.01,
MUTATION_HIT_DELAY = 0.02,
MUTATION_LOOP_DELAY = 0.05,
COIN_COLLECT_DELAY = 0.03,
COIN_LOOP_DELAY = 0.2,
PRESTIGE_INTERVAL = 5,
USE_CANS_KEY_DELAY = 0.3,
USE_CANS_CLICK_DELAY = 0.4,
USE_CANS_INTERVAL = 5,
PICKUP_CANS_DELAY = 0.3,
PICKUP_CANS_INTERVAL = 8,
CLAIM_PURIFIER_INTERVAL = 10,
FILL_PURIFIER_INTERVAL = 5,
FILL_PURIFIER_DELAY = 2,
STATS_UPDATE_INTERVAL = 1,
KEY_PRESS_DURATION = 0.05,
CLICK_DURATION = 0.05,
STEAL_DELAY = 0.5,
STEAL_LOOP_INTERVAL = 3,
}

local Config = {
AutoTap = false,
TapThreads = 5,
AutoMutations = false,
AutoCollectCoins = false,
AutoPrestige = false,
SpeedHack = false,
SpeedAmount = 100,
AutoUseCans = false,
AutoPickupCans = false,
AutoClaimPurifier = false,
AutoFillPurifier = false,
AutoSteal = false,
WaterLevelThreshold = 3,
}

local State = {
Running = true,
Tapping = false,
HittingTrees = false,
CollectingCoins = false,
UsingCans = false,
PickingUpCans = false,
Prestiging = false,
ClaimingPurifier = false,
FillingPurifier = false,
Stealing = false,
}

local Threads = {}
local Connections = {}

local function SafeCancel(name)
if Threads[name] then
    pcall(function() task.cancel(Threads[name]) end)
    Threads[name] = nil
end
end

local function SafeDisconnect(name)
if Connections[name] then
    pcall(function() Connections[name]:Disconnect() end)
    Connections[name] = nil
end
end

local function GetPlayerPlot()
local plotVal = LocalPlayer:FindFirstChild("Plot")
if plotVal and plotVal:IsA("ObjectValue") and plotVal.Value then
    return plotVal.Value
end
local plots = workspace:FindFirstChild("Plots")
if plots then
    for _, plot in ipairs(plots:GetChildren()) do
        if plot:GetAttribute("Plr") == LocalPlayer.Name then
            return plot
        end
    end
end
return nil
end

local function GetMutations()
local mutations = {}
local seen = {}
local plot = GetPlayerPlot()
if plot then
    for _, child in ipairs(plot:GetChildren()) do
        if child.Name == "TreeValue" and child:IsA("ObjectValue") then
            local tree = child.Value
            if tree and tree.Parent and not seen[tree] then
                seen[tree] = true
                table.insert(mutations, tree)
            end
        end
    end
end
return mutations
end

local function GetWateringCans()
local cans = {}
local seen = {}
local plot = GetPlayerPlot()
if plot then
    for _, desc in ipairs(plot:GetDescendants()) do
        if desc.Name == "WateringCanValue" and desc:IsA("ObjectValue") then
            local can = desc.Value
            if can and can.Parent and not seen[can] then
                seen[can] = true
                table.insert(cans, can)
            end
        end
    end
end
return cans
end

local function GetStealableCans()
local stealable = {}
local myPlot = GetPlayerPlot()
local plots = workspace:FindFirstChild("Plots")
if not plots then return stealable end
for _, plot in ipairs(plots:GetChildren()) do
    if plot ~= myPlot then
        for _, desc in ipairs(plot:GetDescendants()) do
            if desc.Name == "WateringCanValue" and desc:IsA("ObjectValue") then
                local can = desc.Value
                if can and can.Parent then
                    local canSteal = can:GetAttribute("CanSteal") or can:GetAttribute("Stealable")
                    if canSteal == nil or canSteal == true then
                        table.insert(stealable, can)
                    end
                end
            end
            if desc:IsA("Model") or desc:IsA("BasePart") then
                local name = desc.Name:lower()
                if name:find("water") and name:find("can") then
                    local canSteal = desc:GetAttribute("CanSteal") or desc:GetAttribute("Stealable")
                    if canSteal == nil or canSteal == true then
                        table.insert(stealable, desc)
                    end
                end
            end
        end
    end
end
return stealable
end

local function StealCan(can)
if not can or not can.Parent then return end
if ClickWateringCan then
    pcall(function() ClickWateringCan:FireServer(can) end)
end
end

local function StealAllCans()
local cans = GetStealableCans()
for _, can in ipairs(cans) do
    if not Config.AutoSteal or not State.Running then break end
    StealCan(can)
    task.wait(TIMING.STEAL_DELAY)
end
return #cans
end

local function GetMainTree()
local plot = GetPlayerPlot()
if plot then
    local contents = plot:FindFirstChild("PlotContents")
    if contents then
        return contents:FindFirstChild("Tree")
    end
end
return nil
end

local function GetWateringCanLevels()
local levels = {}
local data = LocalPlayer:FindFirstChild("Data")
if data then
    local tapCans = data:FindFirstChild("TapWateringCans")
    if tapCans then
        for _, slot in ipairs(tapCans:GetChildren()) do
            local levelVal = slot:FindFirstChild("Level")
            if levelVal then
                levels[slot.Name] = levelVal.Value
            end
        end
    end
end
return levels
end

local function GetHighestWaterLevel()
local highest = 0
for _, level in pairs(GetWateringCanLevels()) do
    if level > highest then
        highest = level
    end
end
return highest
end

local function ShouldAutoWater()
return GetHighestWaterLevel() >= Config.WaterLevelThreshold
end

local function GetLowestLevelCanSlot()
local lowestSlot, lowestLevel = nil, 999
local data = LocalPlayer:FindFirstChild("Data")
if data then
    local tapCans = data:FindFirstChild("TapWateringCans")
    if tapCans then
        for _, slot in ipairs(tapCans:GetChildren()) do
            local levelVal = slot:FindFirstChild("Level")
            if levelVal and levelVal.Value < lowestLevel then
                lowestLevel = levelVal.Value
                lowestSlot = tonumber(slot.Name)
            end
        end
    end
end
return lowestSlot, lowestLevel
end

local function IsPurifierEmpty()
local plot = GetPlayerPlot()
if plot then
    local contents = plot:FindFirstChild("PlotContents")
    if contents then
        local purifier = contents:FindFirstChild("Water Purifier")
        if purifier then
            return not (purifier:FindFirstChild("WateringCan") or purifier:FindFirstChild("Can"))
        end
    end
end
return true
end

local function HasWateringCans()
local backpack = LocalPlayer:FindFirstChild("Backpack")
local char = LocalPlayer.Character
if backpack then
    for _, item in ipairs(backpack:GetChildren()) do
        local name = item.Name:lower()
        if name:find("water") or name:find("can") then
            return true
        end
    end
end
if char then
    for _, item in ipairs(char:GetChildren()) do
        if item:IsA("Tool") then
            local name = item.Name:lower()
            if name:find("water") or name:find("can") then
                return true
            end
        end
    end
end
return false
end

local function PressKey(keyCode)
pcall(function()
    game:GetService("VirtualInputManager"):SendKeyEvent(true, keyCode, false, game)
    task.wait(TIMING.KEY_PRESS_DURATION)
    game:GetService("VirtualInputManager"):SendKeyEvent(false, keyCode, false, game)
end)
end

local function ClickMouse()
pcall(function()
    game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, true, game, 1)
    task.wait(TIMING.CLICK_DURATION)
    game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, false, game, 1)
end)
end

local HotbarKeys = {
Enum.KeyCode.Two, Enum.KeyCode.Three, Enum.KeyCode.Four,
Enum.KeyCode.Five, Enum.KeyCode.Six, Enum.KeyCode.Seven,
Enum.KeyCode.Eight, Enum.KeyCode.Nine,
}

local function TapTree()
if not TapButtonClick then return end
local plot = GetPlayerPlot()
if plot then
    pcall(function() TapButtonClick:FireServer(plot) end)
end
end

local function HitMutation(mutation)
if not mutation or not mutation.Parent then return end
if TreeClick then
    pcall(function() TreeClick:InvokeServer(mutation) end)
end
if AxeSwing then
    pcall(function() AxeSwing:FireServer() end)
end
end

local function HitAllMutations()
local mutations = GetMutations()
for _, mutation in ipairs(mutations) do
    if not Config.AutoMutations or not State.Running then break end
    HitMutation(mutation)
    task.wait(TIMING.MUTATION_HIT_DELAY)
end
end

local function CollectAllCoins()
    local char = LocalPlayer.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not root then return end

    local orbsFolder = workspace:FindFirstChild("Orbs")

    if orbsFolder then
        for _, coin in ipairs(orbsFolder:GetChildren()) do
            if not Config.AutoCollectCoins or not State.Running then break end

            if coin and coin.Parent and coin:IsA("BasePart") then
                local canCollect = coin:GetAttribute("CanCollect")

                -- Check if coin is collectable (nil or true means yes)
                if canCollect == nil or canCollect == true then
                    -- Teleport coin to player's position
                    pcall(function()
                        coin.CFrame = root.CFrame
                    end)

                    task.wait(TIMING.COIN_COLLECT_DELAY)
                end
            end
        end
    end
end

local function UseCans()
if State.UsingCans then return end
State.UsingCans = true
if not HasWateringCans() then
    PressKey(Enum.KeyCode.One)
    State.UsingCans = false
    return
end
for _, keyCode in ipairs(HotbarKeys) do
    if not Config.AutoUseCans or not State.Running then break end
    PressKey(keyCode)
    task.wait(TIMING.USE_CANS_KEY_DELAY)
    ClickMouse()
    task.wait(TIMING.USE_CANS_CLICK_DELAY)
end
PressKey(Enum.KeyCode.One)
State.UsingCans = false
end

local function PickupCans()
if State.PickingUpCans then return end
State.PickingUpCans = true
local cans = GetWateringCans()
if #cans == 0 then
    PressKey(Enum.KeyCode.One)
    State.PickingUpCans = false
    return
end
for _, can in ipairs(cans) do
    if not Config.AutoPickupCans or not State.Running then break end
    if ClickWateringCan then
        pcall(function() ClickWateringCan:FireServer(can) end)
    end
    task.wait(TIMING.PICKUP_CANS_DELAY)
end
local tree = GetMainTree()
if tree and ClickWateringCan then
    pcall(function() ClickWateringCan:FireServer(tree) end)
end
local plot = GetPlayerPlot()
if plot and ClickWateringCan then
    pcall(function() ClickWateringCan:FireServer(plot) end)
end
PressKey(Enum.KeyCode.One)
State.PickingUpCans = false
end

local function ClaimPurifier()
if ClaimWaterPurifier then
    pcall(function() ClaimWaterPurifier:InvokeServer() end)
end
end

local function FillPurifier()
local slot, level = GetLowestLevelCanSlot()
if slot and level < 100 and WaterPurifier then
    pcall(function() WaterPurifier:InvokeServer(slot) end)
end
end

local function DoPrestige()
if Prestige then
    pcall(function() Prestige:InvokeServer() end)
end
end

local function SetSpeed(speed)
local char = LocalPlayer.Character
if char then
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if humanoid then
        pcall(function() humanoid.WalkSpeed = speed end)
    end
end
end

local function StartAutoTap()
if State.Tapping then return end
State.Tapping = true
for i = 1, Config.TapThreads do
    Threads["Tap_" .. i] = task.spawn(function()
        while Config.AutoTap and State.Running do
            TapTree()
            task.wait(TIMING.TAP_SPEED)
        end
    end)
end
Threads["TapMonitor"] = task.spawn(function()
    while Config.AutoTap and State.Running do
        task.wait(0.1)
    end
    State.Tapping = false
end)
end

local function StopAutoTap()
Config.AutoTap = false
for i = 1, Config.TapThreads do
    SafeCancel("Tap_" .. i)
end
SafeCancel("TapMonitor")
State.Tapping = false
end

local function StartAutoMutations()
if State.HittingTrees then return end
State.HittingTrees = true
Threads["Mutations"] = task.spawn(function()
    while Config.AutoMutations and State.Running do
        HitAllMutations()
        task.wait(TIMING.MUTATION_LOOP_DELAY)
    end
    State.HittingTrees = false
end)
end

local function StopAutoMutations()
Config.AutoMutations = false
SafeCancel("Mutations")
State.HittingTrees = false
end

local function StartAutoCollect()
if State.CollectingCoins then return end
State.CollectingCoins = true
Threads["Collect"] = task.spawn(function()
    while Config.AutoCollectCoins and State.Running do
        CollectAllCoins()
        task.wait(TIMING.COIN_LOOP_DELAY)
    end
    State.CollectingCoins = false
end)
end

local function StopAutoCollect()
Config.AutoCollectCoins = false
SafeCancel("Collect")
State.CollectingCoins = false
end

local function StartAutoPrestige()
if State.Prestiging then return end
State.Prestiging = true
Threads["Prestige"] = task.spawn(function()
    while Config.AutoPrestige and State.Running do
        DoPrestige()
        task.wait(TIMING.PRESTIGE_INTERVAL)
    end
    State.Prestiging = false
end)
end

local function StopAutoPrestige()
Config.AutoPrestige = false
SafeCancel("Prestige")
State.Prestiging = false
end

local function StartAutoUseCans()
Threads["UseCans"] = task.spawn(function()
    while Config.AutoUseCans and State.Running do
        if ShouldAutoWater() then
            task.spawn(UseCans)
        end
        task.wait(TIMING.USE_CANS_INTERVAL)
    end
end)
end

local function StopAutoUseCans()
Config.AutoUseCans = false
SafeCancel("UseCans")
end

local function StartAutoPickupCans()
Threads["PickupCans"] = task.spawn(function()
    while Config.AutoPickupCans and State.Running do
        if ShouldAutoWater() then
            task.spawn(PickupCans)
        end
        task.wait(TIMING.PICKUP_CANS_INTERVAL)
    end
end)
end

local function StopAutoPickupCans()
Config.AutoPickupCans = false
SafeCancel("PickupCans")
end

local function StartAutoClaimPurifier()
Threads["ClaimPurifier"] = task.spawn(function()
    while Config.AutoClaimPurifier and State.Running do
        ClaimPurifier()
        task.wait(TIMING.CLAIM_PURIFIER_INTERVAL)
    end
end)
end

local function StopAutoClaimPurifier()
Config.AutoClaimPurifier = false
SafeCancel("ClaimPurifier")
end

local function StartAutoFillPurifier()
Threads["FillPurifier"] = task.spawn(function()
    while Config.AutoFillPurifier and State.Running do
        if IsPurifierEmpty() then
            FillPurifier()
            task.wait(TIMING.FILL_PURIFIER_DELAY)
        end
        task.wait(TIMING.FILL_PURIFIER_INTERVAL)
    end
end)
end

local function StopAutoFillPurifier()
Config.AutoFillPurifier = false
SafeCancel("FillPurifier")
end

local function StartAutoSteal()
if State.Stealing then return end
State.Stealing = true
Threads["Steal"] = task.spawn(function()
    while Config.AutoSteal and State.Running do
        local stolen = StealAllCans()
        task.wait(TIMING.STEAL_LOOP_INTERVAL)
    end
    State.Stealing = false
end)
end

local function StopAutoSteal()
Config.AutoSteal = false
SafeCancel("Steal")
State.Stealing = false
end

local function StartSpeedHack()
SafeDisconnect("SpeedHack")
Connections.SpeedHack = game:GetService("RunService").Heartbeat:Connect(function()
    if Config.SpeedHack and State.Running then
        SetSpeed(Config.SpeedAmount)
    end
end)
end

local function StopSpeedHack()
Config.SpeedHack = false
SafeDisconnect("SpeedHack")
SetSpeed(16)
end

-- Helper to create sliders
local function createGameSlider(text, configKey, min, max, parent)
local SliderFrame = Instance.new("Frame")
SliderFrame.Size = UDim2.new(1, -20, 0, 50)
SliderFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
SliderFrame.BackgroundTransparency = 0.5
SliderFrame.Parent = parent
Instance.new("UICorner", SliderFrame).CornerRadius = UDim.new(0, 6)

local Label = Instance.new("TextLabel")
Label.Size = UDim2.new(1, -20, 0, 20)
Label.Position = UDim2.new(0, 10, 0, 5)
Label.BackgroundTransparency = 1
Label.Text = text .. ": " .. tostring(Config[configKey])
Label.Font = Enum.Font.GothamBold
Label.TextColor3 = Color3.fromRGB(255, 255, 255)
Label.TextSize = 14
Label.TextXAlignment = Enum.TextXAlignment.Left
Label.Parent = SliderFrame

local SliderBg = Instance.new("Frame")
SliderBg.Size = UDim2.new(1, -20, 0, 6)
SliderBg.Position = UDim2.new(0, 10, 0, 35)
SliderBg.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
SliderBg.BorderSizePixel = 0
SliderBg.Parent = SliderFrame
Instance.new("UICorner", SliderBg).CornerRadius = UDim.new(0, 3)

local SliderFill = Instance.new("Frame")
SliderFill.Size = UDim2.new((Config[configKey] - min) / (max - min), 0, 1, 0)
SliderFill.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
SliderFill.BorderSizePixel = 0
SliderFill.Parent = SliderBg
Instance.new("UICorner", SliderFill).CornerRadius = UDim.new(0, 3)

local Trigger = Instance.new("TextButton")
Trigger.Size = UDim2.new(1, 0, 1, 0)
Trigger.BackgroundTransparency = 1
Trigger.Text = ""
Trigger.Parent = SliderBg

local dragging = false

Trigger.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local pos = math.clamp((input.Position.X - SliderBg.AbsolutePosition.X) / SliderBg.AbsoluteSize.X, 0, 1)
        local value = math.floor(min + ((max - min) * pos))
        Config[configKey] = value
        SliderFill.Size = UDim2.new(pos, 0, 1, 0)
        Label.Text = text .. ": " .. tostring(value)

        -- Update speed immediately if speed hack is on
        if configKey == "SpeedAmount" and Config.SpeedHack then
            SetSpeed(value)
        end
    end
end)

game:GetService("UserInputService").InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

return SliderFrame
end

-- Helper to create toggles
local function createGameToggle(text, configKey, startFunc, stopFunc, parent)
local ToggleFrame = Instance.new("Frame")
ToggleFrame.Size = UDim2.new(1, -20, 0, 40)
ToggleFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ToggleFrame.BackgroundTransparency = 0.5
ToggleFrame.Parent = parent
Instance.new("UICorner", ToggleFrame).CornerRadius = UDim.new(0, 6)

local Label = Instance.new("TextLabel")
Label.Size = UDim2.new(0.7, 0, 1, 0)
Label.Position = UDim2.new(0, 10, 0, 0)
Label.BackgroundTransparency = 1
Label.Text = text
Label.Font = Enum.Font.GothamBold
Label.TextColor3 = Color3.fromRGB(255, 255, 255)
Label.TextSize = 14
Label.TextXAlignment = Enum.TextXAlignment.Left
Label.Parent = ToggleFrame

local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 50, 0, 24)
ToggleBtn.Position = UDim2.new(1, -60, 0.5, -12)
ToggleBtn.BackgroundColor3 = Config[configKey] and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(50, 50, 50)
ToggleBtn.Text = Config[configKey] and "ON" or "OFF"
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.TextSize = 12
ToggleBtn.Parent = ToggleFrame
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, 12)

ToggleBtn.MouseButton1Click:Connect(function()
    Config[configKey] = not Config[configKey]
    ToggleBtn.Text = Config[configKey] and "ON" or "OFF"
    ToggleBtn.BackgroundColor3 = Config[configKey] and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(50, 50, 50)

    if Config[configKey] then
        if startFunc then startFunc() end
    else
        if stopFunc then stopFunc() end
    end
end)
return ToggleFrame
end

-- Main Script
game.StarterGui:SetCore("SendNotification", {
Title = "PRIME Hub",
Text = "Loaded | By WENDIGO",
Duration = 7
})

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PRIMEHubGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = player:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 500, 0, 350)
MainFrame.Position = UDim2.new(0.05, 0, 0.2, 0)
MainFrame.BackgroundTransparency = 0.1
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = true
MainFrame.Parent = ScreenGui

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

local MainStroke = Instance.new("UIStroke")
MainStroke.Thickness = 3
MainStroke.Color = Color3.fromRGB(0, 255, 255)
MainStroke.Transparency = 0.3
MainStroke.Parent = MainFrame

local MainStrokeGradient = Instance.new("UIGradient")
MainStrokeGradient.Color = ColorSequence.new({
ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 255)),
ColorSequenceKeypoint.new(0.5, Color3.fromRGB(100, 200, 255)),
ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 100, 255))
})
MainStrokeGradient.Rotation = 45
MainStrokeGradient.Parent = MainStroke

local Gradient = Instance.new("UIGradient")
Gradient.Color = ColorSequence.new({
ColorSequenceKeypoint.new(0, Color3.fromRGB(15, 15, 25)),
ColorSequenceKeypoint.new(0.5, Color3.fromRGB(10, 10, 15)),
ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 30))
})
Gradient.Rotation = 90
Gradient.Parent = MainFrame

local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.Position = UDim2.new(0, 0, 0, 0)
TopBar.BackgroundColor3 = Color3.fromRGB(0, 200, 200)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 12)

local TopGradient = Instance.new("UIGradient")
TopGradient.Color = ColorSequence.new({
ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 220, 220)),
ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 180, 255)),
ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 150, 255))
})
TopGradient.Rotation = 45
TopGradient.Parent = TopBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 200, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "PRIME Hub"
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.new(0, 30, 0, 30)
MinimizeBtn.Position = UDim2.new(1, -70, 0.5, -15)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
MinimizeBtn.Text = "-"
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeBtn.TextSize = 20
MinimizeBtn.BorderSizePixel = 0
MinimizeBtn.Parent = TopBar

Instance.new("UICorner", MinimizeBtn).CornerRadius = UDim.new(0, 6)

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0.5, -15)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
CloseBtn.Text = "X"
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 18
CloseBtn.BorderSizePixel = 0
CloseBtn.Parent = TopBar

Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)

local draggingMain = false
local dragInputMain
local dragStartMain
local startPosMain

local function updateMain(input)
local delta = input.Position - dragStartMain
MainFrame.Position = UDim2.new(startPosMain.X.Scale, startPosMain.X.Offset + delta.X, startPosMain.Y.Scale, startPosMain.Y.Offset + delta.Y)
end

TopBar.InputBegan:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
draggingMain = true
dragStartMain = input.Position
startPosMain = MainFrame.Position

input.Changed:Connect(function()
if input.UserInputState == Enum.UserInputState.End then
draggingMain = false
end
end)
end
end)

TopBar.InputChanged:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
dragInputMain = input
end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
if input == dragInputMain and draggingMain then
updateMain(input)
end
end)

local LeftSection = Instance.new("ScrollingFrame")
LeftSection.Size = UDim2.new(0, 150, 1, -50)
LeftSection.Position = UDim2.new(0, 5, 0, 45)
LeftSection.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
LeftSection.BackgroundTransparency = 0.2
LeftSection.BorderSizePixel = 0
LeftSection.ScrollBarThickness = 6
LeftSection.CanvasSize = UDim2.new(0, 0, 0, 0)
LeftSection.Parent = MainFrame

Instance.new("UICorner", LeftSection).CornerRadius = UDim.new(0, 8)

local LeftSectionGradient = Instance.new("UIGradient")
LeftSectionGradient.Color = ColorSequence.new({
ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 25, 35)),
ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 25))
})
LeftSectionGradient.Rotation = 90
LeftSectionGradient.Parent = LeftSection

local LeftListLayout = Instance.new("UIListLayout")
LeftListLayout.Padding = UDim.new(0, 5)
LeftListLayout.Parent = LeftSection

local RightSection = Instance.new("Frame")
RightSection.Size = UDim2.new(0, 330, 1, -50)
RightSection.Position = UDim2.new(0, 160, 0, 45)
RightSection.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
RightSection.BackgroundTransparency = 0.2
RightSection.BorderSizePixel = 0
RightSection.Visible = false
RightSection.Parent = MainFrame

Instance.new("UICorner", RightSection).CornerRadius = UDim.new(0, 8)

local RightGradient = Instance.new("UIGradient")
RightGradient.Color = ColorSequence.new({
ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 30, 40)),
ColorSequenceKeypoint.new(0.5, Color3.fromRGB(15, 20, 30)),
ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 35, 45))
})
RightGradient.Rotation = 135
RightGradient.Parent = RightSection

local ContentFrame = Instance.new("ScrollingFrame")
ContentFrame.Size = UDim2.new(1, -10, 1, -10)
ContentFrame.Position = UDim2.new(0, 5, 0, 5)
ContentFrame.BackgroundTransparency = 1
ContentFrame.BorderSizePixel = 0
ContentFrame.ScrollBarThickness = 6
ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ContentFrame.Parent = RightSection

local ContentListLayout = Instance.new("UIListLayout")
ContentListLayout.Padding = UDim.new(0, 10)
ContentListLayout.Parent = ContentFrame

local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0, 60, 0, 60)
ToggleButton.Position = UDim2.new(0, 10, 0.5, -30)
ToggleButton.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
ToggleButton.Text = "P"
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 28
ToggleButton.BorderSizePixel = 0
ToggleButton.Parent = ScreenGui

Instance.new("UICorner", ToggleButton).CornerRadius = UDim.new(0, 30)

local ToggleBtnGradient = Instance.new("UIGradient")
ToggleBtnGradient.Color = ColorSequence.new({
ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 200, 255)),
ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 100, 255))
})
ToggleBtnGradient.Rotation = 45
ToggleBtnGradient.Parent = ToggleButton

local dragging = false
local dragInput
local dragStart
local startPos

local function update(input)
local delta = input.Position - dragStart
ToggleButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

ToggleButton.InputBegan:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
dragging = true
dragStart = input.Position
startPos = ToggleButton.Position

input.Changed:Connect(function()
if input.UserInputState == Enum.UserInputState.End then
dragging = false
end
end)
end
end)

ToggleButton.InputChanged:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
dragInput = input
end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
if input == dragInput and dragging then
update(input)
end
end)

ToggleButton.MouseButton1Click:Connect(function()
MainFrame.Visible = not MainFrame.Visible
end)

local isMinimized = false
local originalSize = MainFrame.Size

MinimizeBtn.MouseButton1Click:Connect(function()
isMinimized = not isMinimized
if isMinimized then
MainFrame:TweenSize(UDim2.new(0, 500, 0, 40), "Out", "Quad", 0.3, true)
wait(0.3)
LeftSection.Visible = false
RightSection.Visible = false
else
MainFrame:TweenSize(originalSize, "Out", "Quad", 0.3, true)
wait(0.3)
LeftSection.Visible = true
end
end)

CloseBtn.MouseButton1Click:Connect(function()
ScreenGui:Destroy()
end)

local currentSection = nil
-- THEME SYSTEM
local ThemeColors = {
Default = {
Primary = Color3.fromRGB(0, 220, 220),
Secondary = Color3.fromRGB(100, 200, 255),
Accent = Color3.fromRGB(255, 100, 255),
Background = Color3.fromRGB(15, 15, 25),
ButtonGradientStart = Color3.fromRGB(0, 200, 200),
ButtonGradientEnd = Color3.fromRGB(0, 150, 200),
TextColor = Color3.fromRGB(255, 255, 255),
Highlight = Color3.fromRGB(0, 255, 255)
},
["Dark Green"] = {
Primary = Color3.fromRGB(0, 220, 120),
Secondary = Color3.fromRGB(50, 200, 150),
Accent = Color3.fromRGB(100, 255, 150),
Background = Color3.fromRGB(10, 25, 15),
ButtonGradientStart = Color3.fromRGB(0, 200, 100),
ButtonGradientEnd = Color3.fromRGB(0, 150, 80),
TextColor = Color3.fromRGB(200, 255, 200),
Highlight = Color3.fromRGB(0, 255, 150)
},
["Dark Blue"] = {
Primary = Color3.fromRGB(50, 100, 255),
Secondary = Color3.fromRGB(100, 150, 255),
Accent = Color3.fromRGB(150, 200, 255),
Background = Color3.fromRGB(10, 15, 30),
ButtonGradientStart = Color3.fromRGB(40, 80, 220),
ButtonGradientEnd = Color3.fromRGB(80, 120, 255),
TextColor = Color3.fromRGB(200, 220, 255),
Highlight = Color3.fromRGB(100, 180, 255)
},
["Purple Rose"] = {
Primary = Color3.fromRGB(200, 50, 200),
Secondary = Color3.fromRGB(255, 100, 255),
Accent = Color3.fromRGB(255, 150, 255),
Background = Color3.fromRGB(25, 10, 25),
ButtonGradientStart = Color3.fromRGB(180, 40, 180),
ButtonGradientEnd = Color3.fromRGB(220, 80, 220),
TextColor = Color3.fromRGB(255, 200, 255),
Highlight = Color3.fromRGB(255, 100, 255)
},
Skeet = {
Primary = Color3.fromRGB(150, 220, 50),
Secondary = Color3.fromRGB(200, 255, 100),
Accent = Color3.fromRGB(255, 255, 150),
Background = Color3.fromRGB(15, 20, 10),
ButtonGradientStart = Color3.fromRGB(130, 200, 40),
ButtonGradientEnd = Color3.fromRGB(170, 240, 80),
TextColor = Color3.fromRGB(220, 255, 180),
Highlight = Color3.fromRGB(180, 255, 80)
},
["Modern Mono"] = {
Primary = Color3.fromRGB(25, 25, 25),           -- Deep black for main UI
Secondary = Color3.fromRGB(35, 35, 35),         -- Slightly lighter black
Accent = Color3.fromRGB(255, 255, 255),         -- Pure white for clickable items
Background = Color3.fromRGB(15, 15, 15),        -- Darkest background
ButtonGradientStart = Color3.fromRGB(240, 240, 240),  -- White gradient for buttons
ButtonGradientEnd = Color3.fromRGB(255, 255, 255),
TextColor = Color3.fromRGB(255, 255, 255),      -- White text
Highlight = Color3.fromRGB(200, 200, 200),      -- Light grey for hover
SubText = Color3.fromRGB(140, 140, 140),        -- Grey for non-important text
Border = Color3.fromRGB(60, 60, 60),            -- Dark grey borders
Disabled = Color3.fromRGB(80, 80, 80)           -- For non-interactive elements
}
}


local currentTheme = "Default"
local ButtonGradients = {}
local ButtonTexts = {}
local SectionTitles = {}

local function applyTheme(themeName)
local theme = ThemeColors[themeName]
if not theme then return end

currentTheme = themeName

Gradient.Color = ColorSequence.new({
ColorSequenceKeypoint.new(0, theme.Background),
ColorSequenceKeypoint.new(0.5, Color3.fromRGB(theme.Background.R * 0.8, theme.Background.G * 0.8, theme.Background.B * 0.8)),
ColorSequenceKeypoint.new(1, theme.Background)
})

MainStrokeGradient.Color = ColorSequence.new({
ColorSequenceKeypoint.new(0, theme.Primary),
ColorSequenceKeypoint.new(0.5, theme.Secondary),
ColorSequenceKeypoint.new(1, theme.Accent)
})

TopGradient.Color = ColorSequence.new({
ColorSequenceKeypoint.new(0, theme.Primary),
ColorSequenceKeypoint.new(0.5, theme.Secondary),
ColorSequenceKeypoint.new(1, theme.Accent)
})

LeftSectionGradient.Color = ColorSequence.new({
ColorSequenceKeypoint.new(0, Color3.fromRGB(theme.Background.R * 1.5, theme.Background.G * 1.5, theme.Background.B * 1.5)),
ColorSequenceKeypoint.new(1, theme.Background)
})

RightGradient.Color = ColorSequence.new({
ColorSequenceKeypoint.new(0, Color3.fromRGB(theme.Background.R * 1.8, theme.Background.G * 1.8, theme.Background.B * 1.8)),
ColorSequenceKeypoint.new(0.5, Color3.fromRGB(theme.Background.R * 1.2, theme.Background.G * 1.2, theme.Background.B * 1.2)),
ColorSequenceKeypoint.new(1, Color3.fromRGB(theme.Background.R * 1.5, theme.Background.G * 1.5, theme.Background.B * 1.5))
})

ToggleBtnGradient.Color = ColorSequence.new({
ColorSequenceKeypoint.new(0, theme.Secondary),
ColorSequenceKeypoint.new(1, theme.Accent)
})

for _, gradient in pairs(ButtonGradients) do
gradient.Color = ColorSequence.new({
ColorSequenceKeypoint.new(0, theme.ButtonGradientStart),
ColorSequenceKeypoint.new(1, theme.ButtonGradientEnd)
})
end

for _, textLabel in pairs(ButtonTexts) do
textLabel.TextColor3 = theme.TextColor
end

for _, titleLabel in pairs(SectionTitles) do
titleLabel.TextColor3 = theme.Highlight
end

game.StarterGui:SetCore("SendNotification", {
Title = "PRIME Hub",
Text = "Theme changed to " .. themeName,
Duration = 2
})
end

-- UI THEMES SECTION
local ThemesBtn = Instance.new("TextButton")
ThemesBtn.Size = UDim2.new(1, -10, 0, 35)
ThemesBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 180)
ThemesBtn.Text = "UI Themes"
ThemesBtn.Font = Enum.Font.GothamBold
ThemesBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ThemesBtn.TextSize = 16
ThemesBtn.BorderSizePixel = 0
ThemesBtn.Parent = LeftSection

Instance.new("UICorner", ThemesBtn).CornerRadius = UDim.new(0, 6)

local ThemesBtnGradient = Instance.new("UIGradient")
ThemesBtnGradient.Color = ColorSequence.new({
ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 200, 200)),
ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 150, 200))
})
ThemesBtnGradient.Rotation = 45
ThemesBtnGradient.Parent = ThemesBtn

ButtonGradients["Themes"] = ThemesBtnGradient
ButtonTexts["Themes"] = ThemesBtn

-- Game Button
local GameBtn = Instance.new("TextButton")
GameBtn.Size = UDim2.new(1, -10, 0, 35)
GameBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 100)
GameBtn.Text = "Game"
GameBtn.Font = Enum.Font.GothamBold
GameBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
GameBtn.TextSize = 16
GameBtn.BorderSizePixel = 0
GameBtn.Parent = LeftSection

Instance.new("UICorner", GameBtn).CornerRadius = UDim.new(0, 6)

local GameBtnGradient = Instance.new("UIGradient")
GameBtnGradient.Color = ColorSequence.new({
ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 200, 100)),
ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 150, 80))
})
GameBtnGradient.Rotation = 45
GameBtnGradient.Parent = GameBtn

ButtonGradients["Game"] = GameBtnGradient
ButtonTexts["Game"] = GameBtn

local ThemesContainer = Instance.new("Frame")
ThemesContainer.Size = UDim2.new(1, -20, 0, 300)
ThemesContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ThemesContainer.BackgroundTransparency = 0.1
ThemesContainer.BorderSizePixel = 0
ThemesContainer.Visible = false
ThemesContainer.Parent = ContentFrame

Instance.new("UICorner", ThemesContainer).CornerRadius = UDim.new(0, 8)

local ThemesStroke = Instance.new("UIStroke")
ThemesStroke.Thickness = 2
ThemesStroke.Color = Color3.fromRGB(255, 120, 80)
ThemesStroke.Transparency = 0.3
ThemesStroke.Parent = ThemesContainer

local ThemesContainerGradient = Instance.new("UIGradient")
ThemesContainerGradient.Color = ColorSequence.new({
ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 30, 35)),
ColorSequenceKeypoint.new(0.5, Color3.fromRGB(30, 25, 30)),
ColorSequenceKeypoint.new(1, Color3.fromRGB(35, 30, 35))
})
ThemesContainerGradient.Rotation = 135
ThemesContainerGradient.Parent = ThemesContainer

local ThemesTitle = Instance.new("TextLabel")
ThemesTitle.Size = UDim2.new(1, -20, 0, 35)
ThemesTitle.Position = UDim2.new(0, 10, 0, 10)
ThemesTitle.BackgroundTransparency = 1
ThemesTitle.Text = "🎨 Select Theme"
ThemesTitle.Font = Enum.Font.GothamBold
ThemesTitle.TextColor3 = Color3.fromRGB(0, 255, 255)
ThemesTitle.TextSize = 20
ThemesTitle.Parent = ThemesContainer

SectionTitles["Themes"] = ThemesTitle

local GameContainer = Instance.new("Frame")
GameContainer.Size = UDim2.new(1, -20, 0, 300)
GameContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
GameContainer.BackgroundTransparency = 0.1
GameContainer.BorderSizePixel = 0
GameContainer.Visible = false
GameContainer.Parent = ContentFrame

Instance.new("UICorner", GameContainer).CornerRadius = UDim.new(0, 8)

local GameStroke = Instance.new("UIStroke")
GameStroke.Thickness = 2
GameStroke.Color = Color3.fromRGB(80, 255, 120)
GameStroke.Transparency = 0.3
GameStroke.Parent = GameContainer

local GameContainerGradient = Instance.new("UIGradient")
GameContainerGradient.Color = ColorSequence.new({
ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 40, 35)),
ColorSequenceKeypoint.new(0.5, Color3.fromRGB(25, 30, 25)),
ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 35, 30))
})
GameContainerGradient.Rotation = 135
GameContainerGradient.Parent = GameContainer

local GameTitle = Instance.new("TextLabel")
GameTitle.Size = UDim2.new(1, -20, 0, 35)
GameTitle.Position = UDim2.new(0, 10, 0, 10)
GameTitle.BackgroundTransparency = 1
GameTitle.Text = "🎮 Game Automation"
GameTitle.Font = Enum.Font.GothamBold
GameTitle.TextColor3 = Color3.fromRGB(0, 255, 100)
GameTitle.TextSize = 20
GameTitle.Parent = GameContainer

SectionTitles["Game"] = GameTitle

local GameScrolling = Instance.new("ScrollingFrame")
GameScrolling.Size = UDim2.new(1, 0, 1, -50)
GameScrolling.Position = UDim2.new(0, 0, 0, 50)
GameScrolling.BackgroundTransparency = 1
GameScrolling.BorderSizePixel = 0
GameScrolling.ScrollBarThickness = 6
GameScrolling.Parent = GameContainer

local GameListLayout = Instance.new("UIListLayout")
GameListLayout.Padding = UDim.new(0, 8)
GameListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
GameListLayout.Parent = GameScrolling

-- Create Toggles
createGameToggle("Auto Tap", "AutoTap", StartAutoTap, StopAutoTap, GameScrolling)
createGameToggle("Auto Use can", "AutoMutations", StartAutoMutations, StopAutoMutations, GameScrolling) -- Renamed
createGameToggle("Auto Collect Coins", "AutoCollectCoins", StartAutoCollect, StopAutoCollect, GameScrolling)
createGameToggle("Auto Prestige", "AutoPrestige", StartAutoPrestige, StopAutoPrestige, GameScrolling)
createGameToggle("Auto Pickup Cans", "AutoPickupCans", StartAutoPickupCans, StopAutoPickupCans, GameScrolling)
createGameSlider("Water Threshold", "WaterLevelThreshold", 1, 120, GameScrolling) -- Added Water Level Slider
createGameToggle("Auto Claim Purifier", "AutoClaimPurifier", StartAutoClaimPurifier, StopAutoClaimPurifier, GameScrolling)
createGameToggle("Auto Fill Purifier", "AutoFillPurifier", StartAutoFillPurifier, StopAutoFillPurifier, GameScrolling)
createGameToggle("Auto Steal", "AutoSteal", StartAutoSteal, StopAutoSteal, GameScrolling)
createGameToggle("Speed Hack", "SpeedHack", StartSpeedHack, StopSpeedHack, GameScrolling)
createGameSlider("Walk Speed", "SpeedAmount", 16, 200, GameScrolling) -- Added Speed Hack Slider

GameListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
GameScrolling.CanvasSize = UDim2.new(0, 0, 0, GameListLayout.AbsoluteContentSize.Y + 20)
end)

local ThemeDropdownFrame = Instance.new("Frame")
ThemeDropdownFrame.Size = UDim2.new(1, -20, 0, 40)
ThemeDropdownFrame.Position = UDim2.new(0, 10, 0, 55)
ThemeDropdownFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ThemeDropdownFrame.BorderSizePixel = 0
ThemeDropdownFrame.Parent = ThemesContainer

Instance.new("UICorner", ThemeDropdownFrame).CornerRadius = UDim.new(0, 8)

local ThemeDropdownGradient = Instance.new("UIGradient")
ThemeDropdownGradient.Color = ColorSequence.new({
ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 50, 60)),
ColorSequenceKeypoint.new(1, Color3.fromRGB(35, 40, 50))
})
ThemeDropdownGradient.Rotation = 90
ThemeDropdownGradient.Parent = ThemeDropdownFrame

local ThemeDropdownStroke = Instance.new("UIStroke")
ThemeDropdownStroke.Thickness = 1
ThemeDropdownStroke.Color = Color3.fromRGB(255, 120, 80)
ThemeDropdownStroke.Transparency = 0.5
ThemeDropdownStroke.Parent = ThemeDropdownFrame

local ThemeDropdownButton = Instance.new("TextButton")
ThemeDropdownButton.Size = UDim2.new(1, 0, 1, 0)
ThemeDropdownButton.BackgroundTransparency = 1
ThemeDropdownButton.Text = "🎨 " .. currentTheme
ThemeDropdownButton.Font = Enum.Font.GothamBold
ThemeDropdownButton.TextColor3 = Color3.fromRGB(255, 200, 150)
ThemeDropdownButton.TextSize = 14
ThemeDropdownButton.Parent = ThemeDropdownFrame

local ThemeDropdownPadding = Instance.new("UIPadding")
ThemeDropdownPadding.PaddingLeft = UDim.new(0, 10)
ThemeDropdownPadding.Parent = ThemeDropdownButton

local ThemeDropdownList = Instance.new("ScrollingFrame")
ThemeDropdownList.Size = UDim2.new(1, -20, 0, 180)
ThemeDropdownList.Position = UDim2.new(0, 10, 0, 105)
ThemeDropdownList.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
ThemeDropdownList.BackgroundTransparency = 0.1
ThemeDropdownList.BorderSizePixel = 0
ThemeDropdownList.Visible = false
ThemeDropdownList.ScrollBarThickness = 8
ThemeDropdownList.CanvasSize = UDim2.new(0, 0, 0, 0)
ThemeDropdownList.Parent = ThemesContainer

Instance.new("UICorner", ThemeDropdownList).CornerRadius = UDim.new(0, 8)

local ThemeDropdownListGradient = Instance.new("UIGradient")
ThemeDropdownListGradient.Color = ColorSequence.new({
ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 45, 55)),
ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 35, 45))
})
ThemeDropdownListGradient.Rotation = 90
ThemeDropdownListGradient.Parent = ThemeDropdownList

local ThemeDropdownListStroke = Instance.new("UIStroke")
ThemeDropdownListStroke.Thickness = 2
ThemeDropdownListStroke.Color = Color3.fromRGB(255, 120, 80)
ThemeDropdownListStroke.Transparency = 0.4
ThemeDropdownListStroke.Parent = ThemeDropdownList

local ThemeDropdownListLayout = Instance.new("UIListLayout")
ThemeDropdownListLayout.Padding = UDim.new(0, 3)
ThemeDropdownListLayout.Parent = ThemeDropdownList

local function createThemeOption(themeName)
local ThemeOption = Instance.new("TextButton")
ThemeOption.Size = UDim2.new(1, -10, 0, 32)
ThemeOption.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
ThemeOption.Text = "🎨 " .. themeName
ThemeOption.Font = Enum.Font.GothamBold
ThemeOption.TextColor3 = Color3.fromRGB(220, 220, 240)
ThemeOption.TextSize = 14
ThemeOption.BorderSizePixel = 0
ThemeOption.Parent = ThemeDropdownList

Instance.new("UICorner", ThemeOption).CornerRadius = UDim.new(0, 6)

local ThemeOptionGradient = Instance.new("UIGradient")
ThemeOptionGradient.Color = ColorSequence.new({
ColorSequenceKeypoint.new(0, Color3.fromRGB(55, 60, 70)),
ColorSequenceKeypoint.new(1, Color3.fromRGB(45, 50, 60))
})
ThemeOptionGradient.Rotation = 90
ThemeOptionGradient.Parent = ThemeOption

local ThemeOptionStroke = Instance.new("UIStroke")
ThemeOptionStroke.Thickness = 1
ThemeOptionStroke.Color = Color3.fromRGB(100, 120, 150)
ThemeOptionStroke.Transparency = 0.5
ThemeOptionStroke.Parent = ThemeOption

ThemeOption.MouseEnter:Connect(function()
if currentTheme ~= themeName then
    local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = TweenService:Create(ThemeOption, tweenInfo, {BackgroundColor3 = Color3.fromRGB(70, 80, 100)})
    tween:Play()
    ThemeOption.TextColor3 = Color3.fromRGB(255, 255, 255)
end
end)

ThemeOption.MouseLeave:Connect(function()
if currentTheme ~= themeName then
    local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = TweenService:Create(ThemeOption, tweenInfo, {BackgroundColor3 = Color3.fromRGB(50, 50, 60)})
    tween:Play()
    ThemeOption.TextColor3 = Color3.fromRGB(220, 220, 240)
end
end)

ThemeOption.MouseButton1Click:Connect(function()
applyTheme(themeName)
ThemeDropdownButton.Text = "🎨 " .. themeName

for _, child in pairs(ThemeDropdownList:GetChildren()) do
    if child:IsA("TextButton") then
        child.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
        child.TextColor3 = Color3.fromRGB(220, 220, 240)
    end
end

ThemeOption.BackgroundColor3 = Color3.fromRGB(0, 180, 120)
ThemeOption.TextColor3 = Color3.fromRGB(255, 255, 255)

wait(0.3)
ThemeDropdownList.Visible = false
end)

return ThemeOption
end

for themeName, _ in pairs(ThemeColors) do
createThemeOption(themeName)
end

ThemeDropdownButton.MouseButton1Click:Connect(function()
ThemeDropdownList.Visible = not ThemeDropdownList.Visible
end)


ThemeDropdownListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
ThemeDropdownList.CanvasSize = UDim2.new(0, 0, 0, ThemeDropdownListLayout.AbsoluteContentSize.Y + 10)
end)

-- ABOUT US SECTION
local AboutBtn = Instance.new("TextButton")
AboutBtn.Size = UDim2.new(1, -10, 0, 35)
AboutBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 180)
AboutBtn.Text = "About Us"
AboutBtn.Font = Enum.Font.GothamBold
AboutBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AboutBtn.TextSize = 16
AboutBtn.BorderSizePixel = 0
AboutBtn.Parent = LeftSection

Instance.new("UICorner", AboutBtn).CornerRadius = UDim.new(0, 6)

local AboutBtnGradient = Instance.new("UIGradient")
AboutBtnGradient.Color = ColorSequence.new({
ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 200, 200)),
ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 150, 200))
})
AboutBtnGradient.Rotation = 45
AboutBtnGradient.Parent = AboutBtn

ButtonGradients["About"] = AboutBtnGradient
ButtonTexts["About"] = AboutBtn

local AboutContainer = Instance.new("Frame")
AboutContainer.Size = UDim2.new(1, -20, 0, 280)
AboutContainer.BackgroundColor3 = Color3.fromRGB(25, 28, 35)
AboutContainer.BackgroundTransparency = 0.1
AboutContainer.BorderSizePixel = 0
AboutContainer.Visible = false
AboutContainer.Parent = ContentFrame

Instance.new("UICorner", AboutContainer).CornerRadius = UDim.new(0, 10)

local AboutStroke = Instance.new("UIStroke")
AboutStroke.Thickness = 1.5
AboutStroke.Color = Color3.fromRGB(80, 150, 200)
AboutStroke.Transparency = 0.5
AboutStroke.Parent = AboutContainer

local AboutContainerGradient = Instance.new("UIGradient")
AboutContainerGradient.Color = ColorSequence.new({
ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 35, 42)),
ColorSequenceKeypoint.new(0.5, Color3.fromRGB(22, 26, 35)),
ColorSequenceKeypoint.new(1, Color3.fromRGB(28, 32, 40))
})
AboutContainerGradient.Rotation = 135
AboutContainerGradient.Parent = AboutContainer

-- Header Section with better spacing
local AboutHeader = Instance.new("Frame")
AboutHeader.Size = UDim2.new(1, 0, 0, 45)
AboutHeader.BackgroundColor3 = Color3.fromRGB(35, 40, 50)
AboutHeader.BackgroundTransparency = 0.3
AboutHeader.BorderSizePixel = 0
AboutHeader.Parent = AboutContainer

Instance.new("UICorner", AboutHeader).CornerRadius = UDim.new(0, 10)

local AboutTitle = Instance.new("TextLabel")
AboutTitle.Size = UDim2.new(1, -20, 1, 0)
AboutTitle.Position = UDim2.new(0, 10, 0, 0)
AboutTitle.BackgroundTransparency = 1
AboutTitle.Text = "📋 PRIME Hub Information"
AboutTitle.Font = Enum.Font.GothamBold
AboutTitle.TextColor3 = Color3.fromRGB(120, 200, 255)
AboutTitle.TextSize = 15
AboutTitle.TextXAlignment = Enum.TextXAlignment.Left
AboutTitle.Parent = AboutHeader

SectionTitles["About"] = AboutTitle

-- Info Text with better formatting
local AboutContent = Instance.new("TextLabel")
AboutContent.Size = UDim2.new(1, -30, 0, 90)
AboutContent.Position = UDim2.new(0, 15, 0, 55)
AboutContent.BackgroundTransparency = 1
AboutContent.TextColor3 = Color3.fromRGB(190, 195, 205)
AboutContent.TextSize = 13
AboutContent.Font = Enum.Font.Gotham
AboutContent.TextWrapped = true
AboutContent.TextXAlignment = Enum.TextXAlignment.Left
AboutContent.TextYAlignment = Enum.TextYAlignment.Top
AboutContent.Text = "Version: 1.0\nDeveloper: WENDIGO\n\nCustomizable UI with theme support.\n\nJoin our Discord community:"
AboutContent.Parent = AboutContainer

-- Discord Buttons Container
local DiscordContainer = Instance.new("Frame")
DiscordContainer.Size = UDim2.new(1, -30, 0, 120)
DiscordContainer.Position = UDim2.new(0, 15, 0, 155)
DiscordContainer.BackgroundTransparency = 1
DiscordContainer.Parent = AboutContainer

-- Store Discord Button
local StoreDiscordBtn = Instance.new("TextButton")
StoreDiscordBtn.Size = UDim2.new(1, 0, 0, 45)
StoreDiscordBtn.Position = UDim2.new(0, 0, 0, 0)
StoreDiscordBtn.BackgroundColor3 = Color3.fromRGB(70, 85, 200)
StoreDiscordBtn.BorderSizePixel = 0
StoreDiscordBtn.AutoButtonColor = false
StoreDiscordBtn.Text = ""
StoreDiscordBtn.Parent = DiscordContainer

Instance.new("UICorner", StoreDiscordBtn).CornerRadius = UDim.new(0, 8)

local StoreDiscordGradient = Instance.new("UIGradient")
StoreDiscordGradient.Color = ColorSequence.new({
ColorSequenceKeypoint.new(0, Color3.fromRGB(70, 85, 200)),
ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 65, 180))
})
StoreDiscordGradient.Rotation = 45
StoreDiscordGradient.Parent = StoreDiscordBtn

ButtonGradients["StoreDiscord"] = StoreDiscordGradient

local StoreIcon = Instance.new("TextLabel")
StoreIcon.Size = UDim2.new(0, 35, 1, 0)
StoreIcon.Position = UDim2.new(0, 8, 0, 0)
StoreIcon.BackgroundTransparency = 1
StoreIcon.Text = "🛒"
StoreIcon.Font = Enum.Font.GothamBold
StoreIcon.TextSize = 20
StoreIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
StoreIcon.Parent = StoreDiscordBtn

local StoreLabel = Instance.new("TextLabel")
StoreLabel.Size = UDim2.new(1, -50, 0, 18)
StoreLabel.Position = UDim2.new(0, 45, 0, 6)
StoreLabel.BackgroundTransparency = 1
StoreLabel.Text = "Store Server"
StoreLabel.Font = Enum.Font.GothamBold
StoreLabel.TextSize = 14
StoreLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
StoreLabel.TextXAlignment = Enum.TextXAlignment.Left
StoreLabel.Parent = StoreDiscordBtn

local StoreSubtext = Instance.new("TextLabel")
StoreSubtext.Size = UDim2.new(1, -50, 0, 14)
StoreSubtext.Position = UDim2.new(0, 45, 0, 24)
StoreSubtext.BackgroundTransparency = 1
StoreSubtext.Text = "Premium scripts & products"
StoreSubtext.Font = Enum.Font.Gotham
StoreSubtext.TextSize = 11
StoreSubtext.TextColor3 = Color3.fromRGB(200, 210, 230)
StoreSubtext.TextXAlignment = Enum.TextXAlignment.Left
StoreSubtext.TextTransparency = 0.3
StoreSubtext.Parent = StoreDiscordBtn

StoreDiscordBtn.MouseButton1Click:Connect(function()
setclipboard("https://discord.gg/CzbW5fKcKS")
StoreLabel.Text = "✓ Link Copied!"
wait(2)
StoreLabel.Text = "Store Server"
end)

-- Support Discord Button
local SupportDiscordBtn = Instance.new("TextButton")
SupportDiscordBtn.Size = UDim2.new(1, 0, 0, 45)
SupportDiscordBtn.Position = UDim2.new(0, 0, 0, 55)
SupportDiscordBtn.BackgroundColor3 = Color3.fromRGB(70, 180, 100)
SupportDiscordBtn.BorderSizePixel = 0
SupportDiscordBtn.AutoButtonColor = false
SupportDiscordBtn.Text = "" 
SupportDiscordBtn.Parent = DiscordContainer

Instance.new("UICorner", SupportDiscordBtn).CornerRadius = UDim.new(0, 8)

local SupportDiscordGradient = Instance.new("UIGradient")
SupportDiscordGradient.Color = ColorSequence.new({
ColorSequenceKeypoint.new(0, Color3.fromRGB(70, 180, 100)),
ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 150, 80))
})
SupportDiscordGradient.Rotation = 45
SupportDiscordGradient.Parent = SupportDiscordBtn

ButtonGradients["SupportDiscord"] = SupportDiscordGradient

local SupportIcon = Instance.new("TextLabel")
SupportIcon.Size = UDim2.new(0, 35, 1, 0)
SupportIcon.Position = UDim2.new(0, 8, 0, 0)
SupportIcon.BackgroundTransparency = 1
SupportIcon.Text = "🛠️"
SupportIcon.Font = Enum.Font.GothamBold
SupportIcon.TextSize = 20
SupportIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
SupportIcon.Parent = SupportDiscordBtn

local SupportLabel = Instance.new("TextLabel")
SupportLabel.Size = UDim2.new(1, -50, 0, 18)
SupportLabel.Position = UDim2.new(0, 45, 0, 6)
SupportLabel.BackgroundTransparency = 1
SupportLabel.Text = "Support & Bug Report"
SupportLabel.Font = Enum.Font.GothamBold
SupportLabel.TextSize = 14
SupportLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SupportLabel.TextXAlignment = Enum.TextXAlignment.Left
SupportLabel.Parent = SupportDiscordBtn

local SupportSubtext = Instance.new("TextLabel")
SupportSubtext.Size = UDim2.new(1, -50, 0, 14)
SupportSubtext.Position = UDim2.new(0, 45, 0, 24)
SupportSubtext.BackgroundTransparency = 1
SupportSubtext.Text = "Get help & report issues"
SupportSubtext.Font = Enum.Font.Gotham
SupportSubtext.TextSize = 11
SupportSubtext.TextColor3 = Color3.fromRGB(200, 230, 210)
SupportSubtext.TextXAlignment = Enum.TextXAlignment.Left
SupportSubtext.TextTransparency = 0.3
SupportSubtext.Parent = SupportDiscordBtn

SupportDiscordBtn.MouseButton1Click:Connect(function()
setclipboard("https://discord.gg/nUhMevHxCZ")
SupportLabel.Text = "✓ Link Copied!"
wait(2)
SupportLabel.Text = "Support & Bug Report"
end)

-- Prevent drag interference with scrolling on mobile
ContentFrame.InputBegan:Connect(function(input)
if input.UserInputType == Enum.UserInputType.Touch then
dragging = false
end
end)

-- Auto-update canvas sizes
LeftListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
LeftSection.CanvasSize = UDim2.new(0, 0, 0, LeftListLayout.AbsoluteContentSize.Y + 10)
end)

ContentListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
ContentFrame.CanvasSize = UDim2.new(0, 0, 0, ContentListLayout.AbsoluteContentSize.Y + 10)
end)

-- Toggle Themes Section
ThemesBtn.MouseButton1Click:Connect(function()
if currentSection == "Themes" then
-- Close Themes
local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local tween = TweenService:Create(RightSection, tweenInfo, {Size = UDim2.new(0, 0, 1, -50)})
tween:Play()
wait(0.3)
RightSection.Visible = false
RightSection.Size = UDim2.new(0, 330, 1, -50)
currentSection = nil
else
-- Open Themes
for _, child in pairs(ContentFrame:GetChildren()) do
if child:IsA("GuiObject") then
    child.Visible = false
end
end
ThemesContainer.Visible = true
RightSection.Size = UDim2.new(0, 0, 1, -50)
RightSection.Visible = true
local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local tween = TweenService:Create(RightSection, tweenInfo, {Size = UDim2.new(0, 330, 1, -50)})
tween:Play()
currentSection = "Themes"
end
end)

-- Toggle Game Section
GameBtn.MouseButton1Click:Connect(function()
if currentSection == "Game" then
    -- Close Game
    local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = TweenService:Create(RightSection, tweenInfo, {Size = UDim2.new(0, 0, 1, -50)})
    tween:Play()
    wait(0.3)
    RightSection.Visible = false
    RightSection.Size = UDim2.new(0, 330, 1, -50)
    currentSection = nil
else
    -- Open Game
    for _, child in pairs(ContentFrame:GetChildren()) do
        if child:IsA("GuiObject") then
            child.Visible = false
        end
    end
    GameContainer.Visible = true
    RightSection.Size = UDim2.new(0, 0, 1, -50)
    RightSection.Visible = true
    local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = TweenService:Create(RightSection, tweenInfo, {Size = UDim2.new(0, 330, 1, -50)})
    tween:Play()
    currentSection = "Game"
end
end)

-- Toggle About Section
AboutBtn.MouseButton1Click:Connect(function()
if currentSection == "About" then
-- Close About
local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local tween = TweenService:Create(RightSection, tweenInfo, {Size = UDim2.new(0, 0, 1, -50)})
tween:Play()
wait(0.3)
RightSection.Visible = false
RightSection.Size = UDim2.new(0, 330, 1, -50)
currentSection = nil
else
-- Open About
for _, child in pairs(ContentFrame:GetChildren()) do
if child:IsA("GuiObject") then
    child.Visible = false
end
end
AboutContainer.Visible = true
RightSection.Size = UDim2.new(0, 0, 1, -50)
RightSection.Visible = true
local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local tween = TweenService:Create(RightSection, tweenInfo, {Size = UDim2.new(0, 330, 1, -50)})
tween:Play()
currentSection = "About"
end
end)
