-- Aguarda o jogo carregar completamente
if not game:IsLoaded() then
    game.Loaded:Wait()
end

local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Remove menu antigo se existir
local oldMenu = playerGui:FindFirstChild("ServerHopMenu")
if oldMenu then oldMenu:Destroy() end

local screenGui = Instance.new("ScreenGui")
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.DisplayOrder = 999
screenGui.Name = "ServerHopMenu"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- ==================== SISTEMA DE SOM ====================
local notifySound = Instance.new("Sound", screenGui)
notifySound.SoundId = "rbxassetid://4590662766"
notifySound.Volume = 0.5

local frame = Instance.new("Frame")
local titleLabel = Instance.new("TextLabel")
local textBoxFrame = Instance.new("Frame")
local textBox = Instance.new("TextBox")
local autoButtonFrame = Instance.new("Frame")
local autoButtonLabel = Instance.new("TextLabel")
local stopButtonFrame = Instance.new("Frame")
local stopButtonLabel = Instance.new("TextLabel")

frame.Parent = screenGui

frame.BackgroundColor3 = Color3.fromRGB(75, 0, 130)
frame.BackgroundTransparency = 0.3
frame.BorderSizePixel = 0
frame.Position = UDim2.new(0, 10, 0, 10)
frame.Size = UDim2.new(0, 250, 0, 320)
frame.AnchorPoint = Vector2.new(0, 0)
frame.ZIndex = 10

local corners = Instance.new("UICorner")
corners.Parent = frame
corners.CornerRadius = UDim.new(0, 12)

titleLabel.Parent = frame
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "SERVER HOP"
titleLabel.TextColor3 = Color3.fromRGB(180, 80, 255)
titleLabel.TextSize = 24
titleLabel.TextScaled = false
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Position = UDim2.new(0, 15, 0, 10)
titleLabel.Size = UDim2.new(0, 220, 0, 40)
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.ZIndex = 10

textBoxFrame.Parent = frame
textBoxFrame.BackgroundColor3 = Color3.fromRGB(50, 0, 100)
textBoxFrame.BackgroundTransparency = 0.2
textBoxFrame.BorderSizePixel = 0
textBoxFrame.Position = UDim2.new(0, 15, 0, 60)
textBoxFrame.Size = UDim2.new(0, 220, 0, 35)
textBoxFrame.ZIndex = 10

local textBoxCorners = Instance.new("UICorner")
textBoxCorners.Parent = textBoxFrame
textBoxCorners.CornerRadius = UDim.new(0, 8)

local textBoxStroke = Instance.new("UIStroke")
textBoxStroke.Name = "TextBoxBorder"
textBoxStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
textBoxStroke.Thickness = 4
textBoxStroke.Color = Color3.fromRGB(180, 80, 255)
textBoxStroke.Transparency = 0.3
textBoxStroke.Parent = textBoxFrame

local textBoxGrad = Instance.new("UIGradient")
textBoxGrad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(75, 0, 130)),
    ColorSequenceKeypoint.new(0.3, Color3.fromRGB(180, 80, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(130, 40, 210)),
    ColorSequenceKeypoint.new(0.7, Color3.fromRGB(180, 80, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(75, 0, 130)),
}
textBoxGrad.Rotation = 0
textBoxGrad.Parent = textBoxStroke

textBox.Parent = textBoxFrame
textBox.BackgroundTransparency = 1
textBox.Text = ""
textBox.TextColor3 = Color3.fromRGB(180, 80, 255)
textBox.TextSize = 12
textBox.TextScaled = false
textBox.Font = Enum.Font.Gotham
textBox.Position = UDim2.new(0, 5, 0, 5)
textBox.Size = UDim2.new(0, 210, 0, 25)
textBox.TextXAlignment = Enum.TextXAlignment.Left
textBox.TextYAlignment = Enum.TextYAlignment.Center
textBox.TextWrapped = false
textBox.ClearTextOnFocus = false
textBox.MultiLine = false
textBox.PlaceholderText = "Valor mínimo (ex: 1000000)"
textBox.ZIndex = 11

local function filterNumbers(input)
    local filtered = input:gsub("[^%d]", "")
    return filtered
end

textBox:GetPropertyChangedSignal("Text"):Connect(function()
    local originalText = textBox.Text
    local filteredText = filterNumbers(originalText)
    
    if originalText ~= filteredText then
        textBox.Text = filteredText
        textBox.CursorPosition = #filteredText + 1
    end
end)

textBox.FocusLost:Connect(function()
    local originalText = textBox.Text
    local filteredText = filterNumbers(originalText)
    
    if originalText ~= filteredText then
        textBox.Text = filteredText
    end
end)

autoButtonFrame.Parent = frame
autoButtonFrame.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
autoButtonFrame.BackgroundTransparency = 0.2
autoButtonFrame.BorderSizePixel = 0
autoButtonFrame.Position = UDim2.new(0, 15, 0, 105)
autoButtonFrame.Size = UDim2.new(0, 220, 0, 35)
autoButtonFrame.AnchorPoint = Vector2.new(0, 0)
autoButtonFrame.ZIndex = 10

local autoButtonCorners = Instance.new("UICorner")
autoButtonCorners.Parent = autoButtonFrame
autoButtonCorners.CornerRadius = UDim.new(0, 8)

local autoButtonStroke = Instance.new("UIStroke")
autoButtonStroke.Name = "AutoButtonBorder"
autoButtonStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
autoButtonStroke.Thickness = 4
autoButtonStroke.Color = Color3.fromRGB(0, 255, 0)
autoButtonStroke.Transparency = 0.3
autoButtonStroke.Parent = autoButtonFrame

local autoButtonGrad = Instance.new("UIGradient")
autoButtonGrad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 50, 0)),
    ColorSequenceKeypoint.new(0.3, Color3.fromRGB(0, 255, 0)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 150, 0)),
    ColorSequenceKeypoint.new(0.7, Color3.fromRGB(0, 255, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 50, 0)),
}
autoButtonGrad.Rotation = 0
autoButtonGrad.Parent = autoButtonStroke

autoButtonLabel.Parent = autoButtonFrame
autoButtonLabel.BackgroundTransparency = 1
autoButtonLabel.Text = "MODO AUTOMATICO"
autoButtonLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
autoButtonLabel.TextSize = 12
autoButtonLabel.TextScaled = false
autoButtonLabel.Font = Enum.Font.GothamBold
autoButtonLabel.Size = UDim2.new(1, 0, 1, 0)
autoButtonLabel.TextXAlignment = Enum.TextXAlignment.Center
autoButtonLabel.TextYAlignment = Enum.TextYAlignment.Center
autoButtonLabel.ZIndex = 11

stopButtonFrame.Parent = frame
stopButtonFrame.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
stopButtonFrame.BackgroundTransparency = 0.2
stopButtonFrame.BorderSizePixel = 0
stopButtonFrame.Position = UDim2.new(0, 15, 0, 150)
stopButtonFrame.Size = UDim2.new(0, 220, 0, 35)
stopButtonFrame.AnchorPoint = Vector2.new(0, 0)
stopButtonFrame.ZIndex = 10

local stopButtonCorners = Instance.new("UICorner")
stopButtonCorners.Parent = stopButtonFrame
stopButtonCorners.CornerRadius = UDim.new(0, 8)

local stopButtonStroke = Instance.new("UIStroke")
stopButtonStroke.Name = "StopButtonBorder"
stopButtonStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
stopButtonStroke.Thickness = 4
stopButtonStroke.Color = Color3.fromRGB(255, 0, 0)
stopButtonStroke.Transparency = 0.3
stopButtonStroke.Parent = stopButtonFrame

local stopButtonGrad = Instance.new("UIGradient")
stopButtonGrad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 0, 0)),
    ColorSequenceKeypoint.new(0.3, Color3.fromRGB(255, 0, 0)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(150, 0, 0)),
    ColorSequenceKeypoint.new(0.7, Color3.fromRGB(255, 0, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 0, 0)),
}
stopButtonGrad.Rotation = 0
stopButtonGrad.Parent = stopButtonStroke

stopButtonLabel.Parent = stopButtonFrame
stopButtonLabel.BackgroundTransparency = 1
stopButtonLabel.Text = "PARAR"
stopButtonLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
stopButtonLabel.TextSize = 12
stopButtonLabel.TextScaled = false
stopButtonLabel.Font = Enum.Font.GothamBold
stopButtonLabel.Size = UDim2.new(1, 0, 1, 0)
stopButtonLabel.TextXAlignment = Enum.TextXAlignment.Center
stopButtonLabel.TextYAlignment = Enum.TextYAlignment.Center
stopButtonLabel.ZIndex = 11

local stroke = Instance.new("UIStroke")
stroke.Name = "RacetrackBorder"
stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
stroke.Thickness = 6
stroke.Color = Color3.fromRGB(180, 80, 255)
stroke.Transparency = 0.3
stroke.Parent = frame

local grad = Instance.new("UIGradient")
grad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(75, 0, 130)),
    ColorSequenceKeypoint.new(0.3, Color3.fromRGB(180, 80, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(130, 40, 210)),
    ColorSequenceKeypoint.new(0.7, Color3.fromRGB(180, 80, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(75, 0, 130)),
}
grad.Rotation = 0
grad.Parent = stroke

-- ==================== CLEAN ERROR GUIS ====================
task.spawn(function()
    local GuiService = cloneref and cloneref(game:GetService("GuiService")) or game:GetService("GuiService")
    while true do
        pcall(function() 
            GuiService:ClearError() 
        end)
        task.wait(0.005)
    end
end)

-- ==================== LÓGICA DO MODO AUTOMÁTICO ====================

local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

-- ==================== VARIÁVEIS ====================
local hopActive = true  -- Começa ligado
local autoModeEnabled = true  -- Começa ligado

local statusLabel = Instance.new("TextLabel", frame)
statusLabel.Size = UDim2.new(1, -30, 0, 20)
statusLabel.Position = UDim2.new(0, 15, 0, 195)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "Auto: Ligado - Buscando..."
statusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
statusLabel.TextSize = 10
statusLabel.Font = Enum.Font.GothamBold
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.ZIndex = 10

-- Label de brainrot (notificação no menu)
local brainrotLabel = Instance.new("TextLabel", frame)
brainrotLabel.Size = UDim2.new(1, -30, 0, 28)
brainrotLabel.Position = UDim2.new(0, 15, 0, 215)
brainrotLabel.BackgroundTransparency = 1
brainrotLabel.Text = ""
brainrotLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
brainrotLabel.TextSize = 9
brainrotLabel.Font = Enum.Font.GothamBold
brainrotLabel.TextXAlignment = Enum.TextXAlignment.Left
brainrotLabel.TextWrapped = true
brainrotLabel.ZIndex = 10

-- Sistema de Blacklist
local folderName = "SkyHub"
local blacklistFile = folderName .. "/ServerBlacklist.json"
local serverBlacklist = {}

if makefolder and not isfolder(folderName) then
    makefolder(folderName)
end

local function loadBlacklist()
    if isfile and isfile(blacklistFile) then
        local success, data = pcall(function()
            return HttpService:JSONDecode(readfile(blacklistFile))
        end)
        if success and type(data) == "table" then
            serverBlacklist = data
        end
    end
end

local function saveBlacklist()
    if writefile then
        writefile(blacklistFile, HttpService:JSONEncode(serverBlacklist))
    end
end

local function addServerToBlacklist(id)
    if not id then return end
    table.insert(serverBlacklist, id)
    if #serverBlacklist >= 300 then
        serverBlacklist = {}
    end
    saveBlacklist()
end

local function isBlacklisted(id)
    for _, v in pairs(serverBlacklist) do
        if v == id then return true end
    end
    return false
end

-- Função parseValue para números (K/M/B)
local function parseValue(text)
    text = text:lower()
    local num = tonumber(text:match("[%d%.]+"))
    if not num then return 0 end
    
    if text:match("%d+%.?%d*%s*k") then num = num * 1000
    elseif text:match("%d+%.?%d*%s*m") then num = num * 1000000
    elseif text:match("%d+%.?%d*%s*b") then num = num * 1000000000
    end
    
    return num
end

local function formatValue(n)
    if n >= 1000000000 then return string.format("%.1fb", n/1000000000)
    elseif n >= 1000000 then return string.format("%.1fm", n/1000000)
    elseif n >= 1000 then return string.format("%.1fk", n/1000)
    else return tostring(n)
    end
end

-- Server Hop principal
local function doServerHop()
    if not hopActive then return end
    
    statusLabel.Text = "Status: Iniciando busca..."
    
    local placeId = game.PlaceId
    local url = "https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?sortOrder=Asc&limit=100"
    
    local success, content = pcall(function()
        return game:HttpGet(url)
    end)
    
    if not success or not content or not hopActive then
        statusLabel.Text = "Status: Erro ou Parado"
        return
    end
    
    local decoded = HttpService:JSONDecode(content)
    
    if decoded and decoded.data then
        for _, server in ipairs(decoded.data) do
            if not hopActive then break end
            
            if server.playing < server.maxPlayers 
            and server.id ~= game.JobId 
            and not isBlacklisted(server.id) then
                
                addServerToBlacklist(server.id)
                statusLabel.Text = "Status: Teleportando..."
                
                pcall(function()
                    if autoModeEnabled then
                        if writefile then
                            writefile(folderName .. "/AutoMode.txt", "true")
                        end
                    end
                    TeleportService:TeleportToPlaceInstance(placeId, server.id, player)
                end)
                
                task.wait(2)
            end
        end
        
        if hopActive then
            statusLabel.Text = "Status: Nenhum serv. livre"
            if autoModeEnabled then
                task.wait(2)
                doServerHop()
            end
        end
    else
        statusLabel.Text = "Status: Lista vazia (tentando novamente...)"
        if autoModeEnabled and hopActive then
            task.wait(2)
            doServerHop()
        end
    end
end

-- ==================== DETECÇÃO DE BRAINROT ====================
local detectedBrainrots = {}

local function scanOverhead(overhead)
    local name = nil
    local income = nil
    
    for _, gui in pairs(overhead:GetDescendants()) do
        if gui:IsA("TextLabel") then
            local text = gui.Text
            if text:find("%$") and (text:lower():find("/s") or text:lower():find("sec")) then
                income = text
            elseif not text:find("%$") and text ~= "STOLEN" and #text > 2 then
                name = text
            end
        end
    end
    
    if income then
        local value = parseValue(income)
        local brainrotKey = (name or "Brainrot") .. income
        
        if value >= 10000000 and not detectedBrainrots[brainrotKey] then
            detectedBrainrots[brainrotKey] = true
            
            pcall(function()
                notifySound:Play()
            end)
            
            brainrotLabel.Text = "🧠 BRAINROT: " .. (name or "Brainrot") .. " | " .. income
            statusLabel.Text = "Brainrot detectado!"
            statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
            
            task.delay(5, function()
                if brainrotLabel.Text == ("🧠 BRAINROT: " .. (name or "Brainrot") .. " | " .. income) then
                    brainrotLabel.Text = ""
                    if autoModeEnabled then
                        statusLabel.Text = "Auto: Ligado - Buscando..."
                        statusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
                    else
                        statusLabel.Text = "Status: Aguardando"
                        statusLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
                    end
                end
            end)
        end
    end
end

workspace.DescendantAdded:Connect(function(descendant)
    if descendant.Name:lower():find("overhead") then
        task.wait(0.1)
        scanOverhead(descendant)
    end
    
    if descendant:IsA("Model") then
        local overhead = descendant:FindFirstChild("Overhead") or descendant:FindFirstChild("AnimalOverhead")
        if overhead then
            task.wait(0.1)
            scanOverhead(overhead)
        end
    end
end)

task.spawn(function()
    task.wait(1)
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj.Name:lower():find("overhead") then
            scanOverhead(obj)
        end
    end
end)

-- Botão MODO AUTOMATICO
autoButtonFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        autoModeEnabled = not autoModeEnabled
        
        if autoModeEnabled then
            autoButtonFrame.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
            autoButtonStroke.Thickness = 6
            autoButtonLabel.TextColor3 = Color3.fromRGB(150, 255, 150)
            hopActive = true
            statusLabel.Text = "Auto: Ligado - Buscando..."
            statusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
            brainrotLabel.Text = ""
            
            local target = tonumber(textBox.Text)
            if target and target > 0 then
                statusLabel.Text = "Status: Verificando alvo " .. formatValue(target)
                task.wait(1)
                if not hopActive then return end
                
                local maxFound = 0
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj.Name:lower():find("overhead") then
                        for _, gui in pairs(obj:GetDescendants()) do
                            if gui:IsA("TextLabel") then
                                local text = gui.Text:lower()
                                if text:find("%$") and (text:find("/s") or text:find("sec")) then
                                    local val = parseValue(text)
                                    if val > maxFound then maxFound = val end
                                end
                            end
                        end
                    end
                end
                
                if maxFound >= target then
                    statusLabel.Text = "Alvo " .. formatValue(target) .. "+ Detectado!"
                    statusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
                    hopActive = false
                    autoModeEnabled = false
                    autoButtonFrame.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
                    autoButtonStroke.Thickness = 4
                    autoButtonLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
                else
                    doServerHop()
                end
            else
                doServerHop()
            end
        else
            autoButtonFrame.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
            autoButtonStroke.Thickness = 4
            autoButtonLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
            hopActive = false
            statusLabel.Text = "Auto: Desligado"
            statusLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
        end
        
        autoButtonFrame.BackgroundTransparency = 0.1
        task.wait(0.1)
        autoButtonFrame.BackgroundTransparency = 0.2
    end
end)

-- Botão PARAR
stopButtonFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        stopButtonFrame.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
        stopButtonFrame.BackgroundTransparency = 0.1
        stopButtonStroke.Thickness = 6
        
        hopActive = false
        autoModeEnabled = false
        statusLabel.Text = "Status: Parado"
        statusLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
        
        autoButtonFrame.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
        autoButtonStroke.Thickness = 4
        autoButtonLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
        
        task.wait(0.2)
        stopButtonFrame.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
        stopButtonFrame.BackgroundTransparency = 0.2
        stopButtonStroke.Thickness = 4
    end
end)

-- Auto Mode Recovery (delay reduzido para 2 segundos)
task.spawn(function()
    if isfile and isfile(folderName .. "/AutoMode.txt") then
        local data = readfile(folderName .. "/AutoMode.txt")
        if data == "true" then
            autoModeEnabled = true
            hopActive = true
            statusLabel.Text = "Auto: Retomado"
            autoButtonFrame.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
            autoButtonStroke.Thickness = 6
            autoButtonLabel.TextColor3 = Color3.fromRGB(150, 255, 150)
            delfile(folderName .. "/AutoMode.txt")
            
            repeat task.wait() until player.Character
            task.wait(2)
            
            if hopActive then
                doServerHop()
            end
        end
    end
end)

loadBlacklist()

-- Inicia a busca automaticamente ao carregar o script
task.spawn(function()
    -- Aguarda o personagem carregar
    repeat task.wait() until player.Character
    task.wait(2)
    
    -- Se o modo automático estiver ligado, começa a buscar
    if autoModeEnabled and hopActive then
        -- Verifica se tem valor alvo
        local target = tonumber(textBox.Text)
        if target and target > 0 then
            statusLabel.Text = "Status: Verificando alvo " .. formatValue(target)
            task.wait(1)
            
            local maxFound = 0
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj.Name:lower():find("overhead") then
                    for _, gui in pairs(obj:GetDescendants()) do
                        if gui:IsA("TextLabel") then
                            local text = gui.Text:lower()
                            if text:find("%$") and (text:find("/s") or text:find("sec")) then
                                local val = parseValue(text)
                                if val > maxFound then maxFound = val end
                            end
                        end
                    end
                end
            end
            
            if maxFound >= target then
                statusLabel.Text = "Alvo " .. formatValue(target) .. "+ Detectado!"
                statusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
                hopActive = false
                autoModeEnabled = false
                autoButtonFrame.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
                autoButtonStroke.Thickness = 4
                autoButtonLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
            else
                doServerHop()
            end
        else
            doServerHop()
        end
    end
end)

-- ==================== ANIMAÇÃO DAS BORDAS ====================

local RunService = game:GetService("RunService")
local startTime = tick()
local lastUp = 0
local conn

conn = RunService.Heartbeat:Connect(function()
    if not frame.Parent then
        conn:Disconnect()
        return
    end
    local now = tick()
    if now - lastUp < 0.016 then return end
    lastUp = now

    local W = frame.AbsoluteSize.X
    local H = frame.AbsoluteSize.Y
    if W > 0 and H > 0 then
        local speed = 2.5
        local perim = (W + H) * 2
        local elapsed = (now - startTime) % speed
        local progress = elapsed / speed
        local dist = (progress * perim) % perim
        local rot = 0

        if dist < W then
            rot = (dist / W) * 90
        elseif dist < W + H then
            rot = 90 + ((dist - W) / H) * 90
        elseif dist < W * 2 + H then
            rot = 180 + ((dist - W - H) / W) * 90
        else
            rot = 270 + ((dist - W * 2 - H) / H) * 90
        end

        grad.Rotation = rot

        local wave = math.sin(progress * math.pi * 2)
        local intensity = (wave + 1) * 0.5
        stroke.Transparency = 0.05 + intensity * 0.4
        stroke.Thickness = 6 + math.sin(now * 5) * 0.15
    end
    
    local textW = textBoxFrame.AbsoluteSize.X
    local textH = textBoxFrame.AbsoluteSize.Y
    if textW > 0 and textH > 0 then
        local textPerim = (textW + textH) * 2
        local elapsed = (now - startTime) % 2.5
        local progress = elapsed / 2.5
        local textDist = (progress * textPerim) % textPerim
        local textRot = 0
        
        if textDist < textW then
            textRot = (textDist / textW) * 90
        elseif textDist < textW + textH then
            textRot = 90 + ((textDist - textW) / textH) * 90
        elseif textDist < textW * 2 + textH then
            textRot = 180 + ((textDist - textW - textH) / textW) * 90
        else
            textRot = 270 + ((textDist - textW * 2 - textH) / textH) * 90
        end
        
        textBoxGrad.Rotation = textRot
        textBoxStroke.Transparency = 0.1 + (math.sin(progress * math.pi * 2) + 1) * 0.5 * 0.4
        textBoxStroke.Thickness = 3 + math.sin(now * 5.5) * 0.1
    end
    
    local btnW = autoButtonFrame.AbsoluteSize.X
    local btnH = autoButtonFrame.AbsoluteSize.Y
    if btnW > 0 and btnH > 0 then
        local btnPerim = (btnW + btnH) * 2
        local elapsed = (now - startTime) % 2.5
        local progress = elapsed / 2.5
        local btnDist = (progress * btnPerim) % btnPerim
        local btnRot = 0
        
        if btnDist < btnW then
            btnRot = (btnDist / btnW) * 90
        elseif btnDist < btnW + btnH then
            btnRot = 90 + ((btnDist - btnW) / btnH) * 90
        elseif btnDist < btnW * 2 + btnH then
            btnRot = 180 + ((btnDist - btnW - btnH) / btnW) * 90
        else
            btnRot = 270 + ((btnDist - btnW * 2 - btnH) / btnH) * 90
        end
        
        autoButtonGrad.Rotation = btnRot
        local wave = math.sin(progress * math.pi * 2)
        autoButtonStroke.Transparency = 0.1 + (wave + 1) * 0.5 * 0.4
        
        if autoModeEnabled then
            autoButtonStroke.Thickness = 5 + math.sin(now * 8) * 0.2
        else
            autoButtonStroke.Thickness = 3 + math.sin(now * 5) * 0.1
        end
    end
    
    local stopW = stopButtonFrame.AbsoluteSize.X
    local stopH = stopButtonFrame.AbsoluteSize.Y
    if stopW > 0 and stopH > 0 then
        local stopPerim = (stopW + stopH) * 2
        local elapsed = (now - startTime) % 2.5
        local progress = elapsed / 2.5
        local stopDist = (progress * stopPerim) % stopPerim
        local stopRot = 0
        
        if stopDist < stopW then
            stopRot = (stopDist / stopW) * 90
        elseif stopDist < stopW + stopH then
            stopRot = 90 + ((stopDist - stopW) / stopH) * 90
        elseif stopDist < stopW * 2 + stopH then
            stopRot = 180 + ((stopDist - stopW - stopH) / stopW) * 90
        else
            stopRot = 270 + ((stopDist - stopW * 2 - stopH) / stopH) * 90
        end
        
        stopButtonGrad.Rotation = stopRot
        local wave = math.sin(progress * math.pi * 2)
        stopButtonStroke.Transparency = 0.1 + (wave + 1) * 0.5 * 0.4
        stopButtonStroke.Thickness = 3 + math.sin(now * 5) * 0.1
    end
end)
