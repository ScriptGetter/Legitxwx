repeat task.wait() until game:IsLoaded()

-- ⚡ FPS Unlock
if setfpscap then
    setfpscap(1000000)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "dsc.gg/9e9V648aGq",
        Text = "FPS Unlocked!",
        Duration = 2,
        Button1 = "Okay"
    })
    warn("FPS Unlocked!")
else
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "dsc.gg/9e9V648aGq",
        Text = "Your exploit does not support setfpscap.",
        Duration = 2,
        Button1 = "Okay"
    })
    warn("Your exploit does not support setfpscap.")
end

-- 🌌 Load WindUI v6
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local Window = WindUI:CreateWindow({
    Title = "Legitxwx Hub | v1.1.7",
    Icon = "door-open",
    Author = "by xwx",
    Folder = "LegitxwxHub",
    Theme = "Dark",
    Size = UDim2.fromOffset(580, 460),
    MinSize = Vector2.new(560, 350),
    MaxSize = Vector2.new(850, 560),
})

-- 📦 Services & Player
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- 🔗 Remotes
local BuyGearRemote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("BuyGear")
local BuyItemRemote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("BuyItem")
local EquipBestBrainrotRemote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("EquipBestBrainrots")

-- 📋 Lists
local gearList = {"Water Bucket","Frost Grenade","Banana Gun","Frost Blower","Carrot Launcher"}
local seedList = {"Cactus Seed","Strawberry Seed","Pumpkin Seed","Sunflower Seed","Dragon Seed","Eggplant Seed","Watermelon Seed","Grape Seed","Cocotank Seed","Carnivorous Plant Seed","Mr Carrot Seed","Tomatrio Seed","Shroombino Seed","Mango Seed","King Limone Seed"}

-- ⚙️ Variables
local selectedGears, selectedSeeds = {}, {}
local autoBuyGears, autoBuySeeds = false, false
local autoBuyAllGears, autoBuyAllSeeds = false, false
local gearDelay, seedDelay = 1, 0.1
local autoBestBrainrot, autoBrainrotDelay = false, 60

-- 📌 Functions
local function buyGear(item) pcall(function() BuyGearRemote:FireServer(item) end) end
local function buySeed(item) pcall(function() BuyItemRemote:FireServer(item) end) end
local function equipBestBrainrot() pcall(function() EquipBestBrainrotRemote:FireServer() end) end

-- 💤 Anti-AFK
local VirtualUser = game:GetService("VirtualUser")
LocalPlayer.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

-- 🌟 Gears Tab
local gearTab = Window:Tab({Title = " Gears", Icon = "tool"})
gearTab:Paragraph({Title = "Gear Shop", Desc = "Select gears and choose how to buy them."})

gearTab:Dropdown({
    Title = "Select Gears",
    Values = gearList,
    Multi = true,
    AllowNone = true,
    Callback = function(option) selectedGears = option end
})

gearTab:Input({
    Title = "Gear Buy Delay (seconds)",
    Value = "1",
    Callback = function(input)
        local num = tonumber(input)
        if num and num > 0 then gearDelay = num end
    end
})

gearTab:Toggle({
    Title = "Auto Buy Selected Gears",
    Default = false,
    Callback = function(state)
        autoBuyGears = state
        task.spawn(function()
            while autoBuyGears do
                for _, gear in ipairs(selectedGears) do
                    if not autoBuyGears then break end
                    buyGear(gear)
                    task.wait(gearDelay)
                end
                task.wait(1)
            end
        end)
    end
})

gearTab:Toggle({
    Title = "Auto Buy ALL Gears",
    Default = false,
    Callback = function(state)
        autoBuyAllGears = state
        task.spawn(function()
            while autoBuyAllGears do
                for _, gear in ipairs(gearList) do
                    if not autoBuyAllGears then break end
                    buyGear(gear)
                    task.wait(gearDelay)
                end
                task.wait(1)
            end
        end)
    end
})

-- 🌱 Seeds Tab
local seedTab = Window:Tab({Title = " Seeds", Icon = "leaf"})
seedTab:Paragraph({Title = "Seed Shop", Desc = "Automatically buy seeds instantly when restocked."})

seedTab:Dropdown({
    Title = "Select Seeds",
    Values = seedList,
    Multi = true,
    AllowNone = true,
    Callback = function(option) selectedSeeds = option end
})

seedTab:Input({
    Title = "Seed Buy Delay (seconds)",
    Value = "0.1",
    Callback = function(input)
        local num = tonumber(input)
        if num and num >= 0.1 then seedDelay = num end
    end
})

seedTab:Toggle({
    Title = "⚡ Auto Buy Selected Seeds (Fast Mode)",
    Default = false,
    Callback = function(state)
        autoBuySeeds = state
        task.spawn(function()
            while autoBuySeeds do
                for _, seed in ipairs(selectedSeeds) do
                    if not autoBuySeeds then break end
                    buySeed(seed)
                    task.wait(seedDelay)
                end
                task.wait(0.1)
            end
        end)
    end
})

seedTab:Toggle({
    Title = "⚡ Auto Buy ALL Seeds (Ultra Fast)",
    Default = false,
    Callback = function(state)
        autoBuyAllSeeds = state
        task.spawn(function()
            while autoBuyAllSeeds do
                for _, seed in ipairs(seedList) do
                    if not autoBuyAllSeeds then break end
                    buySeed(seed)
                    task.wait(seedDelay)
                end
                task.wait(0.1)
            end
        end)
    end
})

-- 🧠 Brainrots Tab
local brainTab = Window:Tab({Title = " Brainrots", Icon = "brain"})
brainTab:Paragraph({Title = "Brainrot Auto", Desc = "Equip the best brainrot automatically or manually."})

brainTab:Button({
    Title = "Equip Best Brainrot",
    Callback = function()
        equipBestBrainrot()
    end
})

brainTab:Input({
    Title = "Auto Collect Delay (seconds)",
    Value = "60",
    Callback = function(input)
        local num = tonumber(input)
        if num and num > 0 then autoBrainrotDelay = num end
    end
})

brainTab:Toggle({
    Title = "Auto Equip Best Brainrot",
    Default = false,
    Callback = function(state)
        autoBestBrainrot = state
        task.spawn(function()
            while autoBestBrainrot do
                equipBestBrainrot()
                task.wait(autoBrainrotDelay)
            end
        end)
    end
})

-- ✅ Initialize
Window:SelectTab(1)
WindUI:Init()
