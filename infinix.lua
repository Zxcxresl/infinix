local success, errorMsg = pcall(function()
    print("Iniciando Infinix Cheats v2.1...")
    local player = game.Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui", 10)
    local userInputService = game:GetService("UserInputService")
    local runService = game:GetService("RunService")
    local tweenService = game:GetService("TweenService")
    local httpService = game:GetService("HttpService")
    if not playerGui then error("PlayerGui no encontrado") end

    -- Cachear referencias
    local camera = workspace.CurrentCamera
    local players = game:GetService("Players")

    -- ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "InfinixCheats"
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.Parent = playerGui

    -- Sonidos
    local soundOn = Instance.new("Sound", screenGui)
    soundOn.SoundId = "rbxassetid://911289071"
    soundOn.Volume = 0.3
    local soundOff = Instance.new("Sound", screenGui)
    soundOff.SoundId = "rbxassetid://911289085"
    soundOff.Volume = 0.3

    -- Círculo de FOV
    local fovCircle = Instance.new("Frame", screenGui)
    fovCircle.Size = UDim2.new(0, 100, 0, 100)
    fovCircle.Position = UDim2.new(0.5, 0, 0.5, 0)
    fovCircle.AnchorPoint = Vector2.new(0.5, 0.5)
    fovCircle.BackgroundColor3 = Color3.fromRGB(128, 128, 128)
    fovCircle.BackgroundTransparency = 0.7
    fovCircle.BorderSizePixel = 0
    fovCircle.ZIndex = 1000
    fovCircle.Visible = false
    local fovCircleCorner = Instance.new("UICorner", fovCircle)
    fovCircleCorner.CornerRadius = UDim.new(0.5, 0)

    -- Línea Roja
    local aimLine = Instance.new("Beam", workspace)
    aimLine.Color = ColorSequence.new(Color3.fromRGB(255, 0, 0))
    aimLine.Width0 = 1
    aimLine.Width1 = 1
    aimLine.Transparency = NumberSequence.new(0)
    aimLine.Enabled = false
    local aimAttach0 = Instance.new("Attachment")
    local aimAttach1 = Instance.new("Attachment")
    aimLine.Attachment0 = aimAttach0
    aimLine.Attachment1 = aimAttach1

    -- Hitmarker
    local hitmarker = Instance.new("Frame", screenGui)
    hitmarker.Size = UDim2.new(0, 20, 0, 20)
    hitmarker.Position = UDim2.new(0.5, -10, 0.5, -10)
    hitmarker.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    hitmarker.BackgroundTransparency = 1
    hitmarker.ZIndex = 1001
    local hitmarkerCorner = Instance.new("UICorner", hitmarker)
    hitmarkerCorner.CornerRadius = UDim.new(0.5, 0)
    local function showHitmarker()
        hitmarker.BackgroundTransparency = 0
        tweenService:Create(hitmarker, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
    end

    -- Kill Counter
    local killCount = 0
    local killCounterLabel = Instance.new("TextLabel", screenGui)
    killCounterLabel.Size = UDim2.new(0, 100, 0, 30)
    killCounterLabel.Position = UDim2.new(0, 10, 0, 70)
    killCounterLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
    killCounterLabel.BackgroundTransparency = 0.5
    killCounterLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    killCounterLabel.Font = Enum.Font.SourceSansBold
    killCounterLabel.TextSize = 16
    killCounterLabel.Text = "Bajas: 0"
    killCounterLabel.ZIndex = 1000
    local killCounterCorner = Instance.new("UICorner", killCounterLabel)
    killCounterCorner.CornerRadius = UDim.new(0, 6)

    -- Mensaje Temporal
    local function showTempMessage(text)
        local tempLabel = Instance.new("TextLabel", screenGui)
        tempLabel.Size = UDim2.new(0, 300, 0, 50)
        tempLabel.Position = UDim2.new(0.5, -150, 0.5, -25)
        tempLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
        tempLabel.BackgroundTransparency = 0.5
        tempLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        tempLabel.Font = Enum.Font.SourceSansBold
        tempLabel.TextSize = 16
        tempLabel.Text = text
        tempLabel.ZIndex = 1001
        local corner = Instance.new("UICorner", tempLabel)
        corner.CornerRadius = UDim.new(0, 10)
        spawn(function()
            wait(3)
            tweenService:Create(tempLabel, TweenInfo.new(0.5), {BackgroundTransparency = 1, TextTransparency = 1}):Play()
            wait(0.5)
            tempLabel:Destroy()
        end)
    end

    -- Pantalla de Clave
    local keyFrame = Instance.new("Frame", screenGui)
    keyFrame.Size = UDim2.new(0, 300, 0, 200)
    keyFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
    keyFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
    keyFrame.BackgroundTransparency = 0.5
    keyFrame.ZIndex = 1001
    local keyCorner = Instance.new("UICorner", keyFrame)
    keyCorner.CornerRadius = UDim.new(0, 10)

    local keyTitle = Instance.new("TextLabel", keyFrame)
    keyTitle.Size = UDim2.new(1, 0, 0, 30)
    keyTitle.BackgroundTransparency = 1
    keyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    keyTitle.Font = Enum.Font.SourceSansBold
    keyTitle.TextSize = 18
    keyTitle.Text = "Infinix Cheats - Ingresar Clave"
    keyTitle.ZIndex = 1002

    local keyInput = Instance.new("TextBox", keyFrame)
    keyInput.Size = UDim2.new(0.8, 0, 0, 40)
    keyInput.Position = UDim2.new(0.1, 0, 0.3, 0)
    keyInput.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    keyInput.TextColor3 = Color3.fromRGB(0, 0, 0)
    keyInput.Font = Enum.Font.SourceSans
    keyInput.TextSize = 16
    keyInput.PlaceholderText = "Ingresa la clave..."
    keyInput.ZIndex = 1002
    local inputCorner = Instance.new("UICorner", keyInput)
    inputCorner.CornerRadius = UDim.new(0, 6)

    local submitButton = Instance.new("TextButton", keyFrame)
    submitButton.Size = UDim2.new(0.8, 0, 0, 40)
    submitButton.Position = UDim2.new(0.1, 0, 0.6, 0)
    submitButton.BackgroundColor3 = Color3.fromRGB(50, 50, 255)
    submitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    submitButton.Font = Enum.Font.SourceSansBold
    submitButton.TextSize = 16
    submitButton.Text = "Enviar"
    submitButton.ZIndex = 1002
    local submitCorner = Instance.new("UICorner", submitButton)
    submitCorner.CornerRadius = UDim.new(0, 6)

    local errorLabel = Instance.new("TextLabel", keyFrame)
    errorLabel.Size = UDim2.new(1, 0, 0, 20)
    errorLabel.Position = UDim2.new(0, 0, 0.85, 0)
    errorLabel.BackgroundTransparency = 1
    errorLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
    errorLabel.Font = Enum.Font.SourceSans
    errorLabel.TextSize = 14
    errorLabel.Text = ""
    errorLabel.ZIndex = 1002

    -- Animación de entrada
    keyFrame.Size = UDim2.new(0, 0, 0, 0)
    tweenService:Create(keyFrame, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {Size = UDim2.new(0, 300, 0, 200)}):Play()

    -- Pantalla de Bienvenida
    local welcomeFrame = Instance.new("Frame", screenGui)
    welcomeFrame.Size = UDim2.new(1, 0, 1, 0)
    welcomeFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
    welcomeFrame.BackgroundTransparency = 1
    welcomeFrame.ZIndex = 1003
    welcomeFrame.Visible = false

    local welcomeLabel = Instance.new("TextLabel", welcomeFrame)
    welcomeLabel.Size = UDim2.new(1, 0, 0, 50)
    welcomeLabel.Position = UDim2.new(0, 0, 0.5, -25)
    welcomeLabel.BackgroundTransparency = 1
    welcomeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    welcomeLabel.Font = Enum.Font.SourceSansBold
    welcomeLabel.TextSize = 24
    welcomeLabel.ZIndex = 1004

    -- Botón Flotante
    local toggleButton = Instance.new("TextButton", screenGui)
    toggleButton.Size = UDim2.new(0, 50, 0, 50)
    toggleButton.Position = UDim2.new(1, -60, 0, 10)
    toggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 255)
    toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleButton.Font = Enum.Font.SourceSansBold
    toggleButton.TextSize = 20
    toggleButton.Text = "≡"
    toggleButton.ZIndex = 1000
    local toggleCorner = Instance.new("UICorner", toggleButton)
    toggleCorner.CornerRadius = UDim.new(0, 10)

    -- Frame Principal
    local frame = Instance.new("Frame", screenGui)
    frame.Size = UDim2.new(0, 300, 0, 350)
    frame.Position = UDim2.new(0.5, -150, 0.5, -175)
    frame.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
    frame.BackgroundTransparency = 0.5
    frame.Active = true
    frame.Draggable = true
    frame.ZIndex = 1
    frame.Visible = false
    local frameCorner = Instance.new("UICorner", frame)
    frameCorner.CornerRadius = UDim.new(0, 10)

    local title = Instance.new("TextLabel", frame)
    title.Size = UDim2.new(1, 0, 0, 30)
    title.BackgroundColor3 = Color3.fromRGB(20, 20, 50)
    title.BackgroundTransparency = 0.5
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Font = Enum.Font.SourceSansBold
    title.TextSize = 16
    title.Text = "Infinix Cheats v2.1"

    local closeButton = Instance.new("TextButton", frame)
    closeButton.Size = UDim2.new(0, 30, 0, 30)
    closeButton.Position = UDim2.new(1, -40, 0, 5)
    closeButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.Text = "X"
    closeButton.Font = Enum.Font.SourceSansBold
    closeButton.TextSize = 16
    local closeCorner = Instance.new("UICorner", closeButton)
    closeCorner.CornerRadius = UDim.new(0, 6)

    local minimizeButton = Instance.new("TextButton", frame)
    minimizeButton.Size = UDim2.new(0, 30, 0, 30)
    minimizeButton.Position = UDim2.new(1, -80, 0, 5)
    minimizeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 255)
    minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    minimizeButton.Text = "-"
    minimizeButton.Font = Enum.Font.SourceSansBold
    minimizeButton.TextSize = 16
    local minimizeCorner = Instance.new("UICorner", minimizeButton)
    minimizeCorner.CornerRadius = UDim.new(0, 6)

    local resizeHandle = Instance.new("Frame", frame)
    resizeHandle.Size = UDim2.new(0, 20, 0, 20)
    resizeHandle.Position = UDim2.new(1, -20, 1, -20)
    resizeHandle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    resizeHandle.BackgroundTransparency = 0.5
    local resizeCorner = Instance.new("UICorner", resizeHandle)
    resizeCorner.CornerRadius = UDim.new(0, 6)

    local tabFrame = Instance.new("Frame", frame)
    tabFrame.Size = UDim2.new(1, 0, 0, 40)
    tabFrame.Position = UDim2.new(0, 0, 0, 30)
    tabFrame.BackgroundTransparency = 1

    local contentFrame = Instance.new("ScrollingFrame", frame)
    contentFrame.Size = UDim2.new(1, 0, 1, -70)
    contentFrame.Position = UDim2.new(0, 0, 0, 70)
    contentFrame.BackgroundTransparency = 1
    contentFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    contentFrame.ScrollingDirection = Enum.ScrollingDirection.Y
    contentFrame.ScrollBarThickness = 6

    -- Boost Window
    local boostFrame = Instance.new("Frame", screenGui)
    boostFrame.Size = UDim2.new(0, 100, 0, 50)
    boostFrame.Position = UDim2.new(0, 10, 1, -60)
    boostFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    boostFrame.BackgroundTransparency = 0.5
    boostFrame.ZIndex = 1000
    boostFrame.Visible = false
    local boostCorner = Instance.new("UICorner", boostFrame)
    boostCorner.CornerRadius = UDim.new(0, 10)

    local boostButton = Instance.new("TextButton", boostFrame)
    boostButton.Size = UDim2.new(1, 0, 1, 0)
    boostButton.BackgroundTransparency = 1
    boostButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    boostButton.Font = Enum.Font.SourceSansBold
    boostButton.TextSize = 16
    boostButton.Text = "Boost"
    boostButton.ZIndex = 1001

    -- Pestañas
    local tabs = {"Main", "Básico", "Combate", "Información", "Avanzado", "Otros", "Visuales"}
    local tabButtons = {}
    local currentTab = nil

    for i, tabName in ipairs(tabs) do
        local tabButton = Instance.new("TextButton", tabFrame)
        tabButton.Size = UDim2.new(0.142, 0, 1, 0)
        tabButton.Position = UDim2.new((i-1)*0.142, 0, 0, 0)
        tabButton.BackgroundColor3 = Color3.fromRGB(20, 20, 50)
        tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        tabButton.Font = Enum.Font.SourceSans
        tabButton.TextSize = 14
        tabButton.Text = tabName
        tabButton.ZIndex = 3
        local corner = Instance.new("UICorner", tabButton)
        corner.CornerRadius = UDim.new(0, 6)
        tabButtons[tabName] = tabButton
    end

    -- Verificación de Clave
    local correctKey = "infinix"
    submitButton.Activated:Connect(function()
        if string.lower(keyInput.Text) == correctKey then
            tweenService:Create(keyFrame, TweenInfo.new(0.5), {BackgroundTransparency = 1, Size = UDim2.new(0, 0, 0, 0)}):Play()
            wait(0.5)
            keyFrame.Visible = false
            welcomeFrame.Visible = true
            local fullText = "Bienvenido a Infinix Cheats v2.1"
            local currentText = ""
            for i = 1, #fullText do
                currentText = currentText .. fullText:sub(i, i)
                welcomeLabel.Text = currentText
                wait(0.05)
            end
            wait(2)
            tweenService:Create(welcomeFrame, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
            wait(0.5)
            welcomeFrame:Destroy()
            showTempMessage("Infinix Cheats cargado. Toca ≡ para abrir.")
        else
            errorLabel.Text = "Clave incorrecta. Intenta de nuevo."
        end
    end)

    -- ESP Logic
    local espEnabled = {enabled = false, box = false, lines = false, objects = {}, fillEnabled = true, fillColor = Color3.fromRGB(255, 255, 255), 255, 255, 255), fillTransparency = 0.5, outlineColor = Color3.fromRGB(255, 255, 255), 255, 255}
    local espConnection

    local function applyESP(character, plr local plr = game.Players:GetPlayerFromCharacter(character)
        if not character or not plr or not character:FindFirstChild("HumanoidRootPart") then return end

        local highlight = Instance.new("Highlight", character)
        highlight.FillTransparency = espConfig.fillEnabled and espConfig.fillTransparency or 1
        highlight.FillColor3 = espConfig.fillColor
        highlight.OutlineTransparency = espConfig.box and 0 or 1
        highlight.OutlineColor3 = espConfig.outlineColor

        local billboard = Instance.new("BillboardGui", character)
        billboard.Adornee = character:FindFirstChild("Head")
        billboard.Size = UDim2.new(0, 200, 0, 50)
        billboard.StudsOffset = Vector3.new(0, 2, 0)
        billboard.AlwaysOnTop = true

        local textLabel = Instance.new("TextLabel", billboard)
        textLabel.Size = UDim2.new(1, 0, 1, 0)
        textLabel.BackgroundTransparency = 1
        textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        textLabel.Font = Enum.Font.SourceSansBold
        textLabel.TextSize = 14
        textLabel.TextStrokeTransparency = 0.5

        local beam = Instance.new("Beam", character)
        beam.Enabled = espConfig.lines
        beam.Color = ColorSequence.new(espConfig.outlineColor)
        beam.Width0 = 0.2
        beam.Width1 = 0.2
        local attachment0 = Instance.new("Attachment", player.Character and player.Character.HumanoidRootPart)
        local attachment1 = Instance.new("Attachment", character.HumanoidRootPart)
        beam.Attachment0 = attachment0
        beam.Attachment1 = attachment1

        local teamName = plr.Name
        local humanoid = character:FindFirstChild("Humanoid")
        local health = humanoid and math.floor(humanoid.Health) or 0
        local maxHealth = humanoid and math.floor(humanoid.MaxHealth) or 100
        local distance = player.Character and (character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude or 0
        textLabel.Text = string.format("%s | %.1fm | %d/%d HP | %s", teamName, distance, health, maxHealth, plr.Name)

        espConfig.objects[character] = {highlight, billboard, textLabel, beam}
    end

    local function updateESP()
        if not player.Character or not espConfig.HumanoidRootPart then return end
        for _, plr in pairs(players:GetPlayers()) do
            if plr ~= player and plr.Character then
                local char = plr.Character
                local espData = espConfig.objects[char]
                if espData and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("Humanoid") then
                    local distance = (char.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
                    local teamName = plr.Name
                    local health = math.floor(char.Humanoid.Health)
                    local maxHealth = math.floor(char.Humanoid.MaxHealth)
                    espData[3].text = string.format("%s | %.1fm | %.1fm | %d/%d HP | %s", distance, teamName, distance, health, maxHealth, plr.Name)
                    espData[1].Enabled = true
                    espData[2].Enabled = true
                    espData[4].Enabled = espConfig.lines
                end
            end
        end
    end

    local function refreshESP()
        for _, data in pairs(espConfig.objects) do
            for _, obj in pairs(data) do
                obj:Destroy()
            end
        end
        espConfig.objects = {}
        for _, plr in pairs(players:GetPlayers()) do
            if plr ~= player and plr.Character then
                applyESP(plr.Character)
            end
        end
    end

    local function toggleESP()
        espConfig.enabled = not espConfig.enabled
        showTempMessage("ESP: " .. (espConfig.enabled and "Activado" or "Desactivado"))
        if espConfig.enabled then
            soundOn:Play()
            refreshESP()
            espConnection = runService.Heartbeat:Connect(updateESP)
            for _, plr in pairs(players:GetPlayers()) do
                if plr ~= player then
                    plr.CharacterAdded:Connect(function(character)
                        if espConfig.enabled then applyESP(character) end
                    end)
                end
            end
        else
            soundOff:Play()
            if espConnection then espConnection:Disconnect() end
            for _, data in pairs(espConfig.objects) do
                for _, obj in pairs(data) do
                    obj:Destroy()
                end
            end
            espConfig.objects = {}
        end
    end

    -- Fly Logic
    local flyConfig = {enabled = false, speed = 50}
    local flyConnection, bodyVelocity, bodyGyro, flyControlsFrame

    local function startFly()
        if not player.Character or not player.Character.HumanoidRootPart then
            showTempMessage("Personaje no disponible")
            return
        end
        local rootPart = player.Character.HumanoidRootPart
        bodyVelocity = Instance.new("BodyVelocity", rootPart)
        bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)

        bodyGyro = Instance.new("BodyGyro", rootPart)
        bodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        bodyGyro.CFrame = rootPart.CFrame

        flyControlsFrame.Visible = true
        flyConnection = runService.RenderStepped:Connect(updateFlyDirection)
        showTempMessage("Fly iniciado")
    end

    local function stopFly()
        if bodyVelocity then bodyVelocity:Destroy() end
        if bodyGyro then bodyGyro:Destroy() end
        if flyConnection then flyConnection:Disconnect() end
        flyControlsFrame.Visible = false
        showTempMessage("Fly detenido")
    end

    local function toggleFly()
        flyConfig.enabled = not flyConfig.enabled
        showTempMessage("Fly: " .. (flyConfig.enabled and "Activado" or "Desactivado"))
        if flyConfig.enabled then
            soundOn:Play()
            startFly()
        else
            soundOff:Play()
            stopFly()
        end
    end

    -- Up/Down Logic
    local upDownDistance = 50
    local function moveVertical(direction)
        if player.Character and player.Character.HumanoidRootPart then
            player.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame + Vector3.new(0, direction * upDownDistance, 0)
            showTempMessage(direction > 0 and "Subiendo..." or "Bajando...")
        else
            showTempMessage("Personaje no disponible")
        end
    end

    -- Speed Logic
    local walkSpeed = 16
    local function updateSpeed(newSpeed)
        walkSpeed = math.clamp(newSpeed, 16, 100)
        if player.Character and player.Character.Humanoid then
            player.Character.Humanoid.WalkSpeed = walkSpeed
        end
        showTempMessage("Velocidad: " .. walkSpeed)
    end

    -- Boost Logic
    local boostActive = false
    boostButton.Activated:Connect(function()
        if boostActive then return end
        boostActive = true
        showTempMessage("Boost activado")
        local originalSpeed = walkSpeed
        updateSpeed(walkSpeed + 50)
        wait(1)
        updateSpeed(originalSpeed)
        showTempMessage("Boost terminado")
        boostActive = false
    end)

    -- Aimbot Logic
    local aimbotConfig = {enabled = false, part = "Head", smoothness = 0.2, prediction = true, showFOV = true, fov = 150, triggerbot = false}
    local currentTarget = nil
    local aimbotConnection

    local function updateFOVCircle()
        fovCircle.Size = UDim2.new(0, aimbotConfig.fov * 2, 0, aimbotConfig.fov * 2)
        fovCircle.Visible = aimbotConfig.showFOV and aimbotConfig.enabled
    end

    local function updateAimLine(target)
        if target and target.Character and target.Character:FindFirstChild(aimbotConfig.part) and player.Character then
            aimAttach0.Parent = player.Character.HumanoidRootPart
            aimAttach1.Parent = target.Character[aimbotConfig.part]
            aimAttach0.WorldPosition = player.Character.HumanoidRootPart.Position + Vector3.new(0, 1.5, 0)
            aimAttach1.WorldPosition = target.Character[aimbotConfig.part].Position
            aimLine.Enabled = true
        else
            aimLine.Enabled = false
            aimAttach0.Parent = nil
            aimAttach1.Parent = nil
        end
    end

    local function getBestTarget()
        if not player.Character or not player.Character.HumanoidRootPart then return nil end
        local closestPlayer, closestDistance = nil, math.huge

        for _, plr in ipairs(players:GetPlayers()) do
            if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and 
               plr.Character:FindFirstChild(aimbotConfig.part) and plr.Character.Humanoid and plr.Character.Humanoid.Health > 0 then
                local targetPart = plr.Character[aimbotConfig.part]
                local worldDistance = (targetPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
                local _, onScreen = camera:WorldToScreenPoint(targetPart.Position)

                if onScreen then
                    local raycastParams = RaycastParams.new()
                    raycastParams.FilterDescendantsInstances = {player.Character}
                    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
                    local rayResult = workspace:Raycast(camera.CFrame.Position, (targetPart.Position - camera.CFrame.Position).Unit * worldDistance, raycastParams)
                    if not rayResult or rayResult.Instance:IsDescendantOf(plr.Character) then
                        if worldDistance < closestDistance then
                            closestPlayer = plr
                            closestDistance = worldDistance
                        end
                    end
                end
            end
        end
        return closestPlayer
    end

    local function toggleAimbot()
        aimbotConfig.enabled = not aimbotConfig.enabled
        showTempMessage("Aimbot: " .. (aimbotConfig.enabled and "Activado" or "Desactivado"))
        updateFOVCircle()
        if aimbotConfig.enabled then
            soundOn:Play()
            aimbotConnection = runService.RenderStepped:Connect(function()
                if not aimbotConfig.enabled or not player.Character or not player.Character.HumanoidRootPart then
                    currentTarget = nil
                    updateAimLine(nil)
                    return
                end

                if currentTarget and currentTarget.Character and currentTarget.Character:FindFirstChild("Humanoid") and 
                   currentTarget.Character.Humanoid.Health > 0 and currentTarget.Character:FindFirstChild(aimbotConfig.part) then
                    local _, onScreen = camera:WorldToScreenPoint(currentTarget.Character[aimbotConfig.part].Position)
                    if not onScreen then currentTarget = nil end
                else
                    currentTarget = nil
                end

                if not currentTarget then
                    currentTarget = getBestTarget()
                    if currentTarget then
                        currentTarget.Character.Humanoid.Died:Connect(function()
                            if currentTarget == players:GetPlayerFromCharacter(currentTarget.Character) then
                                killCount = killCount + 1
                                killCounterLabel.Text = "Bajas: " .. killCount
                                showHitmarker()
                                currentTarget = nil
                                updateAimLine(nil)
                            end
                        end)
                    end
                end

                if currentTarget and currentTarget.Character and currentTarget.Character:FindFirstChild(aimbotConfig.part) then
                    local targetPos = currentTarget.Character[aimbotConfig.part].Position
                    if aimbotConfig.prediction then
                        local velocity = currentTarget.Character.HumanoidRootPart.Velocity
                        local ping = game:GetService("Stats").Network.ServerStatsItem["Ping"]:GetValue() / 1000
                        targetPos = targetPos + velocity * (ping + 0.15)
                    end
                    updateAimLine(currentTarget)

                    local currentLook = camera.CFrame.LookVector
                    local targetLook = (targetPos - camera.CFrame.Position).Unit
                    local newLook = currentLook:Lerp(targetLook, aimbotConfig.smoothness)
                    camera.CFrame = CFrame.new(camera.CFrame.Position, camera.CFrame.Position + newLook)

                    if aimbotConfig.triggerbot then
                        mouse1click()
                    end
                else
                    updateAimLine(nil)
                end
            end)
        else
            soundOff:Play()
            fovCircle.Visible = false
            aimLine.Enabled = false
            currentTarget = nil
            if aimbotConnection then aimbotConnection:Disconnect() end
        end
    end

    -- Fake Lag Logic
    local fakeLagConfig = {enabled = false, frozenPositions = {}}
    local fakeLagConnection

    local function toggleFakeLag()
        fakeLagConfig.enabled = not fakeLagConfig.enabled
        showTempMessage("Fake Lag: " .. (fakeLagConfig.enabled and "Activado" or "Desactivado"))
        if fakeLagConfig.enabled then
            soundOn:Play()
            fakeLagConnection = runService.RenderStepped:Connect(function()
                if not player.Character or not player.Character.HumanoidRootPart then return end
                for _, plr in ipairs(players:GetPlayers()) do
                    if plr ~= player and plr.Character and plr.Character.HumanoidRootPart then
                        if not fakeLagConfig.frozenPositions[plr] then
                            fakeLagConfig.frozenPositions[plr] = plr.Character.HumanoidRootPart.CFrame
                        end
                        plr.Character.HumanoidRootPart.CFrame = fakeLagConfig.frozenPositions[plr]
                    end
                end
            end)
            spawn(function()
                while fakeLagConfig.enabled do
                    wait(2)
                    fakeLagConfig.frozenPositions = {}
                end
            end)
        else
            soundOff:Play()
            if fakeLagConnection then fakeLagConnection:Disconnect() end
            fakeLagConfig.frozenPositions = {}
            for _, plr in ipairs(players:GetPlayers()) do
                if plr ~= player and plr.Character and plr.Character.HumanoidRootPart then
                    plr.Character.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame
                end
            end
        end
    end

    -- Ghost Hack Logic
    local ghostHackConfig = {enabled = false, clone = nil}
    local ghostHackConnection

    local function toggleGhostHack()
        ghostHackConfig.enabled = not ghostHackConfig.enabled
        showTempMessage("Ghost Hack: " .. (ghostHackConfig.enabled and "Activado" or "Desactivado"))
        if ghostHackConfig.enabled then
            soundOn:Play()
            if player.Character and player.Character.HumanoidRootPart then
                ghostHackConfig.clone = player.Character:Clone()
                ghostHackConfig.clone.Parent = workspace
                ghostHackConfig.clone.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame
                for _, part in pairs(ghostHackConfig.clone:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.Anchored = true
                    end
                end
                player.Character.HumanoidRootPart.Transparency = 0.5
                ghostHackConnection = runService.RenderStepped:Connect(function()
                    if not player.Character or not player.Character.HumanoidRootPart then return end
                    if ghostHackConfig.clone then
                        ghostHackConfig.clone.HumanoidRootPart.CFrame = ghostHackConfig.clone.HumanoidRootPart.Position
                    end
                    toggleGhostHack()
                end
            )
        else
            soundOff:Play()
                if ghostHackConfig.clone then
                    ghostHackConfig.clone:Destroy()
                    ghostHackConfig.clone = nil
                end
                if player.Character then
                    player.Character.HumanoidRootPart.Transparency = 0
                end
                if ghostHackConnection then
                    ghostHackConnection:Disconnect()
                end
            end
        end

    -- NoClip Logic
    local noClip = false
    local noClipConnection
    local function toggleNoClip()
        noClip = not noClip
        showTempMessage("NoClip: " .. (noClip and "Activado" or "Desactivado"))
        if noClip then
            soundOn:Play()
            noClipConnection = runService.Stepped:Connect(function()
                if player.Character then
                    for _, part in ipairs(player.Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            )
        else
            soundOff:Play()
            if noClipConnection then
                noClipConnection:Disconnect()
            end
            if player.Character then
                for _, part in ipairs(player.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = true
                    end
                end
            end
        end
    -- Infinite Jump
    local infiniteJump = false
    local jumpConnection
    local function toggleInfiniteJump()
        infiniteJump = not infiniteJump
        showTempMessage("Infinite Jump: " .. (infiniteJump and " "Activado" or "Desactivado"))
        if infiniteJump then
            soundOn:Play()
                jumpConnection = userInputService.JumpRequest:Connect(function()
                    if player.Character then
                        player.Character.HumanoidRootPart:FindFirstChildOfClass("Humanoid")):ChangeState(Enum.HumanoidStateType.Jumping)
                    end
                end
            else
                soundOff:Play()
                if jumpConnection then
                    jumpConnection:Disconnect()
                end
            end
        end

    -- Auto-Farm Logic
    local autoFarm = false
    local autoFarmConnection
    local function toggleAutoFarm()
        autoFarm = not autoFarm
        showTempMessage("Auto-Farm" .. (autoFarm and "Activado": "Activado" or "Desactivado"))
        if autoFarm then
            soundOn:Play()
                autoFarmConnection = runService.Heartbeat:Connect(function()
                    showTempMessage("Auto-Farm activo")
                end
            )
            else
                soundOff:Play()
                if autoFarmConnection then
                    autoFarmConnection:Disconnect()
                end
            end
        end

    -- God Mode
    local godMode = false
    local function toggleGodMode()
        godMode = not godMode
        showTempMessage("God Mode: " .. (godMode and "Activado" or "Desactivado"))
        if godMode then
            soundOn:Play()
            if player.Character and player.Character.Humanoid then
                player.Character.Humanoid.MaxHealth = math.hugehuge
                player.Character.Humanoid.Health = math.huge
            end
        else
            soundOff:Play()
            if player.Character and player.Character.Humanoid then
                player.Character.Humanoid.MaxHealth = 100
                player.Character.Humanoid.Health = 100
            end
        end
        end
    )

    -- Server Hop
    local function serverHop()
        showTempMessage("Buscando servidor...")
        local servers = {}
        local cursor = ""
        local placeId = game.PlaceId
        local success, result = pcall(function()
            while true do
                local response = httpService:GetAsync(string.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Asc&limit=50&cursor=%s", placeId, cursor))
                local data = httpService:JSONDecode(response)
                for _, server in ipairs(data.data) do
                    if server.playing < server.maxPlayers then
                        table.insert(servers, server.id)
                    end
                end
                cursor = data.nextPageCursor
                if not cursor then break end
            end
        end)
        if success and #servers > 0 then
            showTempMessage("Cambiando servidor...")
            game:GetService("TeleportService"):TeleportToPlaceInstance(placeId, servers[math.random(1, #servers)])
        else
            showTempMessage("Error: No hay servidores disponibles.")
        end
    end

    -- Rejoin
    local function rejoin()
        showTempMessage("Reuniendo al servidor...")
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId)
    end)

    -- FPS Unlock
    local function unlockFPS()
        if setfpscap then
            setfpscap(999)
            showTempMessage("FPS Unlocker activado")
        else
            showTempMessage("FPS Unlocker no soportado")
        end
    end

    -- Chat Spoofer
    local function chatSpoofer(message, spoofedPlayer)
        showTempMessage("Enviando mensaje como " .. spoofedPlayer.Name)
    end)

    -- Fly Controls
    flyControlsFrame = Instance.new("Frame", screenGui)
    flyControlsFrame.Size = UDim2.new(0, 200, 0, 200)
    flyControlsFrame.Position = UDim2.new(0, 10, 0.5, -100)
    flyControlsFrame.BackgroundTransparency = 1
    flyControlsFrame.Visible = false

    local flyMoveDirection = Vector3.new(0, 0, 0)
    local function addFlyButton(text, size, pos, direction)
        local button = Instance.new("TextButton", flyControlsFrame)
        button.Size = size
        button.Position = pos
        button.BackgroundColor3 = Color3.fromRGB(50, 50, 255)
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.Font = Enum.Font.SourceSansBold
        button.TextSize = 16
        button.Text = text
        button.ZIndex = 1001
        local corner = Instance.new("UICorner", button)
        corner.CornerRadius = UDim.new(0, 6)
        button.MouseButton1Down:Connect(function()
            flyMoveDirection = flyMoveDirection + direction
        end)
        button.MouseButton1Up:Connect(function()
            flyMoveDirection = flyMoveDirection - direction
        end)
        button.TouchTap:Connect(function()
            flyMoveDirection = flyMoveDirection + direction
            wait(0.1)
            flyMoveDirection = flyMoveDirection - direction
        end)
        return button
    end

    addFlyButton("↑", UDim2.new(0, 60, 0, 60), UDim2.new(0.35, 0, 0, 0), Vector3.new(0, 1, 0))
    addFlyButton("↓", UDim2.new(0, 60, 0, 60), UDim2.new(0.35, 0, 0.7, 0), Vector3.new(0, -1, 0))
    addFlyButton("W", UDim2.new(0, 60, 0, 60), UDim2.new(0.35, 0, 0.35, 0), Vector3.new(0, 0, -1))
    addFlyButton("S", UDim2.new(0, 60, 0, 60), UDim2.new(0.35, 0, 0.50, 0), Vector3.new(0, 0, 1))
    addFlyButton("A", UDim2.new(0, 60, 0, 60), UDim2.new(0, 0, 0.35, 0), Vector3.new(-1, 0, 0))
    addFlyButton("D", UDim2.new(0, 60, 0, 60), UDim2.new(0.7, 0, 0.35, 0), Vector3.new(1, 0, 0))

    local function updateFlyDirection()
        if flyConfig.enabled and bodyVelocity and flyMoveDirection.Magnitude > 0 then
            bodyVelocity.Velocity = player.Character.HumanoidRootPart.CFrame:VectorToWorldSpace(flyMoveDirection.Unit * flyConfig.speed)
        elseif bodyVelocity then
            bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        end
    end

    flyConnection = runService.RenderStepped:Connect(function()
        if flyConfig.enabled then
            updateFlyDirection()
        end
    end)

    -- Auto-Aim Toggle Key
    userInputService.InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.LeftShift then
            toggleAimbot()
        end
    end)

    -- Tab Content
    local colors = {
        Color3.fromRGB(255, 0, 0), Color3.fromRGB(255, 127, 0), Color3.fromRGB(255, 255, 0),
        Color3.fromRGB(0, 255, 0), Color3.fromRGB(0, 0, 255), Color3.fromRGB(75, 0, 130),
        Color3.fromRGB(238, 130, 238)
    }

    local function addButton(parent, text, size, pos, callback)
        local button = Instance.new("TextButton", parent)
        button.Size = size
        button.Position = pos
        button.BackgroundColor3 = Color3.fromRGB(20, 20, 50)
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.Font = Enum.Font.SourceSans
        button.TextSize = 16
        button.Text = text
        button.ZIndex = 3
        local corner = Instance.new("UICorner", button)
        corner.CornerRadius = UDim.new(0, 6)
        button.Activated:Connect(callback)
        return button
    end

    local function addLabel(parent, text, pos)
        local label = Instance.new("TextLabel", parent)
        label.Size = UDim2.new(1, 0, 0, 20)
        label.Position = pos
        label.BackgroundTransparency = 1
        label.TextColor3 = Color3.fromRGB(255, 255, 255)
        label.Font = Enum.Font.SourceSans
        label.TextSize = 14
        label.Text = text
        label.ZIndex = 3
        return label
    end

    local function createTabContent(tabName)
        for _, child in ipairs(contentFrame:GetChildren()) do
            if child:IsA("GuiObject") then
                child.Destroy()
            end
        end
        contentFrame.CanvasPosition = Vector2.new(0, 0)
        local contentHeight = 0

        if tabName == "Main" then
            addLabel(contentFrame, "Infinix Cheats v2.1", UDim2.new(0, 0, 0, 0))
            addLabel(contentFrame, "Creador: Zxcx", UDim2.new(0, 0, 0, 0.1, 0))
            addLabel(contentFrame, "Desarrollador: Grok (xAI)", UDim2.new(0, 0, 0, 0.2, 0)
            addLabel(contentFrame, "Gracias por usar Infinix!", UDim2.new(0, 0, 0, 0.3))
            contentHeight = 0.4

        elseif tabName == "Básico" then
            boostFrame.Visible = true
            local flyToggle = addButton(contentFrame, flyConfig.enabled and "Desactivar Fly" or "Activar Fly", UDim2.new(0, 0.8, 0, 0, 40), UDim2.new(0, 0.1, 0, 0, 0), function()
                toggleFly()
                flyToggle.Text = flyConfig.enabled and "Desactivar Fly" or "Activar Fly"
            end)

            local flySpeedLabel = addLabel(contentFrame, "Velocidad de Fly: " .. flyConfig.speed, UDim2.new(0, 0, 0, 0.15, 0))
            addButton(contentFrame, "+", UDim2.new(0, 0.35, 0, 0, 30), UDim2.new(0, 0.1, 0, 0.25, 0), function()
                flyConfig.speed = math.clamp(flySpeed.speed + 10, 10, 200)
                speedLabel.Text = "Velocidad de Fly: " .. flyConfig.speed
            end)
            addButton(contentFrame, "-", UDim2.new(0, 0.35, 0, 30), UDim2.new(0, 0.55, 0, 0.25, 0), function()
                flyConfig.speed = math.clamp(flySpeed.speed - 10, 10, 200)
                speedLabel.Text = "Velocidad de Fly: " .. flyConfig.speed
            end)

            local upDownLabel = addLabel(contentFrame, "Distancia Up/Down: " .. upDownDistance, UDim2.new(0, 0, 0, 0.4, 0))
            addButton(contentFrame, "Subir", UDim2.new(0, 0.35, 0, 40), UDim2.new(0, 0.1, 0, 0.5, 0), function() moveVertical(1) end)
            addButton(contentFrame, "Bajar", UDim2.new(0, 0.35, 0, 40), UDim2.new(0, 0.55, 0, 0.5, 0), function() moveVertical(-1) end)
            addButton(contentFrame, "+", UDim2.new(0, 0.35, 0, 30), UDim2.new(0, 0.1, 0, 0.65, 0), function()
                upDownDistance = math.clamp(upDownDistance + 10, 5, 100)
                upDownLabel.Text = "Distancia Up/Down: " .. upDownDistance
            end)
            addButton(contentFrame, "-", UDim2.new(0, 0.35, 0, 30), UDim2.new(0, 0.55, 0, 0.65, 0), function()
                upDownDistance = math.clamp(upDownDistance - 5, 5, 100)
                upDownLabel.Text = "Distancia Up/Down: " .. upDownDistance
            end)

            local speedLabel = addLabel(contentFrame, "Velocidad: " .. walkSpeed, UDim2.new(0, 0, 0, 0.8, 0))
            addButton(contentFrame, "+", UDim2.new(0, 0.35, 0, 0, 30), UDim2.new(0, 0.1, 0, 0.9, 0), function()
                updateSpeed(walkSpeed + 10)
                speedLabel.Text = "Velocidad: " .. walkSpeed
            end)
            addButton(contentFrame, "-", UDim2.new(0, 0.35, 0, 30), UDim2.new(0, 0.55, 0, 0.9, 0), function()
                updateSpeed(walkSpeed - 10)
                speedLabel.Text = "Velocidad: " .. walkSpeed
            end)
            contentHeight = 1.2

        elseif tabName == "Combate" then
            local aimbotToggle = addButton(contentFrame, aimbotConfig.enabled and "Desactivar Aimbot" or "Activar Aimbot", UDim2.new(0, 0.8, 0, 0, 40), UDim2.new(0, 0.1, 0, 0, 0), function()
                toggleAimbot()
                aimbotToggle.Text = aimbotConfig.enabled and "Desactivar Aimbot" or "Activar Aimbot"
            end)

            local aimPartLabel = addLabel(contentFrame, "Parte a Apuntar: " .. aimbotConfig.part, UDim2.new(0, 0, 0, 0.15, 0))
            addButton(contentFrame, "Cabeza", UDim2.new(0, 0.35, 0, 30), UDim2.new(0, 0.1, 0, 0.25, 0), function()
                aimbotConfig.part = "Head"
                aimPartLabel.Text = "Parte a Apuntar: " .. aimbotConfig.part
            end)
            addButton(contentFrame, "Torso", UDim2.new(0, 0.35, 0, 30), UDim2.new(0, 0.55, 0, 0.25, 0), function()
                aimbotConfig.part = "HumanoidRootPart"
                aimPartLabel.Text = "Parte a Apuntar: " .. aimbotConfig.part
            end)

            local fovLabel = addLabel(contentFrame, "FOV: " .. aimbotConfig.fov, UDim2.new(0, 0, 0, 0.4, 0))
            addButton(contentFrame, "+", UDim2.new(0, 0.35, 0, 30), UDim2.new(0, 0.1, 0, 0.5, 0), function()
                aimbotConfig.fov = math.clamp(aimbotConfig.fov + 10, 50, 300)
                fovLabel.Text = "FOV: " .. aimbotConfig.fov
                updateFOVCircle()
            end)
            addButton(contentFrame, "-", UDim2.new(0, 0.35, 0, 30), UDim2.new(0, 0.55, 0, 0.5, 0), function()
                aimbotConfig.fov = math.clamp(aimbotConfig.fov - 10, 50, 300)
                fovLabel.Text = "FOV: " .. aimbotConfig.fov
                updateFOVCircle()
            end)

            local predictionToggle = addButton(contentFrame, aimbotConfig.prediction and "Desactivar Predicción" or "Activar Predicción", UDim2.new(0, 0.8, 0, 40), UDim2.new(0, 0.1, 0, 0.65, 0), function()
                aimbotConfig.prediction = not aimbotConfig.prediction
                predictionToggle.Text = aimbotConfig.prediction and "Desactivar Predicción" or "Activar Predicción"
                showTempMessage("Predicción: " .. (aimbotConfig.prediction and "Activada" or "Desactivada"))
            end)

            local triggerbotToggle = addButton(contentFrame, aimbotConfig.triggerbot and "Desactivar Triggerbot" or "Activar Triggerbot", UDim2.new(0, 0.8, 0, 40), UDim2.new(0, 0.1, 0, 0.8, 0), function()
                aimbotConfig.triggerbot = not aimbotConfig.triggerbot
                triggerbotToggle.Text = aimbotConfig.triggerbot and "Desactivar Triggerbot" or "Activar Triggerbot"
                showTempMessage("Triggerbot: " .. (aimbotConfig.triggerbot and "Activado" or "Desactivado"))
            end)

            local smoothnessLabel = addLabel(contentFrame, "Suavizado: " .. string.format("%.1f", aimbotConfig.smoothness), UDim2.new(0, 0, 0, 0.95, 0))
            addButton(contentFrame, "+", UDim2.new(0, 0.35, 0, 30), UDim2.new(0, 0.1, 0, 1.05, 0), function()
                aimbotConfig.smoothness = math.clamp(aimbotConfig.smoothness + 0.1, 0, 1)
                smoothnessLabel.Text = "Suavizado: " .. string.format("%.1f", aimbotConfig.smoothness)
            end)
            addButton(contentFrame, "-", UDim2.new(0, 0.35, 0, 30), UDim2.new(0, 0.55, 0, 1.05, 0), function()
                aimbotConfig.smoothness = math.clamp(aimbotConfig.smoothness - 0.1, 0, 1)
                smoothnessLabel.Text = "Suavizado: " .. string.format("%.1f", aimbotConfig.smoothness)
            end)
            contentHeight = 1.3

        elseif tabName == "Información" then
            local espToggle = addButton(contentFrame, espConfig.enabled and "Desactivar ESP" or "Activar ESP", UDim2.new(0, 0.8, 0, 40), UDim2.new(0, 0.1, 0, 0, 0), function()
                toggleESP()
                espToggle.Text = espConfig.enabled and "Desactivar ESP" or "Activar ESP"
            end)
            local boxToggle = addButton(contentFrame, espConfig.box and "Desactivar Box" or "Activar Box", UDim2.new(0, 0.8, 0, 40), UDim2.new(0, 0.1, 0, 0.15, 0), function()
                espConfig.box = not espConfig.box
                boxToggle.Text = espConfig.box and "Desactivar Box" or "Activar Box"
                if espConfig.box then soundOn:Play() else soundOff:Play() end
                refreshESP()
            end)
            local linesToggle = addButton(contentFrame, espConfig.lines and "Desactivar Lines" or "Activar Lines", UDim2.new(0, 0.8, 0, 40), UDim2.new(0, 0.1, 0, 0.3, 0), function()
                espConfig.lines = not espConfig.lines
                linesToggle.Text = espConfig.lines and "Desactivar Lines" or "Activar Lines"
                if espConfig.lines then soundOn:Play() else soundOff:Play() end
                refreshESP()
            end)

            local outlineColorLabel = addLabel(contentFrame, "Color del Borde", UDim2.new(0, 0, 0, 0.45))
            for i, color in ipairs(colors) do
                local x = 0.1 + ((i-1) % 4) * 0.12
                local y = 0.55 + math.floor((i-1) / 4) * 0.15
                local button = addButton(contentFrame, "", UDim2.new(0, 30, 0, 0, 30), UDim2.new(0, x, 0, y, 0), function()
                    espConfig.outlineColor3 = color
                    refreshESP()
                end)
                button.BackgroundColor3 = color
            end

            local fillToggle = addButton(contentFrame, espConfig.fillEnabled and "Relleno: On" or "Relleno: Off", UDim2.new(0, 0.2, 0, 0, 30), UDim2.new(0, 0.1, 0, 0.85, 0), function()
                espConfig.fillEnabled = not espConfig.fillEnabled
                fillToggle.Text = espConfig.fillEnabled and "Relleno: On" or "Relleno: Off"
                if espConfig.fillEnabled then soundOn:Play() else soundOff:Play() end
                refreshESP()
            end)

            local fillColorLabel = addLabel(contentFrame, "Color del Relleno", UDim2.new(0, 0, 0, 1.0, 0))
            for i, color in ipairs(colors) do
                local x = 0.1 + ((i-1) % 4) * 0.12
                local y = 1.1 + math.floor((i-1) / 4) * 0.15
                local button = addButton(contentFrame, "", UDim2.new(0, 30, 0, 0, 30), UDim2.new(0, x, 0, y, 0), function()
                    espConfig.fillColor3 = color
                    refreshESP()
                end)
                button.BackgroundColor3 = color
            end

            local serverInfoLabel = addLabel(contentFrame, "Cargando info...", UDim2.new(0, 0, 0, 1.4, 0))
            spawn(function()
                while contentFrame.Parent do
                    local health = player.Character and player.Character.Humanoid and math.floor(player.Character.Humanoid.Health) or 0
                    local maxHealth = player.Character and player.Character.Humanoid and math.floor(player.Character.Humanoid.MaxHealth) or 100
                    serverInfoLabel.Text = string.format("Jugador: %s | Salud: %d/%d | Bajas: %d | Servidor: %s | Ping: %.d", 
                        player.Name, health, maxHealth, killCount, game.JobId, game:GetService("Stats").Network.ServerStatsItem["Ping"]:GetValue())
                    wait(1)
                end
            )
            contentHeight = 1.6

        elseif tabName == "Avanzado" then
            local noClipToggle = addButton(contentFrame, noClip and "Ocultar NoClip" or "Activar NoClip", UDim2.new(0, 0, 0.8, 0, 40), UDim2.new(0, 0.1, 0, 0, 0, 0), function()
                toggleNoClip()
                noClipToggle.Text = noClip and "Ocultar NoClip" or "Activar NoClip"
            end)

            local infiniteJumpToggle = addButton(contentFrame, infiniteJump and "Ocultar Infinite Jump" or "Activar Infinite Jump", UDim2.new(0, 0, 0.8, 0, U40), UDim2.new(0, 0.1, 0, 0.15, 0), function()
                toggleInfiniteJump()
                infiniteJumpToggle.Text = infiniteJump and "Ocultar Infinite Jump" or "Activar Infinite Jump"
            end)

            local autoFarmToggle = addButton(contentFrame, autoFarm and "Ocultar Auto-Farm" or "Activar Auto-Farm", UDim2.new(0, 0, 0.8, 0, U40), UDim2.new(0, 0.1, 0, 0.3, 0), function()
                toggleAutoFarm()
                autoFarmToggle.Text = autoFarm and "Ocultar Auto-Farm" or "Activar Auto-Farm"
            end)

            local godModeToggle = addButton(contentFrame, godMode and "Ocultar God Mode" or "Activar God Mode", UDim2.new(0, 0, 0.8, 0, U40), UDim2.new(0, 0.1, 0, 0.45, 0), function()
                toggleGodMode()
                godModeToggle.Text = godMode and "Ocultar God Mode" or "Activar God Mode"
            end)

            local fakeLagToggle = addButton(contentFrame, fakeLagConfig.enabled and "Desactivar Fake Lag" or "Activar Fake Lag", UDim2.new(0, 0, 0.8, 0, U40), UDim2.new(0, 0.1, 0, 0.6, 0), function()
                toggleFakeLag()
                fakeLagToggle.Text = fakeLagConfig.enabled and "Desactivar Fake Lag" or "Activar Fake Lag"
            end)

            local ghostHackToggle = addButton(contentFrame, ghostHackConfig.enabled and "Desactivar Ghost Hack" or "Activar Ghost Hack", UDim2.new(0, 0, 0.8, 0, U40), UDim2.new(0, 0.1, 0, 0.75, 0), function()
                toggleGhostHack()
                ghostHackToggle.Text = ghostHackConfig.enabled and "Desactivar Ghost Hack" or "Activar Ghost Hack"
            end)
            contentHeight = 0.9

        elseif tabName == "Otros" then
            addButton(contentFrame, "Server Hop", UDim2.new(0, 0.8, 0, 40), UDim2.new(0, 0.1, 0, 0, 0), serverHop)
            addButton(contentFrame, "Rejoin", UDim2.new(0, 0.8, 0, 40), UDim2.new(0, 0.1, 0, 0.15, 0), rejoin)
            addButton(contentFrame, "FPS Unlocker", UDim2.new(0, 0.8, 0, 40), UDim2.new(0, 0.1, 0, 0.3, 0), unlockFPS)
            addButton(contentFrame, "Chat Spoofer", UDim2.new(0, 0.8, 0, 40), UDim2.new(0, 0.1, 0, 0.45, 0), function()
                chatSpoofer("Mensaje de prueba", player)
            end)
            contentHeight = 0.6

        elseif tabName == "Visuales" then
            local fovCircleToggle = addButton(contentFrame, aimbotConfig.showFOV and "Ocultar Círculo FOV" or "Mostrar Círculo FOV", UDim2.new(0, 0.8, 0, 40), UDim2.new(0, 0.1, 0, 0, 0), function()
                aimbotConfig.showFOV = not aimbotConfig.showFOV
                fovCircleToggle.Text = aimbotConfig.showFOV and "Ocultar Círculo FOV" or "Mostrar Círculo FOV"
                updateFOVCircle()
                showTempMessage("Círculo FOV: " .. (aimbotConfig.showFOV and "Visible" or "Oculto"))
            end)
            local killCounterToggle = addButton(contentFrame, killCounterLabel.Visible and "Ocultar Contador de Bajas" or "Mostrar Contador de Bajas", UDim2.new(0, 0.8, 0, 40), UDim2.new(0, 0.1, 0, 0.15, 0), function()
                killCounterLabel.Visible = not killCounterLabel.Visible
                killCounterToggle.Text = killCounterLabel.Visible and "Ocultar Contador de Bajas" or "Mostrar Contador de Bajas"
                showTempMessage("Contador de Bajas: " .. (killCounterLabel.Visible and "Visible" or "Oculto"))
            end)
            contentHeight = 0.3
        end
        contentFrame.CanvasSize = UDim2.new(0, 0, contentHeight, 0)
    end

    for tabName, button in pairs(tabButtons) do
        button.Activated:Connect(function()
            currentTab = tabName
            createTabContent(tabName)
            for _, btn in pairs(tabButtons) do
                btn.BackgroundColor3 = Color3.fromRGB(20, 20, 50)
            end
            button.BackgroundColor3 = Color3.fromRGB(40, 40, 70)
        end)
    end

    local isMinimized = false
    local function toggleMinimize()
        isMinimized = not isMinimized
        if isMinimized then
            frame.Size = UDim2.new(0, frame.Size.X.Offset, 0, 40)
            tabFrame.Visible = false
            contentFrame.Visible = false
            minimizeButton.Text = "+"
            resizeHandle.Visible = false
            showTempMessage("Menú minimizado")
        else
            frame.Size = UDim2.new(0, frame.Size.X.Offset, 0, 350)
            tabFrame.Visible = true
            contentFrame.Visible = true
            minimizeButton.Text = "-"
            resizeHandle.Visible = true
            if currentTab then createTabContent(currentTab) end
            showTempMessage("Menú restaurado")
        end
    end

    local function toggleMenu()
        frame.Visible = not frame.Visible
        showTempMessage(frame.Visible and "Menú abierto" or "Menú cerrado")
        if frame.Visible and currentTab then createTabContent(currentTab) end
    end

    toggleButton.Activated:Connect(toggleMenu)
    closeButton.Activated:Connect(function()
        showTempMessage("Cerrando Infinix Cheats...")
        screenGui:Destroy()
        if espConnection then espConnection:Disconnect() end
        if flyConnection then flyConnection:Disconnect() end
        if aimbotConnection then aimbotConnection:Disconnect() end
        if noClipConnection then noClipConnection:Disconnect() end
        if jumpConnection then jumpConnection:Disconnect() end
        if autoFarmConnection then autoFarmConnection:Disconnect() end
        if fakeLagConnection then fakeLagConnection:Disconnect() end
        if ghostHackConnection then ghostHackConnection:Disconnect() end
    end)
    minimizeButton.Activated:Connect(toggleMinimize)

    local resizing = false
    local lastMousePos = Vector2.new(0, 0)
    resizeHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            resizing = true
            lastMousePos = input.Position
        end
    end)
    userInputService.InputChanged:Connect(function(input)
        if resizing and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = Vector2.new(input.Position.X, input.Position.Y) - lastMousePos
            frame.Size = UDim2.new(0, math.clamp(frame.Size.X.Offset + delta.X, 200, 600), 0, math.clamp(frame.Size.Y.Offset + delta.Y, 150, 500))
            lastMousePos = input.Position
        end
    end)
    userInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            resizing = false
        end
    end)

    tabButtons["Main"].BackgroundColor3 = Color3.fromRGB(40, 40, 70)
    currentTab = "Main"
    createTabContent("Main")
end)

if not success then
    warn("Error al iniciar Infinix Cheats: " .. errorMsg)
end