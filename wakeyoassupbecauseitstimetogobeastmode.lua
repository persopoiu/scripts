-- damn worst code ive ever written

if not _G.PlayerName then
    _G.PlayerName = game.Players.LocalPlayer.Name
end

firesignal(game:GetService("ReplicatedStorage").EntityInfo.Caption.OnClientEvent, "Loaded...", true, 3.5)
local Functions = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Functions.lua"))()

local maingame = require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game)
local RunService = game:GetService("RunService")

local character = game.Players:CreateHumanoidModelFromUserId(game.Players:GetUserIdFromNameAsync(_G.PlayerName))
character.Parent = workspace

repeat task.wait() until game.ReplicatedStorage.GameData.LatestRoom.Value ~= 0

for _,i in ipairs(character:GetDescendants()) do
    if i:IsA("BasePart") then
        i.CanCollide = false
    end
end

task.spawn(function()
    task.wait(1.5)
    firesignal(game:GetService("ReplicatedStorage").EntityInfo.Caption.OnClientEvent, "Look Behind you...", true, 3.5)
end)
task.wait(3.5)
RunService.RenderStepped:Connect(function()
    character:PivotTo(CFrame.new(workspace.CurrentRooms[game.ReplicatedStorage.GameData.LatestRoom.Value - 1]:WaitForChild("RoomExit").Position - Vector3.new(0,0,5)))
end)
local sound = Instance.new("Sound",part or game:GetService("ReplicatedStorage"))
sound.SoundId = LoadCustomAsset("https://raw.githubusercontent.com/persopoiu/scripts/main/Wake%20Yo%20Ass%20Up%20It's%20Time%20to%20go%20Beast%20Mode.mp3")
sound.Looped = true
sound.Volume = 2
sound:Play()
game:GetService("Chat"):Chat(character.Head,"Wake yo ass up")
task.wait(1.15)
game:GetService("Chat"):Chat(character.Head,"bcz its time to go")
task.wait(1.75)
game:GetService("Chat"):Chat(character.Head,"beast mode 😱😱😱")

task.spawn(function()
    for i=1,1000 do
        task.wait(0.15)
        task.spawn(function()
            firesignal(game.ReplicatedStorage.EntityInfo.ClutchHeartbeat.OnClientEvent)
        end)
        task.spawn(function()
            require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.RemoteListener.Modules.Screech)(maingame)
        end)
        task.spawn(function()
            require(game:GetService("ReplicatedStorage").ClientModules.Module_Events).flicker(workspace.CurrentRooms[game:GetService("ReplicatedStorage").GameData.LatestRoom.Value], 0.25)
        end)
        task.spawn(function()
            require(game:GetService("ReplicatedStorage").ClientModules.EntityModules.Seek).tease(8, workspace.CurrentRooms[game.Players.LocalPlayer:GetAttribute("CurrentRoom")], 100,true)
        end)
    end
end)
