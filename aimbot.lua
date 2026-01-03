-- Menu aimbot by itzinn (Universal)
-- Delta Executor

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- CONFIG
local AimbotEnabled = false
local TeamCheck = true
local AimPart = "Head"
local SelectedPlayer = nil

-- UI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 300, 0, 380)
Frame.Position = UDim2.new(0, 20, 0, 100)
Frame.BackgroundColor3 = Color3.fromRGB(0,0,0)
Frame.Parent = ScreenGui
Frame.Active = true
Frame.Draggable = true

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,0,0,40)
Title.BackgroundTransparency = 1
Title.Text = "Menu aimbot by itzinn"
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 20
Title.Parent = Frame

-- Botão base
local function CreateButton(text, y)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1,-20,0,35)
	btn.Position = UDim2.new(0,10,0,y)
	btn.BackgroundColor3 = Color3.fromRGB(20,20,20)
	btn.TextColor3 = Color3.fromRGB(255,255,255)
	btn.Text = text
	btn.Font = Enum.Font.SourceSans
	btn.TextSize = 16
	btn.Parent = Frame
	return btn
end

local AimToggle = CreateButton("Aimbot: OFF", 50)
local TeamToggle = CreateButton("Team Check: ON", 95)
local HeadBtn = CreateButton("Mirar: Cabeça", 140)
local ChestBtn = CreateButton("Mirar: Peito", 185)

local PlayerList = Instance.new("TextButton")
PlayerList.Size = UDim2.new(1,-20,0,140)
PlayerList.Position = UDim2.new(0,10,0,230)
PlayerList.BackgroundColor3 = Color3.fromRGB(15,15,15)
PlayerList.TextColor3 = Color3.fromRGB(255,255,255)
PlayerList.TextWrapped = true
PlayerList.TextYAlignment = Enum.TextYAlignment.Top
PlayerList.Text = "Clique aqui e depois clique no player no jogo"
PlayerList.Font = Enum.Font.SourceSans
PlayerList.TextSize = 14
PlayerList.Parent = Frame

-- FUNÇÕES
AimToggle.MouseButton1Click:Connect(function()
	AimbotEnabled = not AimbotEnabled
	AimToggle.Text = "Aimbot: "..(AimbotEnabled and "ON" or "OFF")
end)

TeamToggle.MouseButton1Click:Connect(function()
	TeamCheck = not TeamCheck
	TeamToggle.Text = "Team Check: "..(TeamCheck and "ON" or "OFF")
end)

HeadBtn.MouseButton1Click:Connect(function()
	AimPart = "Head"
end)

ChestBtn.MouseButton1Click:Connect(function()
	AimPart = "HumanoidRootPart"
end)

-- Selecionar player clicando
UserInputService.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		local mouse = LocalPlayer:GetMouse()
		if mouse.Target then
			local model = mouse.Target:FindFirstAncestorOfClass("Model")
			if model and Players:FindFirstChild(model.Name) then
				SelectedPlayer = Players[model.Name]
				PlayerList.Text = "Selecionado: "..SelectedPlayer.Name
			end
		end
	end
end)

-- Aimbot
RunService.RenderStepped:Connect(function()
	if AimbotEnabled and SelectedPlayer and SelectedPlayer.Character then
		if TeamCheck and SelectedPlayer.Team == LocalPlayer.Team then
			return
		end

		local char = SelectedPlayer.Character
		local part = char:FindFirstChild(AimPart)
		if part then
			Camera.CFrame = CFrame.new(
				Camera.CFrame.Position,
				part.Position
			)
		end
	end
end)
