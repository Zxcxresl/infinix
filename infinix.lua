local success, errorMsg = pcall(function()
    print("Iniciando Infinix Cheats v1.4...")
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

    -- Crear ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "InfinixCheats"
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.Parent = playerGui
    print("ScreenGui creado")

    -- Crear Debug Label
    local debugLabel = Instance.new("TextLabel")
    debugLabel.Size = UDim2.new(1, 0, 0, 30)
    debugLabel.Position = UDim2.new(0, 0, 0, 0)
    debugLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    debugLabel.BackgroundTransparency = 0.5
    debugLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    debugLabel.Font = Enum.Font.SourceSansBold
    debugLabel.TextSize = 16
    debugLabel.Text = "Infinix Cheats: Iniciando..."
    debugLabel.ZIndex = 1000
    debugLabel.Parent = screenGui
    print("Debug Label creado")

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
    toggleButton.Text = "☰"
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
    title.Text = "Infinix Cheats v1.4"
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

    local tabFrame = Instance.new("Frame")
    tabFrame.Size = UDim2.new(1, 0, 0, 40)
    tabFrame.Position = UDim2.new(0, 0, 0, 30)
    tabFrame.BackgroundTransparency = 1
    tabFrame.ZIndex = 2
    tabFrame.Parent = frame
    print("Tab Frame creado")

    local contentFrame = Instance.new("ScrollingFrame")
    contentFrame.Size = UDim2.new(1, 0, 0, 280)
    contentFrame.Position = UDim2.new(0, 0, 0, 70)
    contentFrame.BackgroundTransparency = 1
    contentFrame.ZIndex = 2
    contentFrame.CanvasSize = UDim2.new(0, 0, 2, 0)
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
    boostFrame.Parent = screenGui
    boostFrame.Visible = false
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
            debugLabel.Text = "Clave correcta, cargando..."
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
            debugLabel.Text = "Infinix Cheats cargado. Toca ☰ para abrir."
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
        debugLabel.Text = "Aplicando ESP a: " .. character.Name
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
        debugLabel.Text = "ESP: " .. (espEnabled and "Activado" or "Desactivado")
        print("ESP: " .. (espEnabled and "Activado" or "Desactivado"))
        if espEnabled then
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
            debugLabel.Text = "Personaje no disponible para Fly"
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
            local moveDirection = Vector3.new(0, 0, 0)
            -- Actualizar lógica de Fly para controles en pantalla (se define en createTabContent)
            bodyVelocity.Velocity = rootPart.CFrame:VectorToWorldSpace(moveDirection)
            bodyGyro.CFrame = game.Workspace.CurrentCamera.CFrame
        end)
        debugLabel.Text = "Fly iniciado"
        print("Fly iniciado")
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
        debugLabel.Text = "Fly detenido"
        print("Fly detenido")
    end

    local function toggleFly()
        flyEnabled = not flyEnabled
        debugLabel.Text = "Fly: " .. (flyEnabled and "Activado" or "Desactivado")
        print("Fly: " .. (flyEnabled and "Activado" or "Desactivado"))
        if flyEnabled then
            startFly()
        else
            stopFly()
        end
    end

    -- Up/Down Logic
    local upDownDistance = 50
    local function moveVertical(direction)
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local rootPart = player.Character.HumanoidRootPart
            rootPart.CFrame = rootPart.CFrame + Vector3.new(0, direction * upDownDistance, 0)
            debugLabel.Text = direction > 0 and "Subiendo..." or "Bajando..."
            print(direction > 0 and "Subiendo..." or "Bajando...")
        else
            debugLabel.Text = "Personaje no disponible"
            print("Personaje no disponible")
        end
    end

    -- Speed Logic
    local walkSpeed = 16
    local function updateSpeed(newSpeed)
        walkSpeed = math.clamp(newSpeed, 16, 100)
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = walkSpeed
        end
        debugLabel.Text = "Velocidad: " .. walkSpeed
        print("Velocidad: " .. walkSpeed)
    end

    -- Boost Logic
    local boostActive = false
    boostButton.Activated:Connect(function()
        if boostActive then return end
        boostActive = true
        debugLabel.Text = "Boost activado"
        print("Boost activado")
        local originalSpeed = walkSpeed
        updateSpeed(walkSpeed + 51)
        wait(1)
        updateSpeed(originalSpeed)
        debugLabel.Text = "Boost terminado"
        print("Boost terminado")
        boostActive = false
    end)

    -- Aimbot Logic
    local aimbotBasicEnabled = false
    local aimbotSmoothEnabled = false
    local aimbotSilentEnabled = false
    local aimFOV = 100
    local aimPart = "Head"
    local smoothness = 0.5
    local aimbotConnection

    local function toggleAimbot(mode)
        aimbotBasicEnabled = mode == "basic" and not aimbotBasicEnabled or false
        aimbotSmoothEnabled = mode == "smooth" and not aimbotSmoothEnabled or false
        aimbotSilentEnabled = mode == "silent" and not aimbotSilentEnabled or false
        debugLabel.Text = string.format("Aimbot: %s", 
            aimbotBasicEnabled and "Básico Activado" or aimbotSmoothEnabled and "Suave Activado" or aimbotSilentEnabled and "Silencioso Activado" or "Desactivado")
        print(string.format("Aimbot: %s", 
            aimbotBasicEnabled and "Básico Activado" or aimbotSmoothEnabled and "Suave Activado" or aimbotSilentEnabled and "Silencioso Activado" or "Desactivado"))
        if aimbotBasicEnabled or aimbotSmoothEnabled or aimbotSilentEnabled then
            aimbotConnection = coroutine.wrap(function()
                while aimbotBasicEnabled or aimbotSmoothEnabled or aimbotSilentEnabled do
                    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
                        break
                    end
                    local camera = game.Workspace.CurrentCamera
                    local closestPlayer = nil
                    local closestDistance = aimFOV
                    for _, plr in ipairs(game.Players:GetPlayers()) do
                        if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and plr.Character:FindFirstChild(aimPart) then
                            local screenPoint, onScreen = camera:WorldToScreenPoint(plr.Character[aimPart].Position)
                            local distance = (Vector2.new(screenPoint.X, screenPoint.Y) - Vector2.new(userInputService:GetMouseLocation().X, userInputService:GetMouseLocation().Y)).Magnitude
                            if onScreen and distance < closestDistance then
                                closestPlayer = plr
                                closestDistance = distance
                            end
                        end
                    end
                    if closestPlayer then
                        local targetPos = closestPlayer.Character[aimPart].Position
                        if aimbotBasicEnabled then
                            camera.CFrame = CFrame.new(camera.CFrame.Position, targetPos)
                        elseif aimbotSmoothEnabled then
                            local currentLook = camera.CFrame.LookVector
                            local targetLook = (targetPos - camera.CFrame.Position).Unit
                            local newLook = currentLook:Lerp(targetLook, smoothness)
                            camera.CFrame = CFrame.new(camera.CFrame.Position, camera.CFrame.Position + newLook)
                        elseif aimbotSilentEnabled then
                            debugLabel.Text = "Aimbot Silencioso activo en " .. closestPlayer.Name
                            print("Aimbot Silencioso activo en " .. closestPlayer.Name)
                        end
                    end
                    runService.Heartbeat:Wait()
                end
            end)()
        else
            if aimbotConnection then
                coroutine.yield(aimbotConnection)
                aimbotConnection = nil
            end
        end
    end

    -- NoClip Logic
    local noClipEnabled = false
    local noClipConnection
    local function toggleNoClip()
        noClipEnabled = not noClipEnabled
        debugLabel.Text = "NoClip: " .. (noClipEnabled and "Activado" or "Desactivado")
        print("NoClip: " .. (noClipEnabled and "Activado" or "Desactivado"))
        if noClipEnabled then
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
        debugLabel.Text = "Infinite Jump: " .. (infiniteJumpEnabled and "Activado" or "Desactivado")
        print("Infinite Jump: " .. (infiniteJumpEnabled and "Activado" or "Desactivado"))
        if infiniteJumpEnabled then
            jumpConnection = userInputService.JumpRequest:Connect(function()
                if player.Character then
                    player.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end)
        else
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
        debugLabel.Text = "Auto-Farm: " .. (autoFarmEnabled and "Activado" or "Desactivado")
        print("Auto-Farm: " .. (autoFarmEnabled and "Activado" or "Desactivado"))
        if autoFarmEnabled then
            autoFarmConnection = runService.Heartbeat:Connect(function()
                debugLabel.Text = "Auto-Farm activo, buscando recursos..."
                print("Auto-Farm activo, buscando recursos...")
            end)
        else
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
        debugLabel.Text = "God Mode: " .. (godModeEnabled and "Activado" or "Desactivado")
        print("God Mode: " .. (godModeEnabled and "Activado" or "Desactivado"))
        if godModeEnabled then
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid.MaxHealth = math.huge
                player.Character.Humanoid.Health = math.huge
            end
        else
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid.MaxHealth = 100
                player.Character.Humanoid.Health = 100
            end
        end
    end

    -- Server Hop Logic
    local function serverHop()
        debugLabel.Text = "Buscando servidor..."
        print("Buscando servidor...")
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
            debugLabel.Text = "Cambiando de servidor..."
            print("Cambiando de servidor...")
            game:GetService("TeleportService"):TeleportToPlaceInstance(placeId, servers[math.random(1, #servers)])
        else
            debugLabel.Text = "Error: No hay servidores disponibles."
            print("Error: No hay servidores disponibles. " .. (result or ""))
        end
    end

    -- Rejoin Logic
    local function rejoin()
        debugLabel.Text = "Reuniendo al servidor..."
        print("Reuniendo al servidor...")
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId)
    end

    -- FPS Unlocker
    local function unlockFPS()
        if setfpscap then
            setfpscap(999)
            debugLabel.Text = "FPS Unlocker activado"
            print("FPS Unlocker activado")
        else
            debugLabel.Text = "FPS Unlocker no soportado"
            print("FPS Unlocker no soportado")
        end
    end

    -- Chat Spoofer (Placeholder)
    local function chatSpoofer(message, spoofedPlayer)
        debugLabel.Text = "Enviando mensaje como " .. spoofedPlayer.Name
        print("Enviando mensaje como " .. spoofedPlayer.Name)
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
        debugLabel.Text = "Pestaña " .. tabName .. " seleccionada"
        print("Pestaña " .. tabName .. " seleccionada")
        local function addButton(parent, text, size, y, callback, z)
            local button = Instance.new("TextButton")
            button.Size = size
            button.Position = UDim2.new(0.1, 0, y, 0)
            button.BackgroundColor3 = Color3.fromRGB(20, 20, 50)
            button.TextColor3 = Color3.fromRGB(255, 255, 255)
            button.Font = Enum.Font.SourceSans
            button.TextSize = 16
            button.Text = text
            button.ZIndex = z or 3
            button.Parent = parent
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 6)
            corner.Parent = button
            button.Activated:Connect(callback)
            print("Button " .. text .. " creado en y=" .. y)
            return button
        end

        local function addLabel(parent, text, y)
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, 0, 0, 20)
            label.Position = UDim2.new(0, 0, y, 0)
            label.BackgroundTransparency = 1
            label.TextColor3 = Color3.fromRGB(255, 255, 255)
            label.Font = Enum.Font.SourceSans
            label.TextSize = 14
            label.Text = text
            label.ZIndex = 3
            label.Parent = parent
            print("Label " .. text .. " creado en y=" .. y)
            return label
        end

        if tabName == "Main" then
            addLabel(contentFrame, "Infinix Cheats v1.4", 0)
            addLabel(contentFrame, "Creador: Zxcx", 0.1)
            addLabel(contentFrame, "Desarrollador: Grok (xAI)", 0.2)
            addLabel(contentFrame, "Gracias por usar Infinix Cheats!", 0.3)
        elseif tabName == "Básico" then
            boostFrame.Visible = true
            local flyToggle = addButton(contentFrame, flyEnabled and "Desactivar Fly" or "Activar Fly", UDim2.new(0.8, 0, 0, 0, 40), function()
                toggleFly()
                flyToggle.Text = flyEnabled and "Desactivar Fly" or "Activar Fly"
            end)

            local flySpeedLabel = addLabel(contentFrame, "Velocidad de Fly: " .. flySpeed, 0.15)
            local flySpeedPlus = addButton(contentFrame, "+", UDim2.new(0.35, 0, 0, 30), 0.25, function()
                flySpeed = math.clamp(flySpeed + 10, 10, 200)
                flySpeedLabel.Text = "Velocidad de Fly: " .. flySpeed
            end)
            local flySpeedMinus = addButton(contentFrame, "-", UDim2.new(0.55, 0, 0, 30), 0.25, function()
                flySpeed = math.clamp(flySpeed - 10, 10, 200)
                flySpeedLabel.Text = "Velocidad de Fly: " .. flySpeed
            end)

            local upDownLabel = addLabel(contentFrame, "Distancia Up/Down: " .. upDownDistance, 0.4)
            local upButton = addButton(contentFrame, "Subir", UDim2.new(0.35, 0, 0, 40), 0.5, function() moveVertical(1) end)
            local downButton = addButton(contentFrame, "Bajar", UDim2.new(0.55, 0, 0, 40), 0.5, function() moveVertical(-1) end)
            local upDownPlus = addButton(contentFrame, "+", UDim2.new(0.35, 0, 0, 30), 0.65, function()
                upDownDistance = math.clamp(upDownDistance + 10, 5, 100)
                upDownLabel.Text = "Distancia Up/Down: " .. upDownDistance
            end)
            local upDownMinus = addButton(contentFrame, "-", UDim2.new(0.55, 0, 0, 30), 0.65, function()
                upDownDistance = math.clamp(upDownDistance - 10, 5, 100)
                upDownLabel.Text = "Distancia Up/Down: " .. upDownDistance
            end)

            local speedLabel = addLabel(contentFrame, "Velocidad: " .. walkSpeed, 0.8)
            local speedPlus = addButton(contentFrame, "+", UDim2.new(0.35, 0, 0, 30), 0.9, function()
                updateSpeed(walkSpeed + 10)
                speedLabel.Text = "Velocidad: " .. walkSpeed
            end)
            local speedMinus = addButton(contentFrame, "-", UDim2.new(0.55, 0, 0, 30), 0.9, function()
                updateSpeed(walkSpeed - 10)
                speedLabel.Text = "Velocidad: " .. walkSpeed
            end)
            contentFrame.CanvasSize = UDim2.new(0, 0, 1.2, 0)
        elseif tabName == "Combate" then
            local aimbotBasicToggle = addButton(contentFrame, aimbotBasicEnabled and "Desactivar Aimbot Básico" or "Activar Aimbot Básico", UDim2.new(0.8, 0, 0, 40), 0, function()
                toggleAimbot("basic")
                aimbotBasicToggle.Text = aimbotBasicEnabled and "Desactivar Aimbot Básico" or "Activar Aimbot Básico"
            end)
            local aimbotSmoothToggle = addButton(contentFrame, aimbotSmoothEnabled and "Desactivar Aimbot Suave" or "Activar Aimbot Suave", UDim2.new(0.8, 0, 0, 40), 0.15, function()
                toggleAimbot("smooth")
                aimbotSmoothToggle.Text = aimbotSmoothEnabled and "Desactivar Aimbot Suave" or "Activar Aimbot Suave"
            end)
            local aimbotSilentToggle = addButton(contentFrame, aimbotSilentEnabled and "Desactivar Aimbot Silencioso" or "Activar Aimbot Silencioso", UDim2.new(0.8, 0, 0, 40), 0.3, function()
                toggleAimbot("silent")
                aimbotSilentToggle.Text = aimbotSilentEnabled and "Desactivar Aimbot Silencioso" or "Activar Aimbot Silencioso"
            end)

            local aimPartLabel = addLabel(contentFrame, "Parte a Apuntar: " .. aimPart, 0.45)
            addButton(contentFrame, "Cabeza", UDim2.new(0.35, 0, 0, 30), 0.55, function()
                aimPart = "Head"
                aimPartLabel.Text = "Parte a Apuntar: " .. aimPart
            end)
            addButton(contentFrame, "Torso", UDim2.new(0.55, 0, 0, 30), 0.55, function()
                aimPart = "HumanoidRootPart"
                aimPartLabel.Text = "Parte a Apuntar: " .. aimPart
            end)

            local fovLabel = addLabel(contentFrame, "FOV: " .. aimFOV, 0.7)
            addButton(contentFrame, "+", UDim2.new(0.35, 0, 0, 30), 0.8, function()
                aimFOV = math.clamp(aimFOV + 10, 50, 200)
                fovLabel.Text = "FOV: " .. aimFOV
            end)
            addButton(contentFrame, "-", UDim2.new(0.55, 0, 0, 30), 0.8, function()
                aimFOV = math.clamp(aimFOV - 10, 50, 200)
                fovLabel.Text = "FOV: " .. aimFOV
            end)
            contentFrame.CanvasSize = UDim2.new(0, 0, 1, 0)
        elseif tabName == "Información" then
            local espToggle = addButton(contentFrame, espEnabled and "Desactivar ESP" or "Activar ESP", UDim2.new(0.8, 0, 0, 40), 0, function()
                toggleESP()
                espToggle.Text = espEnabled and "Desactivar ESP" or "Activar ESP"
            end)
            local boxToggle = addButton(contentFrame, boxEnabled and "Desactivar Box" or "Activar Box", UDim2.new(0.8, 0, 0, 40), 0.15, function()
                boxEnabled = not boxEnabled
                boxToggle.Text = boxEnabled and "Desactivar Box" or "Activar Box"
                updateChams()
            end)
            local linesToggle = addButton(contentFrame, linesEnabled and "Desactivar Lines" or "Activar Lines", UDim2.new(0.8, 0, 0, 40), 0.3, function()
                linesEnabled = not linesEnabled
                linesToggle.Text = linesEnabled and "Desactivar Lines" or "Activar Lines"
                updateChams()
            end)

            local outlineColorLabel = addLabel(contentFrame, "Color del Borde", 0.45)
            for i, color in ipairs(colors) do
                local x = 0.1 + ((i-1) % 4) * 0.12
                local y = 0.55 + math.floor((i-1) / 4) * 0.15
                local button = Instance.new("TextButton")
                button.Size = UDim2.new(0, 30, 0, 30)
                button.Position = UDim2.new(x, 0, y, 0)
                button.BackgroundColor3 = color
                button.Text = ""
                button.ZIndex = 3
                button.Parent = contentFrame
                local corner = Instance.new("UICorner")
                corner.CornerRadius = UDim.new(0, 6)
                corner.Parent = button
                button.Activated:Connect(function()
                    outlineColor = color
                    updateChams()
                end)
                print("Outline Color Button " .. i .. " creado en x=" .. x .. ", y=" .. y)
            end

            local fillToggle = addButton(contentFrame, fillEnabled and "Relleno: On" or "Relleno: Off", UDim2.new(0.2, 0, 0, 30), 0.85, function()
                fillEnabled = not fillEnabled
                fillToggle.Text = fillEnabled and "Relleno: On" or "Relleno: Off"
                updateChams()
            end)
            local fillColorLabel = addLabel(contentFrame, "Color del Relleno", 1.0)
            for i, color in ipairs(colors) do
                local x = 0.1 + ((i-1) % 4) * 0.12
                local y = 1.1 + math.floor((i-1) / 4) * 0.15
                local button = Instance.new("TextButton")
                button.Size = UDim2.new(0, 30, 0, 30)
                button.Position = UDim2.new(x, 0, y, 0)
                button.BackgroundColor3 = color
                button.Text = ""
                button.ZIndex = 3
                button.Parent = contentFrame
                local corner = Instance.new("UICorner")
                corner.CornerRadius = UDim.new(0, 6)
                corner.Parent = button
                button.Activated:Connect(function()
                    fillColor = color
                    updateChams()
                end)
                print("Fill Color Button " .. i .. " creado en x=" .. x .. ", y=" .. y)
            end

            local serverInfo = addLabel(contentFrame, "Cargando info...", 1.4)
            spawn(function()
                while contentFrame.Parent do
                    local health = player.Character and player.Character:FindFirstChild("Humanoid") and math.floor(player.Character.Humanoid.Health) or 0
                    local maxHealth = player.Character and player.Character:FindFirstChild("Humanoid") and math.floor(player.Character.Humanoid.MaxHealth) or 100
                    serverInfo.Text = string.format("Jugador: %s | Salud: %d/%d | Servidor: %s | Ping: %d", 
                            player.Name, health, maxHealth, game.JobId, game:GetService("Stats").Network.ServerStatsItem["Ping"]:GetValue())
                    wait(1)
                end
            end)
            contentFrame.CanvasSize = UDim2.new(0, 0, 1.6, 0)
        elseif tabName == "Avanzado" then
            local noClipToggle = addButton(contentFrame, noClipEnabled and "Desactivar NoClip" or "Activar NoClip", UDim2.new(0.8, 0, 0, 40), 0, function()
                toggleNoClip()
                noClipToggle.Text = noClipEnabled and "Desactivar NoClip" or "Activar NoClip"
            end)
            local infiniteJumpToggle = addButton(contentFrame, infiniteJumpEnabled and "Desactivar Infinite Jump" or "Activar Infinite Jump", UDim2.new(0.8, 0, 0, 40), 0.15, function()
                toggleInfiniteJump()
                infiniteJumpToggle.Text = infiniteJumpEnabled and "Desactivar Infinite Jump" or "Activar Infinite Jump"
            end)
            local autoFarmToggle = addButton(contentFrame, autoFarmEnabled and "Desactivar Auto-Farm" or "Activar Auto-Farm", UDim2.new(0.8, 0, 0, 40), 0.3, function()
                toggleAutoFarm()
                autoFarmToggle.Text = autoFarmEnabled and "Desactivar Auto-Farm" or "Activar Auto-Farm"
            end)
            local godModeToggle = addButton(contentFrame, godModeEnabled and "Desactivar God Mode" or "Activar God Mode", UDim2.new(0.8, 0, 0, 40), 0.45, function()
                toggleGodMode()
                godModeToggle.Text = godModeEnabled and "Desactivar God Mode" or "Activar God Mode"
            end)
            contentFrame.CanvasSize = UDim2.new(0, 0, 0.6, 0)
        elseif tabName == "Otros" then
            addButton(contentFrame, "Server Hop", UDim2.new(0.8, 0, 0, 40), 0, serverHop)
            addButton(contentFrame, "Rejoin", UDim2.new(0.8, 0, 0, 40), 0.15, rejoin)
            addButton(contentFrame, "FPS Unlocker", UDim2.new(0.8, 0, 0, 40), 0.3, unlockFPS)
            addButton(contentFrame, "Chat Spoofer", UDim2.new(0.8, 0, 0, 40), 0.45, function()
                chatSpoofer("Mensaje de prueba", player)
            end)
            contentFrame.CanvasSize = UDim2.new(0, 0, 0.6, 0)
        end
    end

    for tabName, button in pairs(tabButtons) do
        button.Activated:Connect(function()
            debugLabel.Text = "Pestaña " .. tabName .. " clickeada"
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
            frame.Size = UDim2.new(0, 300, 0, 40)
            tabFrame.Visible = false
            contentFrame.Visible = false
            minimizeButton.Text = "+"
            debugLabel.Text = "Menú minimizado"
            print("Menú minimizado")
        else
            frame.Size = UDim2.new(0, 300, 0, 350)
            tabFrame.Visible = true
            contentFrame.Visible = true
            minimizeButton.Text = "-"
            if currentTab then
                createTabContent(currentTab)
            end
            debugLabel.Text = "Menú restaurado"
            print("Menú Restaurado")
        end
    end

    local function toggleMenu()
        frame.Visible = not frame.Visible
        debugLabel.Text = frame.Visible and "Menú abierto" or "Menú cerrado"
        print(frame.Visible and "Menú abierto" or "Menú cerrado")
        if isMinimized and frame.Visible then
            toggleMinimize()
        end
    end

    closeButton.Activated:Connect(function()
        debugLabel.Text = "Botón Cerrar clickeado"
        print("Botón Cerrar clickeado")
        if espConnection then
            espConnection:Disconnect()
        end
        if flyEnabled then
            stopFly()
        end
        if noClipConnection then
            toggleNoClip()
        end
        if jumpConnection then
            toggleInfiniteJump()
        end
        if autoFarmConnection then
            toggleAutoFarm()
        end
        if aimbotConnection then
            toggleAimbot("")
        end
        screenGui:Destroy()
    end)

    minimizeButton.Activated:Connect(function()
        debugLabel.Text = "Botón Minimizar clickeado"
        print("Botón Minimizar clickeado")
        toggleMinimize()
    end)

    toggleButton.Activated:Connect(function()
        debugLabel.Text = "Botón de toggle clickeado"
        print("Botón de toggle clickeado")
        toggleMenu()
    end)

    userInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.KeyCode == Enum.KeyCode.E then
            debugLabel.Text = "Tecla E presionada"
            print("Tecla E presionada")
            toggleMenu()
        end
    end)

    game.Players.PlayerAdded:Connect(function(plr)
        if espEnabled and plr ~= player then
            plr.CharacterAdded:Connect(function(character)
                if espEnabled then
                    applyESP(character)
                end
            end)
        end
    end)

    game.Players.PlayerRemoving:Connect(function(plr)
        if espObjects[plr.Character] then
            for _, obj in pairs(espObjects[plr.Character]) do
                obj:Destroy()
            end
            espObjects[plr.Character] = nil
        end
    end)

    createTabContent("Main")
    tabButtons["Main"].BackgroundColor3 = Color3.fromRGB(40, 40, 70)
    currentTab = "Main"
    debugLabel.Text = "Infinix Cheats cargado. Toca ☰ para abrir."
    print("Infinix Cheats inicializado")
end)

if not success then
    print("Error en Infinix Cheats: " .. tostring(errorMsg))
    local player = game.Players.LocalPlayer
    local playerGui = player:FindFirstChild("PlayerGui")
    if playerGui then
        local screenGui = Instance.new("ScreenGui")
        screenGui.Name = "ErrorGui"
        screenGui.Parent = playerGui
        local errorLabel = Instance.new("TextLabel")
        errorLabel.Size = UDim2.new(1, 0, 0, 50)
        errorLabel.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        errorLabel.BackgroundTransparency = 0.5
        errorLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        errorLabel.Text = "Error: " .. tostring(errorMsg)
        errorLabel.TextWrapped = true
        errorLabel.Parent = screenGui
    end
end