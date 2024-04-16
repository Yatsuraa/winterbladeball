-- Define a global table to simulate getgenv()
local globals = {}
-- Define placeholder for get_plr() if not already defined
local function get_plr()
    -- Placeholder implementation, replace with actual logic to get the player object.
    return game.Players.LocalPlayer
end
local Range = 20
-- Define IsAlive function if not already defined
local function IsAlive()
    -- Placeholder implementation, replace with actual logic to check if the player is alive.
    local Alive = workspace:WaitForChild("Alive", 20)
    return Alive and Alive:FindFirstChild(get_plr().Name) ~= nil
end
-- Define ViewParryArea function
local function ViewParryArea()
    -- Clean up any previous Annisa object
    local previousAnnisa = workspace:FindFirstChild("Parry Range")
    if previousAnnisa then
        previousAnnisa:Destroy()
    end
    -- Create a new Annisa part
    local Annisa = Instance.new("Part", workspace)
    Annisa.Name = "Parry Range"
    Annisa.Material = Enum.Material.ForceField
    Annisa.CastShadow = false
    Annisa.CanCollide = false
    Annisa.Anchored = true
    Annisa.BrickColor = BrickColor.new("Red")
    Annisa.Shape = Enum.PartType.Ball

    -- Retrieve the local player
    local Players = game:GetService("Players")
    local Player = Players.LocalPlayer

    -- Keep track of the visibility of the parry area
    globals.ViewParryArea = true

    -- Main loop to visualize the parry area
    while globals.ViewParryArea do
        -- Use a wait time that doesnâ€™t degrade performance
        
        task.wait() 
        local plrChar = Player.Character or Player.CharacterAdded:Wait()
        local plrPP = plrChar:FindFirstChild("HumanoidRootPart") or plrChar.PrimaryPart

        if plrPP then
            Annisa.CFrame = CFrame.new(plrPP.Position)
            -- Additional logic for determining the Range based on your game's need
            Annisa.Size = Vector3.new(Range, Range, Range)
            if plrChar:FindFirstChild("Highlight") then
                Annisa.BrickColor = BrickColor.new("Black")
                Range = 50
            else
                Annisa.BrickColor = BrickColor.new("Black")
                Range = 10
            end
            -- Position the Annisa at the player's position
            Annisa.Position = plrPP.Position
        else
            -- If the player does not have a primary part, move the Annisa off-screen
            Annisa.Position = Vector3.new(1000, 1000, 1000)
        end
    end
end

-- Call the ViewParryArea function to activate the parry area visualization
while true do
ViewParryArea()
task.wait()
end