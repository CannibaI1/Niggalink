local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local validKeys = {
    "ghp_1234567890abcdef1234567890abcdef1234",
    "ghpexamplekey0987654321abcdefabcdefabcd"
}

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "KeyCheckUI"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 400, 0, 200)
frame.Position = UDim2.new(0.5, -200, 0, -250)
frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
frame.BorderSizePixel = 0
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.ClipsDescendants = true
frame.Parent = screenGui
frame.BackgroundTransparency = 1

Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

local textBox = Instance.new("TextBox")
textBox.PlaceholderText = "Enter your GitHub key..."
textBox.Size = UDim2.new(0.9, 0, 0, 40)
textBox.Position = UDim2.new(0.05, 0, 0.25, 0)
textBox.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
textBox.ClearTextOnFocus = false
textBox.Font = Enum.Font.Gotham
textBox.TextSize = 16
textBox.Parent = frame
Instance.new("UICorner", textBox).CornerRadius = UDim.new(0, 6)

local submitButton = Instance.new("TextButton")
submitButton.Text = "Submit"
submitButton.Size = UDim2.new(0.4, 0, 0, 36)
submitButton.Position = UDim2.new(0.3, 0, 0.55, 0)
submitButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
submitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
submitButton.Font = Enum.Font.GothamSemibold
submitButton.TextSize = 16
submitButton.Parent = frame
Instance.new("UICorner", submitButton).CornerRadius = UDim.new(0, 6)

local successLabel = Instance.new("TextLabel")
successLabel.Size = UDim2.new(1, 0, 0, 40)
successLabel.Position = UDim2.new(0, 0, 1, 0)
successLabel.BackgroundColor3 = Color3.fromRGB(20, 180, 20)
successLabel.Text = "✓ Success!"
successLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
successLabel.TextScaled = true
successLabel.Font = Enum.Font.GothamBold
successLabel.Visible = false
successLabel.Parent = frame
Instance.new("UICorner", successLabel).CornerRadius = UDim.new(0, 6)

local entranceTween = TweenInfo.new(0.8, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
local successTween = TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

frame.Position = UDim2.new(0.5, 0, 0, -250)
frame.BackgroundTransparency = 1

task.wait(0.2)

TweenService:Create(frame, entranceTween, {
    Position = UDim2.new(0.5, 0, 0.5, 0),
    BackgroundTransparency = 0.1
}):Play()

local function playSuccessAnimation()
    successLabel.Visible = true
    successLabel.Position = UDim2.new(0, 0, 1, 0)

    local slideTween = TweenService:Create(successLabel, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Position = UDim2.new(0, 0, 0.85, 0)
    })

    local pulseTween = TweenService:Create(submitButton, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
        Size = UDim2.new(0.42, 0, 0, 40)
    })

    local resetTween = TweenService:Create(submitButton, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
        Size = UDim2.new(0.4, 0, 0, 36)
    })

    pulseTween:Play()
    pulseTween.Completed:Connect(function()
        resetTween:Play()
    end)

    slideTween:Play()
end

local function checkKey()
    local input = textBox.Text
    for , key in pairs(validKeys) do
        if input == key then
            print("Success!")
            playSuccessAnimation()
            return
        end
    end
    warn("Invalid key.")
end

submitButton.MouseButton1Click:Connect(checkKey)

textBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        checkKey()
    end
end)
