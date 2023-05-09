-- Made by upio for legit doors
local Functions = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Functions.lua"))()
local CustomShop = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Custom%20Shop%20Items/Source.lua"))()

local player = game.Players.LocalPlayer
local mainui = player.PlayerGui.MainUI
local mouse = player:GetMouse()

local seekGun = game:GetObjects("rbxassetid://13386404155")[1] or LoadCustomInstance("https://raw.githubusercontent.com/persopoiu/scripts/main/SeekGunAssets/SeekPistol.rbxm")
local seekAmmo = game:GetObjects("rbxassetid://13386436753")[1] or LoadCustomInstance("https://raw.githubusercontent.com/persopoiu/scripts/main/SeekGunAssets/SeekAmmo.rbxm")

if mainui.ItemShop and mainui.ItemShop.Visible then
    CustomShop.CreateItem(seekGun, {
        Title = _G.ShopName or "Seek Gun",
        Desc = _G.ShopDescription or "Seekifies Anything that it shoots",
        Image = "rbxassetid://13390436314",
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


seekGun.Activated:Connect(function()
    local seekAmmoClone = seekAmmo:Clone()
    local spawnPos = workspace.CurrentCamera.CFrame:ToWorldSpace(CFrame.new(0,0,-3) * CFrame.lookAt(Vector3.new(0, 0, 0), workspace.CurrentCamera.CFrame.LookVector))
    
    local Attachment = Instance.new("Attachment", seekAmmoClone)
    local LV = Instance.new("LinearVelocity", Attachment)
    LV.MaxForce = math.huge
    LV.VectorVelocity = mouse.Hit.LookVector * 0.5 * ((_G.launchForce or 20) * 10)
    LV.Attachment0 = Attachment

    seekAmmoClone.Parent = workspace
    seekAmmoClone.CFrame = spawnPos

    playSound("rbxassetid://1905367471")

    seekAmmoClone.Touched:Connect(function(hit)
        seekAmmoClone:Destroy()
        playSound("rbxassetid://344167846")
        
        task.spawn(function()
            local model = hit:FindFirstAncestorWhichIsA("Model")

            if model ~= nil and not (workspace.CurrentRooms:FindFirstChild(model.Name)) then
                local seekpointlight = Instance.new("PointLight",model)
                seekpointlight.Range = 10
                seekpointlight.Brightness = 3
                seekpointlight.Color = Color3.fromRGB(255, 0, 0)

                for _,instance in ipairs(model:GetDescendants()) do
                    if instance:IsA("BasePart") or instance:IsA("Part") or instance:IsA("MeshPart") then
                        instance.Anchored = false
                        instance.Material = "Foil"
                        instance.Color = Color3.fromRGB(0,0,0)
                    end

                    if instance:IsA("TextLabel") then
                        instance.TextColor3 = Color3.fromRGB(255,255,255)
                    end
                end

            end
        end)
    end)
end)
