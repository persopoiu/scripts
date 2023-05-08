-- Made by upio for legit doors
-- ty oogway for the gun idle animation id

local Functions = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Functions.lua"))()
local CustomShop = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Custom%20Shop%20Items/Source.lua"))()

local player = game.Players.LocalPlayer
local mainui = player.PlayerGui.MainUI
local mouse = player:GetMouse()

local seekGun = game:GetObjects("rbxassetid://13386404155")[1] or LoadCustomInstance("https://raw.githubusercontent.com/persopoiu/scripts/main/SeekGunAssets/SeekPistol.rbxm")
local seekGoo = game:GetObjects("rbxassetid://13386436753")[1] or LoadCustomInstance("https://raw.githubusercontent.com/persopoiu/scripts/main/SeekGunAssets/SeekAmmo.rbxm")

seekGun.TextureId = LoadCustomAsset("https://raw.githubusercontent.com/persopoiu/scripts/main/SeekGunAssets/SeekShopDisplay.png")

local anim = Instance.new("Animation")
anim.Name = "M249Idle"
anim.AnimationId = "rbxassetid://3034291703"

local track = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(anim)

if mainui.ItemShop and mainui.ItemShop.Visible then
    CustomShop.CreateItem(seekGun, {
        Title = _G.ShopName or "Seek Gun",
        Desc = _G.ShopDescription or "Seekifies Anything that it shoots",
        Image = "https://raw.githubusercontent.com/persopoiu/scripts/main/SeekGunAssets/SeekShopDisplay.png",
        Price = _G.ShopPrice or 300,
        Stack = 1,
    })
end

seekGun.Parent = player.Backpack

function playSound(rbxassetid,part)
    task.spawn(function()
        local sound = Instance.new("Sound",part or game:GetService("ReplicatedStorage"))
        sound.SoundId = LoadCustomAsset(rbxassetid)
        sound:Play()
        sound.Ended:Wait()
        sound:Destroy()
    end)
end

seekGun.Equipped:Connect(function()
    track:Play()
end)

seekGun.Unequipped:Connect(function()
    track:Stop()
end)

seekGun.Activated:Connect(function()
    local seekGooClone = seekGoo:Clone()
    local velocity = mouse.Hit.LookVector * 0.5 * (_G.launchForce * 10)
    local spawnPos = workspace.CurrentCamera.CFrame:ToWorldSpace(CFrame.new(0,0,-3) * CFrame.lookAt(Vector3.new(0, 0, 0), workspace.CurrentCamera.CFrame.LookVector))
    
    seekGooClone.Parent = workspace
    seekGooClone.CFrame = spawnPos
    seekGooClone.Velocity = velocity

    playSound("rbxassetid://1905367471")

    seekGooClone.Touched:Connect(function(hit)
        seekGooClone:Destroy()
        playSound("https://raw.githubusercontent.com/persopoiu/scripts/main/SeekGunAssets/landedsfx.mp3")
        
        task.spawn(function()
            local model = hit:FindFirstAncestorWhichIsA("Model")

            if model ~= nil and model.Parent ~= workspace.CurrentRooms or model.Name ~= "Assets" then
                local seekpointlight = Instance.new("PointLight",model)
                seekpointlight.Range = 10
                seekpointlight.Brightness = 3
                seekpointlight.Color = Color3.fromRGB(255, 0, 0)

                for _,instance in ipairs(model:GetDescendants()) do
                    if instance:IsA("BasePart") or instance:IsA("Part") or instance:IsA("MeshPart") then
                        instance.Anchored = false
                        instance.Material = Enum.Material.Foil
                        instance.Color = Color3.fromRGB(0,0,0)
                    end
                end

            end
        end)
    end)
end)
