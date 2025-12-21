-- VIP用户名单（请在此处添加VIP用户名）
local VIP_USERS = {
    "hnperezho647",  -- 示例用户1
    "wuckdfs",  -- 示例用户2
    "Player3",  -- 示例用户3
    -- 在此处添加更多VIP用户名
}

-- 获取当前玩家用户名
local localPlayer = game:GetService("Players").LocalPlayer
local playerName = localPlayer.Name

-- 检查是否为VIP用户
local isVIP = false
for _, vipName in ipairs(VIP_USERS) do
    if vipName == playerName then
        isVIP = true
        break
    end
end

-- 1. 创建 UI 容器与文本标签
local LBLG = Instance.new("ScreenGui")
LBLG.Name = "LBLG"
LBLG.Parent = game.CoreGui
LBLG.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
LBLG.Enabled = true

-- 核心：单UI容器，避免冗余
local mainGui = Instance.new("ScreenGui")
mainGui.Name = "VIPTimeDisplay"
mainGui.Parent = game.CoreGui
mainGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
mainGui.Enabled = true

-- 容器优化：尺寸自适应，布局更紧凑
local container = Instance.new("Frame")
container.Name = "Container"
container.Parent = mainGui
container.BackgroundTransparency = 1
container.Position = UDim2.new(0.98, -5, 0.01, 5)
container.AnchorPoint = Vector2.new(1, 0)
container.Size = UDim2.new(0, 170, 0, 36)

-- 第一行：VIP时间显示（根据VIP状态显示不同内容）
local vipLabel = Instance.new("TextLabel")
vipLabel.Name = "VIPLabel"
vipLabel.Parent = container
vipLabel.BackgroundTransparency = 1
vipLabel.Position = UDim2.new(0, 0, 0, 0)
vipLabel.Size = UDim2.new(0, 75, 0, 18)
vipLabel.Font = Enum.Font.GothamBold
vipLabel.TextScaled = true
vipLabel.TextSize = 9
vipLabel.TextXAlignment = Enum.TextXAlignment.Right

-- 根据VIP状态设置不同的文本和颜色
if isVIP then
    vipLabel.Text = "金贵的VIP时间"
    vipLabel.TextColor3 = Color3.fromRGB(255, 215, 0)  -- 金色
else
    vipLabel.Text = "非VIP用户"
    vipLabel.TextColor3 = Color3.fromRGB(150, 150, 150)  -- 灰色
end

-- 发光效果（只有VIP有发光效果）
if isVIP then
    local vipGlow = Instance.new("UIStroke")
    vipGlow.Parent = vipLabel
    vipGlow.Color = Color3.fromRGB(255, 230, 100)
    vipGlow.Thickness = 1.2
    vipGlow.Transparency = 0.5
    vipGlow.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
end

-- 时间标签（所有用户都显示）
local timeLabel = Instance.new("TextLabel")
timeLabel.Name = "TimeLabel"
timeLabel.Parent = container
timeLabel.BackgroundTransparency = 1
timeLabel.Position = UDim2.new(0, 78, 0, 0)
timeLabel.Size = UDim2.new(0, 85, 0, 18)
timeLabel.Font = Enum.Font.GothamSemibold
timeLabel.Text = os.date("%H:%M:%S")
timeLabel.TextScaled = true
timeLabel.TextSize = 8.5
timeLabel.TextXAlignment = Enum.TextXAlignment.Left

-- 第二行：倒计时显示（所有用户都显示）
local toLabel = Instance.new("TextLabel")
toLabel.Name = "ToLabel"
toLabel.Parent = container
toLabel.BackgroundTransparency = 1
toLabel.Position = UDim2.new(0, 0, 0, 18)
toLabel.Size = UDim2.new(0, 12, 0, 18)
toLabel.Font = Enum.Font.GothamSemibold
toLabel.Text = "到"
toLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
toLabel.TextScaled = true
toLabel.TextSize = 8
toLabel.TextXAlignment = Enum.TextXAlignment.Right

-- 目标事件标签（可自定义，所有用户都显示）
local eventLabel = Instance.new("TextLabel")
eventLabel.Name = "EventLabel"
eventLabel.Parent = container
eventLabel.BackgroundTransparency = 1
eventLabel.Position = UDim2.new(0, 15, 0, 18)
eventLabel.Size = UDim2.new(0, 45, 0, 18)
eventLabel.Font = Enum.Font.GothamSemibold
eventLabel.Text = "元旦"
eventLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
eventLabel.TextScaled = true
eventLabel.TextSize = 8
eventLabel.TextXAlignment = Enum.TextXAlignment.Left

-- "还有"标签（所有用户都显示）
local leftLabel = Instance.new("TextLabel")
leftLabel.Name = "LeftLabel"
leftLabel.Parent = container
leftLabel.BackgroundTransparency = 1
leftLabel.Position = UDim2.new(0, 62, 0, 18)
leftLabel.Size = UDim2.new(0, 25, 0, 18)
leftLabel.Font = Enum.Font.GothamSemibold
leftLabel.Text = "还有"
leftLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
leftLabel.TextScaled = true
leftLabel.TextSize = 8
leftLabel.TextXAlignment = Enum.TextXAlignment.Right

-- 详细时间显示（所有用户都显示）
local detailLabel = Instance.new("TextLabel")
detailLabel.Name = "DetailLabel"
detailLabel.Parent = container
detailLabel.BackgroundTransparency = 1
detailLabel.Position = UDim2.new(0, 90, 0, 18)
detailLabel.Size = UDim2.new(0, 80, 0, 18)
detailLabel.Font = Enum.Font.GothamBold
detailLabel.Text = "计算中..."
detailLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
detailLabel.TextScaled = true
detailLabel.TextSize = 8
detailLabel.TextXAlignment = Enum.TextXAlignment.Left

-- ============ 弹窗系统 ============
-- 创建弹窗背景
local popupBackground = Instance.new("Frame")
popupBackground.Name = "PopupBackground"
popupBackground.Parent = mainGui
popupBackground.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
popupBackground.BackgroundTransparency = 0.7
popupBackground.Size = UDim2.new(1, 0, 1, 0)
popupBackground.Position = UDim2.new(0, 0, 0, 0)
popupBackground.Visible = false
popupBackground.ZIndex = 10

-- 创建弹窗主容器
local popupContainer = Instance.new("Frame")
popupContainer.Name = "PopupContainer"
popupContainer.Parent = popupBackground
popupContainer.AnchorPoint = Vector2.new(0.5, 0.5)
popupContainer.Position = UDim2.new(0.5, 0, 0.5, 0)
popupContainer.Size = UDim2.new(0, 300, 0, 200)
popupContainer.BackgroundTransparency = 0.1
popupContainer.ZIndex = 11

-- VIP弹窗（金色豪华效果）
local vipPopup = Instance.new("Frame")
vipPopup.Name = "VIPPopup"
vipPopup.Parent = popupContainer
vipPopup.Size = UDim2.new(1, 0, 1, 0)
vipPopup.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
vipPopup.BorderSizePixel = 0
vipPopup.Visible = isVIP  -- 只有VIP显示

-- VIP弹窗边框（金色流光）
local vipBorder = Instance.new("UIStroke")
vipBorder.Parent = vipPopup
vipBorder.Color = Color3.fromRGB(255, 215, 0)
vipBorder.Thickness = 3
vipBorder.Transparency = 0.2

-- VIP弹窗标题
local vipTitle = Instance.new("TextLabel")
vipTitle.Name = "VIPTitle"
vipTitle.Parent = vipPopup
vipTitle.BackgroundTransparency = 1
vipTitle.Size = UDim2.new(1, 0, 0, 40)
vipTitle.Position = UDim2.new(0, 0, 0, 10)
vipTitle.Font = Enum.Font.GothamBold
vipTitle.Text = "✨ VIP 尊贵特权 ✨"
vipTitle.TextColor3 = Color3.fromRGB(255, 215, 0)
vipTitle.TextSize = 20
vipTitle.TextScaled = false

-- VIP弹窗内容
local vipContent = Instance.new("TextLabel")
vipContent.Name = "VIPContent"
vipContent.Parent = vipPopup
vipContent.BackgroundTransparency = 1
vipContent.Size = UDim2.new(1, -40, 0, 80)
vipContent.Position = UDim2.new(0, 20, 0, 60)
vipContent.Font = Enum.Font.Gotham
vipContent.Text = "尊敬的VIP用户，感谢您的支持！\n\n您享有以下特权：\n✓ 专属金色视觉效果\n✓ 倒计时彩虹渐变\n✓ 炫酷闪烁动画\n✓ 优先技术支持"
vipContent.TextColor3 = Color3.fromRGB(255, 255, 255)
vipContent.TextSize = 14
vipContent.TextWrapped = true
vipContent.TextXAlignment = Enum.TextXAlignment.Left
vipContent.TextYAlignment = Enum.TextYAlignment.Top

-- VIP弹窗按钮
local vipButton = Instance.new("TextButton")
vipButton.Name = "VIPButton"
vipButton.Parent = vipPopup
vipButton.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
vipButton.Size = UDim2.new(0, 100, 0, 30)
vipButton.Position = UDim2.new(0.5, -50, 0.8, 0)
vipButton.Font = Enum.Font.GothamBold
vipButton.Text = "朕知道了"
vipButton.TextColor3 = Color3.fromRGB(0, 0, 0)
vipButton.TextSize = 14
vipButton.BorderSizePixel = 0

-- 非VIP弹窗（普通效果）
local nonVipPopup = Instance.new("Frame")
nonVipPopup.Name = "NonVipPopup"
nonVipPopup.Parent = popupContainer
nonVipPopup.Size = UDim2.new(1, 0, 1, 0)
nonVipPopup.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
nonVipPopup.BorderSizePixel = 0
nonVipPopup.Visible = not isVIP  -- 非VIP显示

-- 非VIP弹窗边框（灰色）
local nonVipBorder = Instance.new("UIStroke")
nonVipBorder.Parent = nonVipPopup
nonVipBorder.Color = Color3.fromRGB(150, 150, 150)
nonVipBorder.Thickness = 2
nonVipBorder.Transparency = 0.3

-- 非VIP弹窗标题
local nonVipTitle = Instance.new("TextLabel")
nonVipTitle.Name = "NonVipTitle"
nonVipTitle.Parent = nonVipPopup
nonVipTitle.BackgroundTransparency = 1
nonVipTitle.Size = UDim2.new(1, 0, 0, 40)
nonVipTitle.Position = UDim2.new(0, 0, 0, 10)
nonVipTitle.Font = Enum.Font.Gotham
nonVipTitle.Text = "普通用户提示"
nonVipTitle.TextColor3 = Color3.fromRGB(200, 200, 200)
nonVipTitle.TextSize = 18

-- 非VIP弹窗内容
local nonVipContent = Instance.new("TextLabel")
nonVipContent.Name = "NonVipContent"
nonVipContent.Parent = nonVipPopup
nonVipContent.BackgroundTransparency = 1
nonVipContent.Size = UDim2.new(1, -40, 0, 80)
nonVipContent.Position = UDim2.new(0, 20, 0, 60)
nonVipContent.Font = Enum.Font.Gotham
nonVipContent.Text = "当前状态：普通用户\n\n功能可用：\n✓ 时间显示\n✓ 倒计时功能\n✓ 节日提醒\n\n升级VIP可解锁：\n✨ 金色视觉效果\n✨ 炫酷动画\n✨ 优先支持"
nonVipContent.TextColor3 = Color3.fromRGB(200, 200, 200)
nonVipContent.TextSize = 13
nonVipContent.TextWrapped = true
nonVipContent.TextXAlignment = Enum.TextXAlignment.Left
nonVipContent.TextYAlignment = Enum.TextYAlignment.Top

-- 非VIP弹窗按钮
local nonVipButton = Instance.new("TextButton")
nonVipButton.Name = "NonVipButton"
nonVipButton.Parent = nonVipPopup
nonVipButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
nonVipButton.Size = UDim2.new(0, 100, 0, 30)
nonVipButton.Position = UDim2.new(0.5, -50, 0.8, 0)
nonVipButton.Font = Enum.Font.Gotham
nonVipButton.Text = "明白了"
nonVipButton.TextColor3 = Color3.fromRGB(255, 255, 255)
nonVipButton.TextSize = 14
nonVipButton.BorderSizePixel = 0

-- 弹窗圆角效果
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = popupContainer

local vipCorner = Instance.new("UICorner")
vipCorner.CornerRadius = UDim.new(0, 8)
vipCorner.Parent = vipPopup

local nonVipCorner = Instance.new("UICorner")
nonVipCorner.CornerRadius = UDim.new(0, 8)
nonVipCorner.Parent = nonVipPopup

local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 6)
buttonCorner.Parent = vipButton
buttonCorner:Clone().Parent = nonVipButton

-- VIP弹窗按钮点击事件
vipButton.MouseButton1Click:Connect(function()
    -- VIP关闭弹窗的华丽效果
    popupBackground.Visible = false
    -- VIP关闭音效（如果游戏支持）
    if game:GetService("SoundService") then
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://3570574687"  -- 华丽的音效
        sound.Volume = 0.3
        sound.Parent = game.Workspace
        sound:Play()
        game:GetService("Debris"):AddItem(sound, 3)
    end
end)

-- 非VIP弹窗按钮点击事件
nonVipButton.MouseButton1Click:Connect(function()
    -- 普通关闭弹窗
    popupBackground.Visible = false
end)

-- 弹窗显示函数
local function showPopup()
    popupBackground.Visible = true
    
    -- VIP用户的额外动画效果
    if isVIP then
        -- VIP弹窗进入动画
        popupContainer.Size = UDim2.new(0, 10, 0, 10)
        popupContainer.Position = UDim2.new(0.5, 0, 0.5, 0)
        
        -- VIP弹窗展开动画
        for i = 1, 20 do
            popupContainer.Size = UDim2.new(0, 10 + i * 15, 0, 10 + i * 10)
            popupContainer.Position = UDim2.new(0.5, 0, 0.5, 0)
            task.wait(0.01)
        end
        
        -- VIP弹窗发光闪烁
        task.spawn(function()
            while popupBackground.Visible and isVIP do
                vipBorder.Transparency = 0.2 + math.sin(tick() * 2) * 0.1
                task.wait(0.05)
            end
        end)
    else
        -- 非VIP用户简单显示
        popupContainer.Size = UDim2.new(0, 300, 0, 200)
    end
end

-- 点击容器显示弹窗
container.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        showPopup()
    end
end)

-- ============ 彩虹颜色逻辑 ============
local Hue = 0
local function HSVToRGB(h, s, v)
    local r, g, b
    local i = math.floor(h * 6)
    local f = h * 6 - i
    local p = v * (1 - s)
    local q = v * (1 - f * s)
    local t = v * (1 - (1 - f) * s)
    
    i = i % 6
    if i == 0 then r, g, b = v, t, p
    elseif i == 1 then r, g, b = q, v, p
    elseif i == 2 then r, g, b = p, v, t
    elseif i == 3 then r, g, b = p, q, v
    elseif i == 4 then r, g, b = t, p, v
    else r, g, b = v, p, q end
    
    return Color3.new(r, g, b)
end

-- 中国节日数据库
local ChineseFestivals = {
    {name = "元旦", month = 1, day = 1, color = Color3.fromRGB(255, 100, 100)},
    {name = "春节", month = 1, day = 29, color = Color3.fromRGB(255, 215, 0)},
    {name = "元宵节", month = 2, day = 12, color = Color3.fromRGB(255, 150, 200)},
    {name = "清明节", month = 4, day = 4, color = Color3.fromRGB(100, 255, 100)},
    {name = "劳动节", month = 5, day = 1, color = Color3.fromRGB(255, 100, 100)},
    {name = "端午节", month = 5, day = 31, color = Color3.fromRGB(255, 100, 100)},
    {name = "中秋节", month = 9, day = 29, color = Color3.fromRGB(255, 215, 0)},
    {name = "国庆节", month = 10, day = 1, color = Color3.fromRGB(255, 100, 100)},
    {name = "情人节", month = 2, day = 14, color = Color3.fromRGB(255, 150, 200)},
    {name = "圣诞节", month = 12, day = 25, color = Color3.fromRGB(255, 100, 100)},
    {name = "生日", month = 8, day = 15, color = Color3.fromRGB(0, 200, 255)},
}

-- 获取下一个节日
local function getNextFestival()
    local currentTime = os.time()
    local currentYear = tonumber(os.date("%Y", currentTime))
    local nextFestival = nil
    local minDiff = math.huge
    
    for _, festival in ipairs(ChineseFestivals) do
        local festivalTime = os.time({
            year = currentYear,
            month = festival.month,
            day = festival.day,
            hour = 0,
            min = 0,
            sec = 0
        })
        
        if festivalTime < currentTime then
            festivalTime = os.time({
                year = currentYear + 1,
                month = festival.month,
                day = festival.day,
                hour = 0,
                min = 0,
                sec = 0
            })
        end
        
        local diff = festivalTime - currentTime
        
        if diff < minDiff and diff > 0 then
            minDiff = diff
            nextFestival = {
                name = festival.name,
                time = festivalTime,
                color = festival.color
            }
        end
    end
    
    return nextFestival
end

-- VIP闪烁动画（只有VIP用户有动画）
local function vipPulseAnimation()
    while task.wait() and vipLabel and vipLabel.Parent do
        if isVIP then
            local pulse = 0.4 + math.sin(tick() * 1.8) * 0.08
            for _, child in ipairs(vipLabel:GetChildren()) do
                if child:IsA("UIStroke") then
                    child.Transparency = pulse
                end
            end
            vipLabel.TextTransparency = 0.15 + math.abs(math.sin(tick() * 3.5)) * 0.08
        else
            vipLabel.TextTransparency = 0
        end
        task.wait(0.05)
    end
end

-- 计算目标时间
local function getNextTargetTime()
    local nextFestival = getNextFestival()
    if nextFestival then
        eventLabel.TextColor3 = nextFestival.color
        eventLabel.Text = nextFestival.name
        return nextFestival.time
    end
    
    local currentTime = os.time()
    local currentYear = tonumber(os.date("%Y", currentTime))
    eventLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
    eventLabel.Text = "元旦"
    return os.time({
        year = currentYear + 1,
        month = 1,
        day = 1,
        hour = 0,
        min = 0,
        sec = 0
    })
end

-- 时间格式化函数
local function formatTime(seconds)
    if seconds <= 0 then return "已到" end
    
    local days = math.floor(seconds / 86400)
    local hours = math.floor((seconds % 86400) / 3600)
    local minutes = math.floor((seconds % 3600) / 60)
    local secs = math.floor(seconds % 60)
    
    if days > 0 then
        return string.format("%d天%d时", days, hours)
    elseif hours > 0 then
        return string.format("%d时%d分", hours, minutes)
    else
        return string.format("%d分%d秒", minutes, secs)
    end
end

-- 获取目标时间
local targetTime = getNextTargetTime()

-- 更新时间显示
local function updateTime()
    while task.wait() and timeLabel and detailLabel and timeLabel.Parent do
        timeLabel.Text = os.date("%H:%M:%S")
        
        local currentTime = os.time()
        local timeDiff = targetTime - currentTime
        
        if timeDiff > 0 then
            detailLabel.Text = formatTime(timeDiff)
            
            if isVIP then
                Hue = (Hue + 0.001) % 1
                detailLabel.TextColor3 = HSVToRGB(Hue, 0.8, 1)
            else
                detailLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
            end
        else
            detailLabel.Text = "已到"
            detailLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
            
            task.wait(1)
            targetTime = getNextTargetTime()
        end
        
        task.wait(0.1)
    end
end

-- 启动动画和时间更新
task.spawn(vipPulseAnimation)
task.spawn(updateTime)

-- 添加鼠标悬停提示
local tooltip = Instance.new("TextLabel")
tooltip.Name = "Tooltip"
tooltip.Parent = mainGui
tooltip.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
tooltip.BackgroundTransparency = 0.3
tooltip.BorderSizePixel = 0
tooltip.Position = UDim2.new(0.98, -180, 0.01, 40)
tooltip.AnchorPoint = Vector2.new(1, 0)
tooltip.Size = UDim2.new(0, 175, 0, 30)
tooltip.Visible = false
tooltip.Font = Enum.Font.Gotham
tooltip.Text = "用户: " .. playerName .. "\n状态: " .. (isVIP and "VIP用户" or "普通用户") .. "\n点击查看详情"
tooltip.TextColor3 = Color3.fromRGB(200, 200, 200)
tooltip.TextSize = 10
tooltip.TextXAlignment = Enum.TextXAlignment.Left
tooltip.TextYAlignment = Enum.TextYAlignment.Top
tooltip.TextWrapped = true

-- 鼠标悬停显示提示
container.MouseEnter:Connect(function()
    tooltip.Visible = true
end)

container.MouseLeave:Connect(function()
    tooltip.Visible = false
end)

-- 脚本启动时显示欢迎弹窗（延迟2秒）
task.wait(2)
showPopup()

-- 可选：显示当前用户状态
print("[VIP系统] 当前用户:", playerName)
print("[VIP系统] VIP状态:", isVIP and "是VIP用户" or "非VIP用户")
print("[VIP系统] 点击时间显示区域查看弹窗")
