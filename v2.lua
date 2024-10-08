local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wizard"))()
local PhantomForcesWindow = Library:NewWindow("ERT By huh xd")
local ESPWindow = PhantomForcesWindow:NewSection("ESP")

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local ESPSettings = {
    BoxESP = false,
    NameESP = false,
    TracersESP = false,
    DistanceESP = false
}

local function CreateESP(player)
    local box = Drawing.new("Square")
    local nameTag = Drawing.new("Text")
    local tracer = Drawing.new("Line")
    local distanceTag = Drawing.new("Text")

    local function UpdateBoxESP()
        while ESPSettings.BoxESP do
            local character = player.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                local rootPart = character.HumanoidRootPart
                local pos, visible = Camera:WorldToViewportPoint(rootPart.Position)
                box.Visible = visible
                box.Size = Vector2.new(1500 / pos.Z, 3000 / pos.Z)
                box.Position = Vector2.new(pos.X - box.Size.X / 2, pos.Y - box.Size.Y / 2)
                box.Color = Color3.fromRGB(255, 255, 255)
                box.Thickness = 2
            else
                box.Visible = false
            end
            task.wait()
        end
        box.Visible = false
    end

    local function UpdateNameESP()
        while ESPSettings.NameESP do
            local character = player.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                local rootPart = character.HumanoidRootPart
                local pos, visible = Camera:WorldToViewportPoint(rootPart.Position)
                nameTag.Visible = visible
                nameTag.Text = player.Name
                nameTag.Position = Vector2.new(pos.X, pos.Y + 40)
                nameTag.Color = Color3.fromRGB(255, 255, 255)
                nameTag.Size = 16
                nameTag.Center = true
                nameTag.Outline = true
                nameTag.OutlineColor = Color3.fromRGB(0, 0, 0)
            else
                nameTag.Visible = false
            end
            task.wait()
        end
        nameTag.Visible = false
    end

    local function UpdateDistanceESP()
        while ESPSettings.DistanceESP do
            local character = player.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                local rootPart = character.HumanoidRootPart
                local pos, visible = Camera:WorldToViewportPoint(rootPart.Position)
                distanceTag.Visible = visible
                distanceTag.Text = string.format("Distance: %d", math.floor((Player.Character.HumanoidRootPart.Position - rootPart.Position).Magnitude))
                distanceTag.Position = Vector2.new(pos.X, pos.Y - 60)
                distanceTag.Color = Color3.fromRGB(255, 255, 255)
                distanceTag.Size = 16
                distanceTag.Center = true
                distanceTag.Outline = true
                distanceTag.OutlineColor = Color3.fromRGB(0, 0, 0)
            else
                distanceTag.Visible = false
            end
            task.wait()
        end
        distanceTag.Visible = false
    end

    local function UpdateTracersESP()
        while ESPSettings.TracersESP do
            local character = player.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                local rootPart = character.HumanoidRootPart
                local pos, visible = Camera:WorldToViewportPoint(rootPart.Position)
                tracer.Visible = visible
                tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                tracer.To = Vector2.new(pos.X, pos.Y)
                tracer.Color = Color3.fromRGB(255, 255, 255)
                tracer.Thickness = 1
            else
                tracer.Visible = false
            end
            task.wait()
        end
        tracer.Visible = false
    end

    if ESPSettings.BoxESP then
        coroutine.wrap(UpdateBoxESP)()
    end
    if ESPSettings.NameESP then
        coroutine.wrap(UpdateNameESP)()
    end
    if ESPSettings.TracersESP then
        coroutine.wrap(UpdateTracersESP)()
    end
    if ESPSettings.DistanceESP then
        coroutine.wrap(UpdateDistanceESP)()
    end
end

local function ToggleESP(type, value)
    ESPSettings[type] = value
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= Player then
            CreateESP(player)
        end
    end
end

ESPWindow:CreateToggle("碰撞箱ESP", function(state)
    ToggleESP("BoxESP", state)
end)

ESPWindow:CreateToggle("名字ESP", function(state)
    ToggleESP("NameESP", state)
end)

ESPWindow:CreateToggle("线条ESP", function(state)
    ToggleESP("TracersESP", state)
end)

ESPWindow:CreateToggle("距离ESP", function(state)
    ToggleESP("DistanceESP", state)
end)

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        CreateESP(player)
    end)
end)

for _, player in pairs(Players:GetPlayers()) do
    if player ~= Player then
        player.CharacterAdded:Connect(function()
            CreateESP(player)
        end)
    end
end
