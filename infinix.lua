local success, errorMsg = pcall(function()
    print("Iniciando Infinix Cheats v1.7...")
    local player = game.Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui", 10)
    local userInputService = game:GetService("UserInputService")
    local runService = game:GetService("RunService")
    local tweenService = game:GetService("TweenService")
    local httpService = game:GetService("HttpService")
    if not playerGui then
        error("PlayerGui no encontrado")
    end
    print("PlayerGui encontrado")

    -- Cachear referencias para optimización
    local camera = game.Workspace.CurrentCamera
    local players = game:GetService("Players")

    -- Crear ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "InfinixCheats"
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.Parent = playerGui
    print("ScreenGui creado")

    -- Crear sonidos
    local soundOn = Instance.new("Sound")
    soundOn.SoundId = "rbxassetid://911289071"
    soundOn.Volume = 0.3
    soundOn.Parent = screenGui
    local soundOff = Instance.new("Sound")
    soundOff.SoundId = "rbxassetid://911289085"
    soundOff.Volume = 0.3
    soundOff.Parent = screenGui
    print("Sonidos On/Off creados")

    -- Círculo de FOV
    local fovCircle = Instance.new("Frame")
    fovCircle.Size = UDim2.new(0, 100, 0, 100)
    fovCircle.Position = UDim2.new(0.5, 0, 0.5, 0)
    fovCircle.AnchorPoint = Vector2.new(0.5, 0.5)
    fovCircle.BackgroundColor3 = Color3.fromRGB(128, 128, 128) -- Plomo
    fovCircle.BackgroundTransparency = 0.7
    fovCircle.BorderSizePixel = 0
    fovCircle.ZIndex = 1000
    fovCircle.Visible = false
    fovCircle.Parent = screenGui
    local fovCircleCorner = Instance.new("UICorner")
    fovCircleCorner.CornerRadius = UDim.new(0.5, 0)
    fovCircleCorner.Parent = fovCircle
    print("FOV Circle creado")

    -- *** Nuevo: Línea Roja para Aimbot ***
    local aimLine = Instance.new("Beam")
    aimLine.Color = ColorSequence.new(Color3.fromRGB(255, 0, 0))
    aimLine.Width0 = 0.3
    aimLine.Width1 = 0.3
    aimLine.Transparency = NumberSequence.new(0)
    aimLine.Enabled = false
    aimLine.Parent = screenGui
    local aimAttach0 = Instance.new("Attachment") -- Jugador
    local aimAttach1 = Instance.new("Attachment") -- Enemigo
    aimLine.Attachment0 = aimAttach0
    aimLine.Attachment1 = aimAttach1
    print("Línea Roja creada")

    -- Mensaje temporal
    local function showTempMessage(text)
        local tempLabel = Instance.new("TextLabel")
        tempLabel.Size = UDim2.new(0, 300, 0, 50)
        tempLabel.Position = UDim2.new(0.5, -150, 0.5, -25)
        tempLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
        tempLabel.BackgroundTransparency = 0.5
        tempLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        tempLabel.Font = Enum.Font.SourceSansBold
        tempLabel.TextSize = 16
        tempLabel.Text = text
        tempLabel.ZIndex = 1001
        tempLabel.Parent = screenGui
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 10)
        corner.Parent = tempLabel
        spawn(function()
            wait(3)
            local tween = tweenService:Create(tempLabel, TweenInfo.new(0.5), {BackgroundTransparency = 1, TextTransparency = 1})
            tween:Play()
            tween.Completed:Wait()
            tempLabel:Destroy()
        end)
        print("Mensaje temporal: " .. text)
    end

    -- Pantalla de Clave
    local keyFrame = Instance.new("Frame")
    keyFrame.Size = UDim2.new(0, 300, 0, 200)
    keyFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
    keyFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
    keyFrame.BackgroundTransparency = 0.5
    keyFrame.BorderSizePixel = 0
    keyFrame.ZIndex = 1001
    keyFrame.Parent = screenGui
    local keyCorner = Instance.new("UICorner")
    keyCorner.CornerRadius = UDim.new(0, 10)
    keyCorner.Parent = keyFrame
    print("Key Frame creado")

    local keyTitle = Instance.new("TextLabel")
    keyTitle.Size = UDim2.new(1, 0, 0, 30)
    keyTitle.Position = UDim2.new(0, 0, 0, 0)
    keyTitle.BackgroundTransparency = 1
    keyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    keyTitle.Font = Enum.Font.SourceSansBold
    keyTitle.TextSize = 18
    keyTitle.Text = "Infinix Cheats - Ingresar Clave"
    keyTitle.ZIndex = 1002
    keyTitle.Parent = keyFrame
    print("Key Title creado")

    local keyInput = Instance.new("TextBox")
    keyInput.Size = UDim2.new(0.8, 0, 0, 40)
    keyInput.Position = UDim2.new(0.1, 0, 0.3, 0)
    keyInput.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    keyInput.TextColor3 = Color3.fromRGB(0, 0, 0)
    keyInput.Font = Enum.Font.SourceSans
    keyInput.TextSize = 16
    keyInput.PlaceholderText = "Ingresa la clave..."
    keyInput.ZIndex = 1002
    keyInput.Parent = keyFrame
    local inputCorner = Instance.new("UICorner")
    inputCorner.CornerRadius = UDim.new(0, 6)
    inputCorner.Parent = keyInput
    print("Key Input creado")

    local submitButton = Instance.new("TextButton")
    submitButton.Size = UDim2.new(0.8, 0, 0, 40)
    submitButton.Position = UDim2.new(0.1, 0, 0.6, 0)
    submitButton.BackgroundColor3 = Color3.fromRGB(50, 50, 255)
    submitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    submitButton.Font = Enum.Font.SourceSansBold
    submitButton.TextSize = 16
    submitButton.Text = "Enviar"
    submitButton.ZIndex = 1002
    submitButton.Parent = keyFrame
    local submitCorner = Instance.new("UICorner")
    submitCorner.CornerRadius = UDim.new(0, 6)
    submitCorner.Parent = submitButton
    print("Submit Button creado")

    local errorLabel = Instance.new("TextLabel")
    errorLabel.Size = UDim2.new(1, 0, 0, 20)
    errorLabel.Position = UDim2.new(0, 0, 0.85, 0)
    errorLabel.BackgroundTransparency = 1
    errorLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
    errorLabel.Font = Enum.Font.SourceSans
    errorLabel.TextSize = 14
    errorLabel.Text = ""
    errorLabel.ZIndex = 1002
    errorLabel.Parent = keyFrame
    print("Error Label creado")

    -- Animación de entrada para la pantalla de clave
    local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
    keyFrame.Size = UDim2.new(0, 0, 0, 0)
    local tween = tweenService:Create(keyFrame, tweenInfo, {Size = UDim2.new(0, 300, 0, 200)})
    tween:Play()
    print("Animación de clave iniciada")

    -- Pantalla de Bienvenida
    local welcomeFrame = Instance.new("Frame")
    welcomeFrame.Size = UDim2.new(1, 0, 1, 0)
    welcomeFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
    welcomeFrame.BackgroundTransparency = 1
    welcomeFrame.ZIndex = 1003
    welcomeFrame.Visible = false
    welcomeFrame.Parent = screenGui
    print("Welcome Frame creado")

    local welcomeLabel = Instance.new("TextLabel")
    welcomeLabel.Size = UDim2.new(1, 0, 0, 50)
    welcomeLabel.Position = UDim2.new(0, 0, 0.5, -25)
    welcomeLabel.BackgroundTransparency = 1
    welcomeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    welcomeLabel.Font = Enum.Font.SourceSansBold
    welcomeLabel.TextSize = 24
    welcomeLabel.Text = ""
    welcomeLabel.ZIndex = 1004
    welcomeLabel.Parent = welcomeFrame
    print("Welcome Label creado")

    -- Crear Botón Flotante para Togglear
    local toggleButton = Instance.new("TextButton")
    toggleButton.Size = UDim2.new(0, 50, 0, 50)
    toggleButton.Position = UDim2.new(1, -60, 0, 10)
    toggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 255)
    toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleButton.Font = Enum.Font.SourceSansBold
    toggleButton.TextSize = 20
    toggleButton.Text = "≡"
    toggleButton.ZIndex = 1000
    toggleButton.Parent = screenGui
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 10)
    toggleCorner.Parent = toggleButton
    print("Toggle Button creado")

    -- Crear Frame principal
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 300, 0, 350)
    frame.Position = UDim2.new(0.5, -150, 0.5, -175)
    frame.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
    frame.BackgroundTransparency = 0.5
    frame.BorderSizePixel = 0
    frame.Active = true
    frame.Draggable = true
    frame.ZIndex = 1
    frame.Visible = false
    frame.Parent = screenGui
    local frameCorner = Instance.new("UICorner")
    frameCorner.CornerRadius = UDim.new(0, 10)
    frameCorner.Parent = frame
    print("Main Frame creado")

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 30)
    title.BackgroundColor3 = Color3.fromRGB(20, 20, 50)
    title.BackgroundTransparency = 0.5
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Font = Enum.Font.SourceSansBold
    title.TextSize = 16
    title.Text = "Infinix Cheats v1.7"
    title.ZIndex = 2
    title.Parent = frame
    print("Main Title creado")

    local closeButton = Instance.new("TextButton")
    closeButton.Size = UDim2.new(0, 30, 0, 30)
    closeButton.Position = UDim2.new(1, -40, 0, 5)
    closeButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.Text = "X"
    closeButton.Font = Enum.Font.SourceSansBold
    closeButton.TextSize = 16
    closeButton.ZIndex = 3
    closeButton.Parent = frame
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 6)
    closeCorner.Parent = closeButton
    print("Close Button creado")

    local minimizeButton = Instance.new("TextButton")
    minimizeButton.Size = UDim2.new(0, 30, 0, 30)
    minimizeButton.Position = UDim2.new(1, -80, 0, 5)
    minimizeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 255)
    minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    minimizeButton.Text = "-"
    minimizeButton.Font = Enum.Font.SourceSansBold
    minimizeButton.TextSize = 16
    minimizeButton.ZIndex = 3
    minimizeButton.Parent = frame
    local minimizeCorner = Instance.new("UICorner")
    minimizeCorner.CornerRadius = UDim.new(0, 6)
    minimizeCorner.Parent = minimizeButton
    print("Minimize Button creado")

    local resizeHandle = Instance.new("Frame")
    resizeHandle.Size = UDim2.new(0, 20, 0, 20)
    resizeHandle.Position = UDim2.new(1, -20, 1, -20)
    resizeHandle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    resizeHandle.BackgroundTransparency = 0.5
    resizeHandle.ZIndex = 4
    resizeHandle.Parent = frame
    local resizeCorner = Instance.new("UICorner")
    resizeCorner.CornerRadius = UDim.new(0, 6)
    resizeCorner.Parent = resizeHandle
    print("Resize Handle creado")

    local tabFrame = Instance.new("Frame")
    tabFrame.Size = UDim2.new(1, 0, 0, 40)
    tabFrame.Position = UDim2.new(0, 0, 0, 30)
    tabFrame.BackgroundTransparency = 1
    tabFrame.ZIndex = 2
    tabFrame.Parent = frame
    print("Tab Frame creado")

    local contentFrame = Instance.new("ScrollingFrame")
    contentFrame.Size = UDim2.new(1, 0, 1, -70)
    contentFrame.Position = UDim2.new(0, 0, 0, 70)
    contentFrame.BackgroundTransparency = 1
    contentFrame.ZIndex = 2
    contentFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    contentFrame.ScrollingDirection = Enum.ScrollingDirection.Y
    contentFrame.ScrollBarThickness = 6
    contentFrame.Parent = frame
    print("Content ScrollingFrame creado")

    -- Boost Window
    local boostFrame = Instance.new("Frame")
    boostFrame.Size = UDim2.new(0, 100, 0, 50)
    boostFrame.Position = UDim2.new(0, 10, 1, -60)
    boostFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    boostFrame.BackgroundTransparency = 0.5
    boostFrame.BorderSizePixel = 0
    boostFrame.ZIndex = 1000
    boostFrame.Visible = false
    boostFrame.Parent = screenGui
    local boostCorner = Instance.new("UICorner")
    boostCorner.CornerRadius = UDim.new(0, 10)
    boostCorner.Parent = boostFrame
    print("Boost Frame creado")

    local boostButton = Instance.new("TextButton")
    boostButton.Size = UDim2.new(1, 0, 1, 0)
    boostButton.BackgroundTransparency = 1
    boostButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    boostButton.Font = Enum.Font.SourceSansBold
    boostButton.TextSize = 16
    boostButton.Text = "Boost"
    boostButton.ZIndex = 1001
    boostButton.Parent = boostFrame
    print("Boost Button creado")

    -- Pestañas
    local tabs = {"Main", "Básico", "Combate", "Información", "Avanzado", "Otros"}
    local tabButtons = {}
    local currentTab = nil

    for i, tabName in ipairs(tabs) do
        local tabButton = Instance.new("TextButton")
        tabButton.Size = UDim2.new(0.166, 0, 1, 0)
        tabButton.Position = UDim2.new((i-1)*0.166, 0, 0, 0)
        tabButton.BackgroundColor3 = Color3.fromRGB(20, 20, 50)
        tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        tabButton.Font = Enum.Font.SourceSans
        tabButton.TextSize = 14
        tabButton.Text = tabName
        tabButton.ZIndex = 3
        tabButton.Parent = tabFrame
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 6)
        corner.Parent = tabButton
        tabButtons[tabName] = tabButton
        print("Tab Button " .. tabName .. " creado")
    end

    -- Verificación de Clave
    local correctKey = "infinix"
    submitButton.Activated:Connect(function()
        print("Botón Enviar clickeado")
        if string.lower(keyInput.Text) == correctKey then
            print("Clave correcta")
            local fadeOutTween = tweenService:Create(keyFrame, tweenInfo, {BackgroundTransparency = 1, Size = UDim2.new(0, 0, 0, 0)})
            fadeOutTween:Play()
            fadeOutTween.Completed:Wait()
            keyFrame.Visible = false
            print("Key Frame ocultado")

            -- Animación de Bienvenida
            welcomeFrame.Visible = true
            local fullText = "Bienvenido a Infinix Cheats"
            local currentText = ""
            for i = 1, #fullText do
                currentText = currentText .. fullText:sub(i, i)
                welcomeLabel.Text = currentText
                wait(0.05)
            end
            print("Animación de bienvenida completada")
            wait(2)
            local welcomeFadeOut = tweenService:Create(welcomeFrame, tweenInfo, {BackgroundTransparency = 1})
            welcomeFadeOut:Play()
            welcomeFadeOut.Completed:Wait()
            welcomeFrame:Destroy()
            print("Welcome Frame destruido")
            showTempMessage("Infinix Cheats cargado. Toca ≡ para abrir.")
        else
            errorLabel.Text = "Clave incorrecta. Intenta de nuevo."
            print("Clave incorrecta")
        end
    end)

    -- Funcionalidades
    -- ESP Logic
    local espEnabled = false
    local boxEnabled = false
    local linesEnabled = false
    local espObjects = {}
    local espConnection
    local outlineColor = Color3.fromRGB(255, 255, 255)
    local fillEnabled = false
    local fillColor = Color3.fromRGB(255, 255, 255)
    local fillTransparency = 0.5

    local colors = {
        Color3.fromRGB(255, 0, 0), Color3.fromRGB(255, 127, 0), Color3.fromRGB(255, 255, 0),
        Color3.fromRGB(0, 255, 0), Color3.fromRGB(0, 0, 255), Color3.fromRGB(75, 0, 130),
        Color3.fromRGB(238, 130, 238)
    }

    local function applyESP(character)
        if not character or not character:FindFirstChild("HumanoidRootPart") or not character:FindFirstChild("Head") then
            return
        end
        print("Aplicando ESP a: " .. character.Name)
        local highlight = Instance.new("Highlight")
        highlight.FillTransparency = fillEnabled and fillTransparency or 1
        highlight.FillColor = fillColor
        highlight.OutlineTransparency = boxEnabled and 0 or 1
        highlight.OutlineColor = outlineColor
        highlight.Parent = character

        local billboard = Instance.new("BillboardGui")
        billboard.Adornee = character:FindFirstChild("Head")
        billboard.Size = UDim2.new(0, 200, 0, 50)
        billboard.StudsOffset = Vector3.new(0, 2, 0)
        billboard.AlwaysOnTop = true
        billboard.Parent = character

        local textLabel = Instance.new("TextLabel")
        textLabel.Size = UDim2.new(1, 0, 1, 0)
        textLabel.BackgroundTransparency = 1
        textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        textLabel.Font = Enum.Font.SourceSansBold
        textLabel.TextSize = 14
        textLabel.TextStrokeTransparency = 0.5
        textLabel.Parent = billboard

        local beam = Instance.new("Beam")
        beam.Enabled = linesEnabled
        beam.Color = ColorSequence.new(outlineColor)
        beam.Width0 = 0.2
        beam.Width1 = 0.2
        beam.ZOffset = 0
        local attachment0 = Instance.new("Attachment")
        attachment0.Parent = player.Character and player.Character:FindFirstChild("HumanoidRootPart") or nil
        local attachment1 = Instance.new("Attachment")
        attachment1.Parent = character:FindFirstChild("HumanoidRootPart")
        beam.Attachment0 = attachment0
        beam.Attachment1 = attachment1
        beam.Parent = character

        local plr = game.Players:GetPlayerFromCharacter(character)
        if plr then
            local teamName = plr.Team and plr.Team.Name or "Sin equipo"
            local humanoid = character:FindFirstChild("Humanoid")
            local health = humanoid and math.floor(humanoid.Health) or 0
            local maxHealth = humanoid and math.floor(humanoid.MaxHealth) or 100
            local distance = player.Character and player.Character:FindFirstChild("HumanoidRootPart") and 
                            (character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude or 0
            textLabel.Text = string.format("%s | %.1fm | %d/%d HP | %s", teamName, distance, health, maxHealth, plr.Name)
        end

        espObjects[character] = {highlight, billboard, textLabel, beam}
    end

    local function updateESP()
        if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
            return
        end
        for _, plr in pairs(game.Players:GetPlayers()) do
            if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                local char = plr.Character
                local rootPart = char:FindFirstChild("HumanoidRootPart")
                local humanoid = char:FindFirstChild("Humanoid")
                local espData = espObjects[char]
                if rootPart and humanoid and espData then
                    local distance = (rootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
                    local teamName = plr.Team and plr.Team.Name or "Sin equipo"
                    local health = math.floor(humanoid.Health)
                    local maxHealth = math.floor(humanoid.MaxHealth)
                    espData[3].Text = string.format("%s | %.1fm | %d/%d HP | %s", teamName, distance, health, maxHealth, plr.Name)
                    espData[1].Enabled = true
                    espData[2].Enabled = true
                    espData[4].Enabled = linesEnabled
                end
            end
        end
    end

    local function refreshESP()
        for _, data in pairs(espObjects) do
            for _, obj in pairs(data) do
                obj:Destroy()
            end
        end
        espObjects = {}
        for _, plr in pairs(game.Players:GetPlayers()) do
            if plr ~= player and plr.Character then
                applyESP(plr.Character)
            end
        end
    end

    local function updateChams()
        for _, data in pairs(espObjects) do
            local highlight = data[1]
            local beam = data[4]
            highlight.OutlineColor = outlineColor
            highlight.FillColor = fillColor
            highlight.FillTransparency = fillEnabled and fillTransparency or 1
            highlight.OutlineTransparency = boxEnabled and 0 or 1
            beam.Color = ColorSequence.new(outlineColor)
            beam.Enabled = linesEnabled
        end
    end

    local function toggleESP()
        espEnabled = not espEnabled
        print("ESP: " .. (espEnabled and "Activado" or "Desactivado"))
        if espEnabled then
            soundOn:Play()
            refreshESP()
            espConnection = runService.Heartbeat:Connect(function()
                if espEnabled then
                    updateESP()
                end
            end)
            for _, plr in pairs(game.Players:GetPlayers()) do
                if plr ~= player then
                    plr.CharacterAdded:Connect(function(character)
                        if espEnabled then
                            applyESP(character)
                        end
                    end)
                end
            end
        else
            soundOff:Play()
            if espConnection then
                espConnection:Disconnect()
            end
            for _, data in pairs(espObjects) do
                for _, obj in pairs(data) do
                    obj:Destroy()
                end
            end
            espObjects = {}
        end
    end

    -- Fly Logic
    local flyEnabled = false
    local flySpeed = 50
    local flyConnection
    local bodyVelocity
    local bodyGyro
    local flyControlsFrame

    local function startFly()
        if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
            print("Personaje no disponible para Fly")
            showTempMessage("Personaje no disponible")
            return
        end
        local rootPart = player.Character.HumanoidRootPart
        bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.Parent = rootPart

        bodyGyro = Instance.new("BodyGyro")
        bodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        bodyGyro.CFrame = rootPart.CFrame
        bodyGyro.Parent = rootPart

        flyControlsFrame.Visible = true
        flyConnection = runService.RenderStepped:Connect(function()
            if not flyEnabled then return end
            -- Actualizar lógica de Fly
        end)
        print("Fly iniciado")
        showTempMessage("Fly iniciado")
    end

    local function stopFly()
        if bodyVelocity then
            bodyVelocity:Destroy()
            bodyVelocity = nil
        end
        if bodyGyro then
            bodyGyro:Destroy()
            bodyGyro = nil
        end
        if flyConnection then
            flyConnection:Disconnect()
            flyConnection = nil
        end
        if flyControlsFrame then
            flyControlsFrame.Visible = false
        end
        print("Fly detenido")
        showTempMessage("Fly detenido")
    end

    local function toggleFly()
        flyEnabled = not flyEnabled
        print("Fly: " .. (flyEnabled and "Activado" or "Desactivado"))
        if flyEnabled then
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
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local rootPart = player.Character.HumanoidRootPart
            rootPart.CFrame = rootPart.CFrame + Vector3.new(0, direction * upDownDistance, 0)
            print(direction > 0 and "Subiendo..." or "Bajando...")
            showTempMessage(direction > 0 and "Subiendo..." or "Bajando...")
        else
            print("Personaje no disponible")
            showTempMessage("Personaje no disponible")
        end
    end

    -- Speed Logic
    local walkSpeed = 16
    local function updateSpeed(newSpeed)
        walkSpeed = math.clamp(newSpeed, 16, 100)
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = walkSpeed
        end
        print("Velocidad: " .. walkSpeed)
        showTempMessage("Velocidad: " .. walkSpeed)
    end

    -- Boost Logic
    local boostActive = false
    boostButton.Activated:Connect(function()
        if boostActive then return end
        boostActive = true
        print("Boost activado")
        showTempMessage("Boost activado")
        local originalSpeed = walkSpeed
        updateSpeed(walkSpeed + 51)
        wait(1)
        updateSpeed(originalSpeed)
        print("Boost terminado")
        showTempMessage("Boost terminado")
        boostActive = false
    end)

    -- *** Aimbot Logic Mejorada ***
    local aimbotBasicEnabled = false
    local aimbotSmoothEnabled = false
    local aimbotSilentEnabled = false
    local aimFOV = 100
    local aimPart = "Head"
    local smoothness = 0.5
    local predictionEnabled = false -- Nuevo: Predicción de movimiento
    local aimbotConnection
    local showFOVCircle = true
    local currentTarget = nil -- Jugador actualmente apuntado

    -- Actualizar tamaño del círculo de FOV
    local function updateFOVCircle()
        fovCircle.Size = UDim2.new(0, aimFOV * 2, 0, aimFOV * 2)
        fovCircle.Visible = showFOVCircle and (aimbotBasicEnabled or aimbotSmoothEnabled or aimbotSilentEnabled)
        print("FOV Circle actualizado: " .. aimFOV * 2 .. "x" .. aimFOV * 2)
    end

    -- Actualizar línea roja
    local function updateAimLine(target)
        if target and target.Character and target.Character:FindFirstChild(aimPart) and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            aimAttach0.Parent = player.Character.HumanoidRootPart
            aimAttach1.Parent = target.Character[aimPart]
            aimLine.Enabled = true
        else
            aimLine.Enabled = false
            aimAttach0.Parent = nil
            aimAttach1.Parent = nil
        end
    end

    -- Seleccionar el mejor objetivo
    local function getBestTarget()
        if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return nil end
        local mousePos = userInputService:GetMouseLocation()
        local closestPlayer = nil
        local closestWorldDistance = math.huge

        for _, plr in ipairs(players:GetPlayers()) do
            if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and 
               plr.Character:FindFirstChild(aimPart) and plr.Character:FindFirstChild("Humanoid") and 
               plr.Character.Humanoid.Health > 0 then
                local targetPart = plr.Character[aimPart]
                local screenPoint, onScreen = camera:WorldToScreenPoint(targetPart.Position)
                local screenDistance = (Vector2.new(screenPoint.X, screenPoint.Y) - mousePos).Magnitude
                local worldDistance = (targetPart.Position - player.Character.HumanoidRootPart.Position).Magnitude

                if onScreen and screenDistance <= aimFOV then
                    local raycastParams = RaycastParams.new()
                    raycastParams.FilterDescendantsInstances = {player.Character}
                    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
                    local rayResult = workspace:Raycast(
                        player.Character.HumanoidRootPart.Position,
                        (targetPart.Position - player.Character.HumanoidRootPart.Position).Unit * worldDistance,
                        raycastParams
                    )
                    if not rayResult or rayResult.Instance:IsDescendantOf(plr.Character) then
                        if worldDistance < closestWorldDistance then
                            closestPlayer = plr
                            closestWorldDistance = worldDistance
                        end
                    end
                end
            end
        end
        return closestPlayer
    end

    local function toggleAimbot(mode)
        local prevBasic, prevSmooth, prevSilent = aimbotBasicEnabled, aimbotSmoothEnabled, aimbotSilentEnabled
        aimbotBasicEnabled = mode == "basic" and not aimbotBasicEnabled or false
        aimbotSmoothEnabled = mode == "smooth" and not aimbotSmoothEnabled or false
        aimbotSilentEnabled = mode == "silent" and not aimbotSilentEnabled or false
        local isActive = aimbotBasicEnabled or aimbotSmoothEnabled or aimbotSilentEnabled
        print(string.format("Aimbot: %s", 
            aimbotBasicEnabled and "Básico Activado" or aimbotSmoothEnabled and "Suave Activado" or aimbotSilentEnabled and "Silencioso Activado" or "Desactivado"))
        showTempMessage(string.format("Aimbot: %s", 
            aimbotBasicEnabled and "Básico Activado" or aimbotSmoothEnabled and "Suave Activado" or aimbotSilentEnabled and "Silencioso Activado" or "Desactivado"))
        updateFOVCircle()

        if isActive then
            if not (prevBasic or prevSmooth or prevSilent) then
                soundOn:Play()
            end
            if aimbotConnection then
                aimbotConnection:Disconnect()
            end
            aimbotConnection = runService.RenderStepped:Connect(function()
                if not (aimbotBasicEnabled or aimbotSmoothEnabled or aimbotSilentEnabled) then return end
                if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
                    currentTarget = nil
                    updateAimLine(nil)
                    return
                end

                -- Verificar si el objetivo actual es válido
                if currentTarget and currentTarget.Character and currentTarget.Character:FindFirstChild("Humanoid") and 
                   currentTarget.Character.Humanoid.Health > 0 and currentTarget.Character:FindFirstChild(aimPart) then
                    local targetPart = currentTarget.Character[aimPart]
                    local screenPoint, onScreen = camera:WorldToScreenPoint(targetPart.Position)
                    local screenDistance = (Vector2.new(screenPoint.X, screenPoint.Y) - userInputService:GetMouseLocation()).Magnitude
                    local worldDistance = (targetPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
                    local raycastParams = RaycastParams.new()
                    raycastParams.FilterDescendantsInstances = {player.Character}
                    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
                    local rayResult = workspace:Raycast(
                        player.Character.HumanoidRootPart.Position,
                        (targetPart.Position - player.Character.HumanoidRootPart.Position).Unit * worldDistance,
                        raycastParams
                    )
                    if not onScreen or screenDistance > aimFOV or (rayResult and not rayResult.Instance:IsDescendantOf(currentTarget.Character)) then
                        currentTarget = nil
                    end
                else
                    currentTarget = nil
                end

                -- Buscar nuevo objetivo si no hay uno válido
                if not currentTarget then
                    currentTarget = getBestTarget()
                    if currentTarget then
                        print("Nuevo objetivo: " .. currentTarget.Name)
                        -- Conectar evento de muerte
                        local humanoid = currentTarget.Character:FindFirstChild("Humanoid")
                        if humanoid then
                            humanoid.Died:Connect(function()
                                if currentTarget == players:GetPlayerFromCharacter(humanoid.Parent) then
                                    currentTarget = nil
                                    updateAimLine(nil)
                                    print("Objetivo murió: " .. humanoid.Parent.Name)
                                end
                            end)
                        end
                    end
                end

                -- Actualizar aimbot
                if currentTarget and currentTarget.Character and currentTarget.Character:FindFirstChild(aimPart) then
                    local targetPos = currentTarget.Character[aimPart].Position
                    if predictionEnabled then
                        local velocity = currentTarget.Character.HumanoidRootPart.Velocity
                        local ping = game:GetService("Stats").Network.ServerStatsItem["Ping"]:GetValue() / 1000
                        targetPos = targetPos + velocity * (ping + 0.1) -- Predicción simple
                    end
                    updateAimLine(currentTarget)

                    if aimbotBasicEnabled then
                        camera.CFrame = CFrame.new(camera.CFrame.Position, targetPos)
                    elseif aimbotSmoothEnabled then
                        local currentLook = camera.CFrame.LookVector
                        local targetLook = (targetPos - camera.CFrame.Position).Unit
                        local newLook = currentLook:Lerp(targetLook, smoothness)
                        camera.CFrame = CFrame.new(camera.CFrame.Position, camera.CFrame.Position + newLook)
                    elseif aimbotSilentEnabled then
                        -- Silent Aim (Placeholder: Ajustar trayectoria de disparos)
                        print("Aimbot Silencioso apuntando a: " .. currentTarget.Name)
                    end
                else
                    updateAimLine(nil)
                end
            end)
        else
            if prevBasic or prevSmooth or prevSilent then
                soundOff:Play()
            end
            fovCircle.Visible = false
            aimLine.Enabled = false
            currentTarget = nil
            if aimbotConnection then
                aimbotConnection:Disconnect()
                aimbotConnection = nil
            end
        end
    end

    -- NoClip Logic
    local noClipEnabled = false
    local noClipConnection
    local function toggleNoClip()
        noClipEnabled = not noClipEnabled
        print("NoClip: " .. (noClipEnabled and "Activado" or "Desactivado"))
        showTempMessage("NoClip: " .. (noClipEnabled and "Activado" or "Desactivado"))
        if noClipEnabled then
            soundOn:Play()
            noClipConnection = runService.Stepped:Connect(function()
                if player.Character then
                    for _, part in ipairs(player.Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end)
        else
            soundOff:Play()
            if noClipConnection then
                noClipConnection:Disconnect()
                noClipConnection = nil
            end
            if player.Character then
                for _, part in ipairs(player.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = true
                    end
                end
            end
        end
    end

    -- Infinite Jump Logic
    local infiniteJumpEnabled = false
    local jumpConnection
    local function toggleInfiniteJump()
        infiniteJumpEnabled = not infiniteJumpEnabled
        print("Infinite Jump: " .. (infiniteJumpEnabled and "Activado" or "Desactivado"))
        showTempMessage("Infinite Jump: " .. (infiniteJumpEnabled and "Activado" or "Desactivado"))
        if infiniteJumpEnabled then
            soundOn:Play()
            jumpConnection = userInputService.JumpRequest:Connect(function()
                if player.Character then
                    player.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end)
        else
            soundOff:Play()
            if jumpConnection then
                jumpConnection:Disconnect()
                jumpConnection = nil
            end
        end
    end

    -- Auto-Farm Logic (Placeholder)
    local autoFarmEnabled = false
    local autoFarmConnection
    local function toggleAutoFarm()
        autoFarmEnabled = not autoFarmEnabled
        print("Auto-Farm: " .. (autoFarmEnabled and "Activado" or "Desactivado"))
        showTempMessage("Auto-Farm: " .. (autoFarmEnabled and "Activado" or "Desactivado"))
        if autoFarmEnabled then
            soundOn:Play()
            autoFarmConnection = runService.Heartbeat:Connect(function()
                print("Auto-Farm activo, buscando recursos...")
                showTempMessage("Auto-Farm activo, buscando recursos...")
            end)
        else
            soundOff:Play()
            if autoFarmConnection then
                autoFarmConnection:Disconnect()
                autoFarmConnection = nil
            end
        end
    end

    -- God Mode Logic (Placeholder)
    local godModeEnabled = false
    local function toggleGodMode()
        godModeEnabled = not godModeEnabled
        print("God Mode: " .. (godModeEnabled and "Activado" or "Desactivado"))
        showTempMessage("God Mode: " .. (godModeEnabled and "Activado" or "Desactivado"))
        if godModeEnabled then
            soundOn:Play()
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid.MaxHealth = math.huge
                player.Character.Humanoid.Health = math.huge
            end
        else
            soundOff:Play()
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid.MaxHealth = 100
                player.Character.Humanoid.Health = 100
            end
        end
    end

    -- Server Hop Logic
    local function serverHop()
        print("Buscando servidor...")
        showTempMessage("Buscando servidor...")
        local servers = {}
        local cursor = ""
        local placeId = game.PlaceId
        local success, result = pcall(function()
            while true do
                local response = httpService:GetAsync(string.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Asc&limit=100&cursor=%s", placeId, cursor))
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
            print("Cambiando de servidor...")
            showTempMessage("Cambiando de servidor...")
            game:GetService("TeleportService"):TeleportToPlaceInstance(placeId, servers[math.random(1, #servers)])
        else
            print("Error: No hay servidores disponibles. " .. (result or ""))
            showTempMessage("Error: No hay servidores disponibles.")
        end
    end

    -- Rejoin Logic
    local function rejoin()
        print("Reuniendo al servidor...")
        showTempMessage("Reuniendo al servidor...")
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId)
    end

    -- FPS Unlocker
    local function unlockFPS()
        if setfpscap then
            setfpscap(999)
            print("FPS Unlocker activado")
            showTempMessage("FPS Unlocker activado")
        else
            print("FPS Unlocker no soportado")
            showTempMessage("FPS Unlocker no soportado")
        end
    end

    -- Chat Spoofer (Placeholder)
    local function chatSpoofer(message, spoofedPlayer)
        print("Enviando mensaje como " .. spoofedPlayer.Name)
        showTempMessage("Enviando mensaje como " .. spoofedPlayer.Name)
    end

    -- Fly Controls Frame
    flyControlsFrame = Instance.new("Frame")
    flyControlsFrame.Size = UDim2.new(0, 200, 0, 200)
    flyControlsFrame.Position = UDim2.new(0, 10, 0.5, -100)
    flyControlsFrame.BackgroundTransparency = 1
    flyControlsFrame.ZIndex = 1000
    flyControlsFrame.Visible = false
    flyControlsFrame.Parent = screenGui
    print("Fly Controls Frame creado")

    local flyMoveDirection = Vector3.new(0, 0, 0)
    local function addFlyButton(text, size, pos, direction)
        local button = Instance.new("TextButton")
        button.Size = size
        button.Position = pos
        button.BackgroundColor3 = Color3.fromRGB(50, 50, 255)
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.Font = Enum.Font.SourceSansBold
        button.TextSize = 16
        button.Text = text
        button.ZIndex = 1001
        button.Parent = flyControlsFrame
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 6)
        corner.Parent = button
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
        print("Fly Button " .. text .. " creado")
        return button
    end

    addFlyButton("↑", UDim2.new(0, 60, 0, 60), UDim2.new(0.35, 0, 0, 0), Vector3.new(0, 1, 0))
    addFlyButton("↓", UDim2.new(0, 60, 0, 60), UDim2.new(0.35, 0, 0.7, 0), Vector3.new(0, -1, 0))
    addFlyButton("W", UDim2.new(0, 60, 0, 60), UDim2.new(0.35, 0, 0.35, 0), Vector3.new(0, 0, -1))
    addFlyButton("S", UDim2.new(0, 60, 0, 60), UDim2.new(0.35, 0, 0.35, 0), Vector3.new(0, 0, 1))
    addFlyButton("A", UDim2.new(0, 60, 0, 60), UDim2.new(0, 0, 0.35, 0), Vector3.new(-1, 0, 0))
    addFlyButton("D", UDim2.new(0, 60, 0, 60), UDim2.new(0.7, 0, 0.35, 0), Vector3.new(1, 0, 0))

    -- Actualizar Fly
    local function updateFlyDirection()
        if flyEnabled and bodyVelocity and flyMoveDirection.Magnitude > 0 then
            bodyVelocity.Velocity = player.Character.HumanoidRootPart.CFrame:VectorToWorldSpace(flyMoveDirection.Unit * flySpeed)
        elseif bodyVelocity then
            bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        end
    end

    -- Conectar Fly
    if flyConnection then
        flyConnection:Disconnect()
    end
    flyConnection = runService.RenderStepped:Connect(function()
        if flyEnabled then
            updateFlyDirection()
        end
    end)

    local function createTabContent(tabName)
        for _, child in ipairs(contentFrame:GetChildren()) do
            if child:IsA("GuiObject") then
                child:Destroy()
            end
        end
        contentFrame.CanvasPosition = Vector2.new(0, 0)
        print("Pestaña " .. tabName .. " seleccionada")
        local function addButton(parent, text, size, pos, callback)
            local button = Instance.new("TextButton")
            button.Size = size
            button.Position = pos
            button.BackgroundColor3 = Color3.fromRGB(20, 20, 50)
            button.TextColor3 = Color3.fromRGB(255, 255, 255)
            button.Font = Enum.Font.SourceSans
            button.TextSize = 16
            button.Text = text
            button.ZIndex = 3
            button.Parent = parent
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 6)
            corner.Parent = button
            button.Activated:Connect(callback)
            print("Button " .. text .. " creado en x=" .. pos.X.Scale .. ", y=" .. pos.Y.Scale)
            return button
        end

        local function addLabel(parent, text, pos)
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, 0, 0, 20)
            label.Position = pos
            label.BackgroundTransparency = 1
            label.TextColor3 = Color3.fromRGB(255, 255, 255)
            label.Font = Enum.Font.SourceSans
            label.TextSize = 14
            label.Text = text
            label.ZIndex = 3
            label.Parent = parent
            print("Label " .. text .. " creado en y=" .. pos.Y.Scale)
            return label
        end

        local contentHeight = 0
        if tabName == "Main" then
            addLabel(contentFrame, "Infinix Cheats v1.7", UDim2.new(0, 0, 0, 0))
            addLabel(contentFrame, "Creador: Zxcx", UDim2.new(0, 0, 0.1, 0))
            addLabel(contentFrame, "Desarrollador: Grok (xAI)", UDim2.new(0, 0, 0.2, 0))
            addLabel(contentFrame, "Gracias por usar Infinix Cheats!", UDim2.new(0, 0, 0.3, 0))
            contentHeight = 0.4
        elseif tabName == "Básico" then
            boostFrame.Visible = true
            local flyToggle = addButton(contentFrame, flyEnabled and "Desactivar Fly" or "Activar Fly", UDim2.new(0.8, 0, 0, 40), UDim2.new(0.1, 0, 0, 0), function()
                toggleFly()
                flyToggle.Text = flyEnabled and "Desactivar Fly" or "Activar Fly"
            end)

            local flySpeedLabel = addLabel(contentFrame, "Velocidad de Fly: " .. flySpeed, UDim2.new(0, 0, 0.15, 0))
            addButton(contentFrame, "+", UDim2.new(0.35, 0, 0, 30), UDim2.new(0.1, 0, 0.25, 0), function()
                flySpeed = math.clamp(flySpeed + 10, 10, 200)
                flySpeedLabel.Text = "Velocidad de Fly: " .. flySpeed
            end)
            addButton(contentFrame, "-", UDim2.new(0.35, 0, 0, 30), UDim2.new(0.55, 0, 0.25, 0), function()
                flySpeed = math.clamp(flySpeed - 10, 10, 200)
                flySpeedLabel.Text = "Velocidad de Fly: " .. flySpeed
            end)

            local upDownLabel = addLabel(contentFrame, "Distancia Up/Down: " .. upDownDistance, UDim2.new(0, 0, 0.4, 0))
            addButton(contentFrame, "Subir", UDim2.new(0.35, 0, 0, 40), UDim2.new(0.1, 0, 0.5, 0), function() moveVertical(1) end)
            addButton(contentFrame, "Bajar", UDim2.new(0.35, 0, 0, 40), UDim2.new(0.55, 0, 0.5, 0), function() moveVertical(-1) end)
            addButton(contentFrame, "+", UDim2.new(0.35, 0, 0, 30), UDim2.new(0.1, 0, 0.65, 0), function()
                upDownDistance = math.clamp(upDownDistance + 10, 5, 100)
                upDownLabel.Text = "Distancia Up/Down: " .. upDownDistance
            end)
            addButton(contentFrame, "-", UDim2.new(0.35, 0, 0, 30), UDim2.new(0.55, 0, 0.65, 0), function()
                upDownDistance = math.clamp(upDownDistance - 10, 5, 100)
                upDownLabel.Text = "Distancia Up/Down: " .. upDownDistance
            end)

            local speedLabel = addLabel(contentFrame, "Velocidad: " .. walkSpeed, UDim2.new(0, 0, 0.8, 0))
            addButton(contentFrame, "+", UDim2.new(0.35, 0, 0, 30), UDim2.new(0.1, 0, 0.9, 0), function()
                updateSpeed(walkSpeed + 10)
                speedLabel.Text = "Velocidad: " .. walkSpeed
            end)
            addButton(contentFrame, "-", UDim2.new(0.35, 0, 0, 30), UDim2.new(0.55, 0, 0.9, 0), function()
                updateSpeed(walkSpeed - 10)
                speedLabel.Text = "Velocidad: " .. walkSpeed
            end)
            contentHeight = 1.2
        elseif tabName == "Combate" then
            local aimbotBasicToggle = addButton(contentFrame, aimbotBasicEnabled and "Desactivar Aimbot Básico" or "Activar Aimbot Básico", UDim2.new(0.8, 0, 0, 40), UDim2.new(0.1, 0, 0, 0), function()
                toggleAimbot("basic")
                aimbotBasicToggle.Text = aimbotBasicEnabled and "Desactivar Aimbot Básico" or "Activar Aimbot Básico"
            end)
            local aimbotSmoothToggle = addButton(contentFrame, aimbotSmoothEnabled and "Desactivar Aimbot Suave" or "Activar Aimbot Suave", UDim2.new(0.8, 0, 0, 40), UDim2.new(0.1, 0, 0.15, 0), function()
                toggleAimbot("smooth")
                aimbotSmoothToggle.Text = aimbotSmoothEnabled and "Desactivar Aimbot Suave" or "Activar Aimbot Suave"
            end)
            local aimbotSilentToggle = addButton(contentFrame, aimbotSilentEnabled and "Desactivar Aimbot Silencioso" or "Activar Aimbot Silencioso", UDim2.new(0.8, 0, 0, 40), UDim2.new(0.1, 0, 0.3, 0), function()
                toggleAimbot("silent")
                aimbotSilentToggle.Text = aimbotSilentEnabled and "Desactivar Aimbot Silencioso" or "Activar Aimbot Silencioso"
            end)

            local aimPartLabel = addLabel(contentFrame, "Parte a Apuntar: " .. aimPart, UDim2.new(0, 0, 0.45, 0))
            addButton(contentFrame, "Cabeza", UDim2.new(0.35, 0, 0, 30), UDim2.new(0.1, 0, 0.55, 0), function()
                aimPart = "Head"
                aimPartLabel.Text = "Parte a Apuntar: " .. aimPart
            end)
            addButton(contentFrame, "Torso", UDim2.new(0.35, 0, 0, 30), UDim2.new(0.55, 0, 0.55, 0), function()
                aimPart = "HumanoidRootPart"
                aimPartLabel.Text = "Parte a Apuntar: " .. aimPart
            end)

            local fovLabel = addLabel(contentFrame, "FOV: " .. aimFOV, UDim2.new(0, 0, 0.7, 0))
            addButton(contentFrame, "+", UDim2.new(0.35, 0, 0, 30), UDim2.new(0.1, 0, 0.8, 0), function()
                aimFOV = math.clamp(aimFOV + 10, 50, 200)
                fovLabel.Text = "FOV: " .. aimFOV
                updateFOVCircle()
            end)
            addButton(contentFrame, "-", UDim2.new(0.35, 0, 0, 30), UDim2.new(0.55, 0, 0.8, 0), function()
                aimFOV = math.clamp(aimFOV - 10, 50, 200)
                fovLabel.Text = "FOV: " .. aimFOV
                updateFOVCircle()
            end)

            local fovCircleToggle = addButton(contentFrame, showFOVCircle and "Ocultar Círculo FOV" or "Mostrar Círculo FOV", UDim2.new(0.8, 0, 0, 40), UDim2.new(0.1, 0, 0.95, 0), function()
                showFOVCircle = not showFOVCircle
                fovCircleToggle.Text = showFOVCircle and "Ocultar Círculo FOV" or "Mostrar Círculo FOV"
                updateFOVCircle()
                if showFOVCircle then soundOn:Play() else soundOff:Play() end
            end)

            -- *** Nuevo: Toggle para Predicción de Movimiento ***
            local predictionToggle = addButton(contentFrame, predictionEnabled and "Desactivar Predicción" or "Activar Predicción", UDim2.new(0.8, 0, 0, 40), UDim2.new(0.1, 0, 1.1, 0), function()
                predictionEnabled = not predictionEnabled
                predictionToggle.Text = predictionEnabled and "Desactivar Predicción" or "Activar Predicción"
                if predictionEnabled then soundOn:Play() else soundOff:Play() end
                print("Predicción de Movimiento: " .. (predictionEnabled and "Activada" or "Desactivada"))
            end)
            contentHeight = 1.3
        elseif tabName == "Información" then
            local espToggle = addButton(contentFrame, espEnabled and "Desactivar ESP" or "Activar ESP", UDim2.new(0.8, 0, 0, 40), UDim2.new(0.1, 0, 0, 0), function()
                toggleESP()
                espToggle.Text = espEnabled and "Desactivar ESP" or "Activar ESP"
            end)
            local boxToggle = addButton(contentFrame, boxEnabled and "Desactivar Box" or "Activar Box", UDim2.new(0.8, 0, 0, 40), UDim2.new(0.1, 0, 0.15, 0), function()
                boxEnabled = not boxEnabled
                boxToggle.Text = boxEnabled and "Desactivar Box" or "Activar Box"
                if boxEnabled then soundOn:Play() else soundOff:Play() end
                updateChams()
            end)
            local linesToggle = addButton(contentFrame, linesEnabled and "Desactivar Lines" or "Activar Lines", UDim2.new(0.8, 0, 0, 40), UDim2.new(0.1, 0, 0.3, 0), function()
                linesEnabled = not linesEnabled
                linesToggle.Text = linesEnabled and "Desactivar Lines" or "Activar Lines"
                if linesEnabled then soundOn:Play() else soundOff:Play() end
                updateChams()
            end)

            local outlineColorLabel = addLabel(contentFrame, "Color del Borde", UDim2.new(0, 0, 0.45, 0))
            for i, color in ipairs(colors) do
                local x = 0.1 + ((i-1) % 4) * 0.12
                local y = 0.55 + math.floor((i-1) / 4) * 0.15
                local button = addButton(contentFrame, "", UDim2.new(0, 30, 0, 30), UDim2.new(x, 0, y, 0), function()
                    outlineColor = color
                    updateChams()
                end)
                button.BackgroundColor3 = color
                print("Outline Color Button " .. i .. " creado en x=" .. x .. ", y=" .. y)
            end

            local fillToggle = addButton(contentFrame, fillEnabled and "Relleno: On" or "Relleno: Off", UDim2.new(0.2, 0, 0, 30), UDim2.new(0.1, 0, 0.85, 0), function()
                fillEnabled = not fillEnabled
                fillToggle.Text = fillEnabled and "Relleno: On" or "Relleno: Off"
                if fillEnabled then soundOn:Play() else soundOff:Play() end
                updateChams()
            end)
            local fillColorLabel = addLabel(contentFrame, "Color del Relleno", UDim2.new(0, 0, 1.0, 0))
            for i, color in ipairs(colors) do
                local x = 0.1 + ((i-1) % 4) * 0.12
                local y = 1.1 + math.floor((i-1) / 4) * 0.15
                local button = addButton(contentFrame, "", UDim2.new(0, 30, 0, 30), UDim2.new(x, 0, y, 0), function()
                    fillColor = color
                    updateChams()
                end)
                button.BackgroundColor3 = color
                print("Fill Color Button " .. i .. " creado en x=" .. x .. ", y=" .. y)
            end

            local serverInfo = addLabel(contentFrame, "Cargando info...", UDim2.new(0, 0, 1.4, 0))
            spawn(function()
                while contentFrame.Parent do
                    local health = player.Character and player.Character:FindFirstChild("Humanoid") and math.floor(player.Character.Humanoid.Health) or 0
                    local maxHealth = player.Character and player.Character:FindFirstChild("Humanoid") and math.floor(player.Character.Humanoid.MaxHealth) or 100
                    serverInfo.Text = string.format("Jugador: %s | Salud: %d/%d | Servidor: %s | Ping: %d", 
                            player.Name, health, maxHealth, game.JobId, game:GetService("Stats").Network.ServerStatsItem["Ping"]:GetValue())
                    wait(1)
                end
            end)
            contentHeight = 1.6
        elseif tabName == "Avanzado" then
            local noClipToggle = addButton(contentFrame, noClipEnabled and "Desactivar NoClip" or "Activar NoClip", UDim2.new(0.8, 0, 0, 40), UDim2.new(0.1, 0, 0, 0), function()
                toggleNoClip()
                noClipToggle.Text = noClipEnabled and "Desactivar NoClip" or "Activar NoClip"
            end)
            local infiniteJumpToggle = addButton(contentFrame, infiniteJumpEnabled and "Desactivar Infinite Jump" or "Activar Infinite Jump", UDim2.new(0.8, 0, 0, 40), UDim2.new(0.1, 0, 0.15, 0), function()
                toggleInfiniteJump()
                infiniteJumpToggle.Text = infiniteJumpEnabled and "Desactivar Infinite Jump" or "Activar Infinite Jump"
            end)
            local autoFarmToggle = addButton(contentFrame, autoFarmEnabled and "Desactivar Auto-Farm" or "Activar Auto-Farm", UDim2.new(0.8, 0, 0, 40), UDim2.new(0.1, 0, 0.3, 0), function()
                toggleAutoFarm()
                autoFarmToggle.Text = autoFarmEnabled and "Desactivar Auto-Farm" or "Activar Auto-Farm"
            end)
            local godModeToggle = addButton(contentFrame, godModeEnabled and "Desactivar God Mode" or "Activar God Mode", UDim2.new(0.8, 0, 0, 40), UDim2.new(0.1, 0, 0.45, 0), function()
                toggleGodMode()
                godModeToggle.Text = godModeEnabled and "Desactivar God Mode" or "Activar God Mode"
            end)
            contentHeight = 0.6
        elseif tabName == "Otros" then
            addButton(contentFrame, "Server Hop", UDim2.new(0.8, 0, 0, 40), UDim2.new(0.1, 0, 0, 0), serverHop)
            addButton(contentFrame, "Rejoin", UDim2.new(0.8, 0, 0, 40), UDim2.new(0.1, 0, 0.15, 0), rejoin)
            addButton(contentFrame, "FPS Unlocker", UDim2.new(0.8, 0, 0, 40), UDim2.new(0.1, 0, 0.3, 0), unlockFPS)
            addButton(contentFrame, "Chat Spoofer", UDim2.new(0.8, 0, 0, 40), UDim2.new(0.1, 0, 0.45, 0), function()
                chatSpoofer("Mensaje de prueba", player)
            end)
            contentHeight = 0.6
        end
        contentFrame.CanvasSize = UDim2.new(0, 0, contentHeight, 0)
    end

    for tabName, button in pairs(tabButtons) do
        button.Activated:Connect(function()
            print("Pestaña " .. tabName .. " clickeada")
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
            print("Menú minimizado")
            showTempMessage("Menú minimizado")
        else
            frame.Size = UDim2.new(0, frame.Size.X.Offset, 0, 350)
            tabFrame.Visible = true
            contentFrame.Visible = true
            minimizeButton.Text = "-"
            resizeHandle.Visible = true
            if currentTab then
                createTabContent(currentTab)
            end
            print("Menú restaurado")
            showTempMessage("Menú restaurado")
        end
    end
local function toggleMenu()
        frame.Visible = not frame.Visible
        if frame.Visible then
            print("Menú abierto")
            showTempMessage("Menú abierto")
            if currentTab then
                createTabContent(currentTab)
            end
        else
            print("Menú cerrado")
            showTempMessage("Menú cerrado")
        end
    end

    -- Conectar eventos de botones
    toggleButton.Activated:Connect(toggleMenu)
    closeButton.Activated:Connect(function()
        print("Cerrando Infinix Cheats...")
        showTempMessage("Cerrando Infinix Cheats...")
        screenGui:Destroy()
        if espConnection then espConnection:Disconnect() end
        if flyConnection then flyConnection:Disconnect() end
        if aimbotConnection then aimbotConnection:Disconnect() end
        if noClipConnection then noClipConnection:Disconnect() end
        if jumpConnection then jumpConnection:Disconnect() end
        if autoFarmConnection then autoFarmConnection:Disconnect() end
    end)
    minimizeButton.Activated:Connect(toggleMinimize)

    -- Resize Logic
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

    -- Inicializar pestaña por defecto
    tabButtons["Main"].BackgroundColor3 = Color3.fromRGB(40, 40, 70)
    currentTab = "Main"
    createTabContent("Main")
    print("Pestaña Main inicializada")

    -- Conectar CharacterAdded para actualizar referencias
    player.CharacterAdded:Connect(function(character)
        print("Nuevo personaje detectado para " .. player.Name)
        if flyEnabled then
            stopFly()
            startFly()
        end
        if espEnabled then
            refreshESP()
        end
        if noClipEnabled then
            toggleNoClip()
            toggleNoClip()
        end
    end)

    -- Actualizar cámara y referencias
    game.Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
        camera = game.Workspace.CurrentCamera
        print("Cámara actualizada")
    end)

    -- Mostrar mensaje de carga completa
    showTempMessage("Infinix Cheats v1.7 cargado exitosamente!")
    print("Infinix Cheats v1.7 cargado exitosamente!")
end)

if not success then
    warn("Error al cargar Infinix Cheats: " .. errorMsg)
end