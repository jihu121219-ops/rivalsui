-- Services
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- 기존 GUI 정리 (테스트용)
if playerGui:FindFirstChild("PlaybackSettingsGui") then
	playerGui.PlaybackSettingsGui:Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PlaybackSettingsGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Color Palette (CSS Variables 매핑)
local COLORS = {
	bg0 = Color3.fromRGB(14, 14, 18),
	bg1 = Color3.fromRGB(22, 22, 28),
	bg2 = Color3.fromRGB(28, 28, 36),
	line = Color3.fromRGB(42, 42, 52),
	textHi = Color3.fromRGB(242, 241, 246),
	textMid = Color3.fromRGB(166, 165, 179),
	textLo = Color3.fromRGB(107, 106, 120),
	accent = Color3.fromRGB(232, 73, 63),
	accentDim = Color3.fromRGB(232, 73, 63), -- 투명도는 BackgroundTransparency로 조절
	track = Color3.fromRGB(58, 58, 70),
}

-- 메인 앱 프레임
local app = Instance.new("Frame")
app.Name = "App"
app.Size = UDim2.new(0, 900, 0, 560)
app.AnchorPoint = Vector2.new(0.5, 0.5)
app.Position = UDim2.new(0.5, 0, 0.5, 0)
app.BackgroundColor3 = COLORS.bg1
app.BorderSizePixel = 0
app.Parent = screenGui

local appCorner = Instance.new("UICorner")
appCorner.CornerRadius = UDim.new(0, 14)
appCorner.Parent = app

local appStroke = Instance.new("UIStroke")
appStroke.Color = COLORS.line
appStroke.Thickness = 1
appStroke.Parent = app

-- 사이드바
local sidebar = Instance.new("Frame")
sidebar.Name = "Sidebar"
sidebar.Size = UDim2.new(0, 60, 1, 0)
sidebar.BackgroundColor3 = COLORS.bg0
sidebar.BorderSizePixel = 0
sidebar.Parent = app

local sidebarStroke = Instance.new("UIStroke")
sidebarStroke.Color = COLORS.line
sidebarStroke.Thickness = 1
sidebarStroke.Parent = sidebar

local sidebarLayout = Instance.new("UIListLayout")
sidebarLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
sidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
sidebarLayout.Padding = UDim.new(0, 6)
sidebarLayout.Parent = sidebar

local sidebarPadding = Instance.new("UIPadding")
sidebarPadding.PaddingTop = UDim.new(0, 18)
sidebarPadding.Parent = sidebar

-- 브랜드 로고 (MP)
local brand = Instance.new("Frame")
brand.Name = "Brand"
brand.Size = UDim2.new(0, 34, 0, 34)
brand.BackgroundColor3 = COLORS.accent
brand.BorderSizePixel = 0
brand.LayoutOrder = 1
brand.Parent = sidebar

local brandCorner = Instance.new("UICorner")
brandCorner.CornerRadius = UDim.new(0, 9)
brandCorner.Parent = brand

local brandText = Instance.new("TextLabel")
brandText.Size = UDim2.new(1, 0, 1, 0)
brandText.BackgroundTransparency = 1
brandText.Font = Enum.Font.FredokaOne
brandText.Text = "MP"
brandText.TextColor3 = Color3.fromRGB(255, 255, 255)
brandText.TextSize = 13
brandText.Parent = brand

-- 네비게이션 아이콘 생성 함수
local function createNavIcon(order, active)
	local icon = Instance.new("Frame")
	icon.Size = UDim2.new(0, 38, 0, 38)
	icon.BackgroundColor3 = active and COLORS.accentDim or Color3.fromRGB(0,0,0)
	icon.BackgroundTransparency = active and 0.8 or 1
	icon.BorderSizePixel = 0
	icon.LayoutOrder = order
	icon.Parent = sidebar
	
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 9)
	corner.Parent = icon
	
	return icon
end

createNavIcon(2, true)  -- 재생 (Active)
createNavIcon(3, false) -- 라이브러리
createNavIcon(4, false) -- 화면
createNavIcon(5, false) -- 네트워크
createNavIcon(6, false) -- 단축키
createNavIcon(7, false) -- 정보

-- 메인 콘텐츠 영역
local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.new(1, -60, 1, 0)
main.Position = UDim2.new(0, 60, 0, 0)
main.BackgroundTransparency = 1
main.Parent = app

local mainPadding = Instance.new("UIPadding")
mainPadding.PaddingTop = UDim.new(0, 26)
mainPadding.PaddingBottom = UDim.new(0, 30)
mainPadding.PaddingLeft = UDim.new(0, 30)
mainPadding.PaddingRight = UDim.new(0, 30)
mainPadding.Parent = main

-- 헤더 타이틀
local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, 50)
header.BackgroundTransparency = 1
header.Parent = main

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 24)
titleLabel.BackgroundTransparency = 1
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Text = "재생 설정"
titleLabel.TextColor3 = COLORS.textHi
titleLabel.TextSize = 20
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = header

local descLabel = Instance.new("TextLabel")
descLabel.Size = UDim2.new(1, 0, 0, 18)
descLabel.Position = UDim2.new(0, 0, 0, 28)
descLabel.BackgroundTransparency = 1
descLabel.Font = Enum.Font.Gotham
descLabel.Text = "화질, 자막, 오디오 동기화와 재생 방식을 관리합니다."
descLabel.TextColor3 = COLORS.textMid
descLabel.TextSize = 13
descLabel.TextXAlignment = Enum.TextXAlignment.Left
descLabel.Parent = header

-- 탭 메뉴
local tabs = Instance.new("Frame")
tabs.Name = "Tabs"
tabs.Size = UDim2.new(1, 0, 0, 36)
tabs.Position = UDim2.new(0, 0, 0, 60)
tabs.BackgroundTransparency = 1
tabs.Parent = main

local tabsLayout = Instance.new("UIListLayout")
tabsLayout.FillDirection = Enum.FillDirection.Horizontal
tabsLayout.SortOrder = Enum.SortOrder.LayoutOrder
tabsLayout.Padding = UDim.new(0, 22)
tabsLayout.Parent = tabs

local tabsBorder = Instance.new("Frame")
tabsBorder.Size = UDim2.new(1, 0, 0, 1)
tabsBorder.Position = UDim2.new(0, 0, 1, -1)
tabsBorder.BackgroundColor3 = COLORS.line
tabsBorder.BorderSizePixel = 0
tabsBorder.Parent = tabs

local function createTab(text, active)
	local tab = Instance.new("TextButton")
	tab.Size = UDim2.new(0, 50, 1, 0)
	tab.BackgroundTransparency = 1
	tab.Font = Enum.Font.GothamSemibold
	tab.Text = text
	tab.TextColor3 = active and COLORS.textHi or COLORS.textLo
	tab.TextSize = 13.5
	tab.Parent = tabs
	return tab
end

createTab("화질", true)
createTab("오디오", false)
createTab("자막", false)

-- 컨텐츠 본문 (2단 컬럼 구조)
local content = Instance.new("Frame")
content.Name = "Content"
content.Size = UDim2.new(1, 0, 1, -110)
content.Position = UDim2.new(0, 0, 0, 105)
content.BackgroundTransparency = 1
content.Parent = main

local contentLayout = Instance.new("UIListLayout")
contentLayout.FillDirection = Enum.FillDirection.Horizontal
contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
contentLayout.Padding = UDim.new(0, 36)
contentLayout.Parent = content

-- 왼쪽 컬럼 (Col 1)
local col1 = Instance.new("ScrollingFrame")
col1.Name = "Col1"
col1.Size = UDim2.new(0.5, -18, 1, 0)
col1.BackgroundTransparency = 1
col1.BorderSizePixel = 0
col1.ScrollBarThickness = 0
col1.CanvasSize = UDim2.new(0, 0, 0, 600)
col1.Parent = content

local col1Layout = Instance.new("UIListLayout")
col1Layout.SortOrder = Enum.SortOrder.LayoutOrder
col1Layout.Padding = UDim.new(0, 12)
col1Layout.Parent = col1

-- 일반 섹션 타이틀
local sectionTitle1 = Instance.new("TextLabel")
sectionTitle1.Size = UDim2.new(1, 0, 0, 20)
sectionTitle1.BackgroundTransparency = 1
sectionTitle1.Font = Enum.Font.GothamBold
sectionTitle1.Text = "일반"
sectionTitle1.TextColor3 = COLORS.textLo
sectionTitle1.TextSize = 11.5
sectionTitle1.TextXAlignment = Enum.TextXAlignment.Left
sectionTitle1.LayoutOrder = 1
sectionTitle1.Parent = col1

-- 컴포넌트 생성 헬퍼: 스위치 카드 (자동 화질 조정용)
local function createQualityCard()
	local card = Instance.new("Frame")
	card.Size = UDim2.new(1, 0, 0, 64)
	card.BackgroundColor3 = COLORS.bg2
	card.BorderSizePixel = 0
	card.LayoutOrder = 2
	card.Parent = col1
	
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 9)
	corner.Parent = card
	
	local stroke = Instance.new("UIStroke")
	stroke.Color = COLORS.line
	stroke.Thickness = 1
	stroke.Parent = card
	
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, -70, 0, 20)
	label.Position = UDim2.new(0, 14, 0, 12)
	label.BackgroundTransparency = 1
	label.Font = Enum.Font.GothamSemibold
	label.Text = "자동 화질 조정"
	label.TextColor3 = COLORS.textHi
	label.TextSize = 13.5
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = card
	
	local sub = Instance.new("TextLabel")
	sub.Size = UDim2.new(1, -70, 0, 16)
	sub.Position = UDim2.new(0, 14, 0, 34)
	sub.BackgroundTransparency = 1
	sub.Font = Enum.Font.Gotham
	sub.Text = "네트워크 상태에 따라 화질을 자동으로 낮추거나 높입니다"
	sub.TextColor3 = COLORS.textLo
	sub.TextSize = 11.5
	sub.TextXAlignment = Enum.TextXAlignment.Left
	sub.Parent = card
	
	-- Toggle Switch
	local switch = Instance.new("Frame")
	switch.Size = UDim2.new(0, 38, 0, 22)
	switch.Position = UDim2.new(1, -52, 0.5, -11)
	switch.BackgroundColor3 = COLORS.accent
	switch.BorderSizePixel = 0
	switch.Parent = card
	
	local sCorner = Instance.new("UICorner")
	sCorner.CornerRadius = UDim.new(1, 0)
	sCorner.Parent = switch
	
	local knob = Instance.new("Frame")
	knob.Size = UDim2.new(0, 18, 0, 18)
	knob.Position = UDim2.new(0, 18, 0.5, -9)
	knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	knob.BorderSizePixel = 0
	knob.Parent = switch
	
	local kCorner = Instance.new("UICorner")
	kCorner.CornerRadius = UDim.new(1, 0)
	kCorner.Parent = knob
end
createQualityCard()

-- 일반 Row 생성 헬퍼
local function createRow(text, isOn, order)
	local row = Instance.new("Frame")
	row.Size = UDim2.new(1, 0, 0, 42)
	row.BackgroundTransparency = 1
	row.LayoutOrder = order
	row.Parent = col1
	
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, -60, 1, 0)
	label.BackgroundTransparency = 1
	label.Font = Enum.Font.Gotham
	label.Text = text
	label.TextColor3 = COLORS.textHi
	label.TextSize = 13.5
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = row
	
	local switch = Instance.new("Frame")
	switch.Size = UDim2.new(0, 38, 0, 22)
	switch.Position = UDim2.new(1, -38, 0.5, -11)
	switch.BackgroundColor3 = isOn and COLORS.accent or COLORS.track
	switch.BorderSizePixel = 0
	switch.Parent = row
	
	local sCorner = Instance.new("UICorner")
	sCorner.CornerRadius = UDim.new(1, 0)
	sCorner.Parent = switch
	
	local knob = Instance.new("Frame")
	knob.Size = UDim2.new(0, 18, 0, 18)
	knob.Position = isOn and UDim2.new(0, 18, 0.5, -9) or UDim2.new(0, 2, 0.5, -9)
	knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	knob.BorderSizePixel = 0
	knob.Parent = switch
	
	local kCorner = Instance.new("UICorner")
	kCorner.CornerRadius = UDim.new(1, 0)
	kCorner.Parent = knob
	
	local line = Instance.new("Frame")
	line.Size = UDim2.new(1, 0, 0, 1)
	line.Position = UDim2.new(0, 0, 1, 0)
	line.BackgroundColor3 = COLORS.line
	line.BorderSizePixel = 0
	line.Parent = row
end

createRow("재생 시작 시 이어보기", true, 3)
createRow("배경에서 재생 허용", false, 4)

-- Select Dropdown Row (기본 재생 속도)
local function createSelectRow(text, valText, order)
	local row = Instance.new("Frame")
	row.Size = UDim2.new(1, 0, 0, 42)
	row.BackgroundTransparency = 1
	row.LayoutOrder = order
	row.Parent = col1
	
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, -70, 1, 0)
	label.BackgroundTransparency = 1
	label.Font = Enum.Font.Gotham
	label.Text = text
	label.TextColor3 = COLORS.textHi
	label.TextSize = 13.5
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = row
	
	local selectBox = Instance.new("Frame")
	selectBox.Size = UDim2.new(0, 60, 0, 28)
	selectBox.Position = UDim2.new(1, -60, 0.5, -14)
	selectBox.BackgroundColor3 = COLORS.bg2
	selectBox.BorderSizePixel = 0
	selectBox.Parent = row
	
	local sCorner = Instance.new("UICorner")
	sCorner.CornerRadius = UDim.new(0, 7)
	sCorner.Parent = selectBox
	
	local sStroke = Instance.new("UIStroke")
	sStroke.Color = COLORS.line
	sStroke.Parent = selectBox
	
	local valLabel = Instance.new("TextLabel")
	valLabel.Size = UDim2.new(1, 0, 1, 0)
	valLabel.BackgroundTransparency = 1
	valLabel.Font = Enum.Font.Gotham
	valLabel.Text = valText
	valLabel.TextColor3 = COLORS.textMid
	valLabel.TextSize = 13
	valLabel.Parent = selectBox
	
	local line = Instance.new("Frame")
	line.Size = UDim2.new(1, 0, 0, 1)
	line.Position = UDim2.new(0, 0, 1, 0)
	line.BackgroundColor3 = COLORS.line
	line.BorderSizePixel = 0
	line.Parent = row
end

createSelectRow("기본 재생 속도", "1.0x", 5)

-- 슬라이더 생성 헬퍼
local function createSlider(title, valText, fillPercent, order)
	local wrap = Instance.new("Frame")
	wrap.Size = UDim2.new(1, 0, 0, 45)
	wrap.BackgroundTransparency = 1
	wrap.LayoutOrder = order
	wrap.Parent = col1
	
	local top = Instance.new("Frame")
	top.Size = UDim2.new(1, 0, 0, 18)
	top.BackgroundTransparency = 1
	top.Parent = wrap
	
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(0, 200, 1, 0)
	label.BackgroundTransparency = 1
	label.Font = Enum.Font.Gotham
	label.Text = title
	label.TextColor3 = COLORS.textHi
	label.TextSize = 13.5
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = top
	
	local val = Instance.new("TextLabel")
	val.Size = UDim2.new(0, 50, 1, 0)
	val.Position = UDim2.new(1, -50, 0, 0)
	val.BackgroundTransparency = 1
	val.Font = Enum.Font.Gotham
	val.Text = valText
	val.TextColor3 = COLORS.textMid
	val.TextSize = 12.5
	val.TextXAlignment = Enum.TextXAlignment.Right
	val.Parent = top
	
	local track = Instance.new("Frame")
	track.Size = UDim2.new(1, 0, 0, 4)
	track.Position = UDim2.new(0, 0, 0, 26)
	track.BackgroundColor3 = COLORS.track
	track.BorderSizePixel = 0
	track.Parent = wrap
	
	local tCorner = Instance.new("UICorner")
	tCorner.CornerRadius = UDim.new(1, 0)
	tCorner.Parent = track
	
	local fill = Instance.new("Frame")
	fill.Size = UDim2.new(fillPercent, 0, 1, 0)
	fill.BackgroundColor3 = COLORS.accent
	fill.BorderSizePixel = 0
	fill.Parent = track
	
	local fCorner = Instance.new("UICorner")
	fCorner.CornerRadius = UDim.new(1, 0)
	fCorner.Parent = fill
	
	local thumb = Instance.new("Frame")
	thumb.Size = UDim2.new(0, 14, 0, 14)
	thumb.AnchorPoint = Vector2.new(0.5, 0.5)
	thumb.Position = UDim2.new(fillPercent, 0, 0.5, 0)
	thumb.BackgroundColor3 = COLORS.accent
	thumb.BorderSizePixel = 0
	thumb.Parent = track
	
	local thCorner = Instance.new("UICorner")
	thCorner.CornerRadius = UDim.new(1, 0)
	thCorner.Parent = thumb
	
	local thStroke = Instance.new("UIStroke")
	thStroke.Color = COLORS.bg1
	thStroke.Thickness = 2
	thStroke.Parent = thumb
	
	local line = Instance.new("Frame")
	line.Size = UDim2.new(1, 0, 0, 1)
	line.Position = UDim2.new(0, 0, 1, 0)
	line.BackgroundColor3 = COLORS.line
	line.BorderSizePixel = 0
	line.Parent = wrap
end

createSlider("전환 지연 (s)", "0.0", 0, 6)
createSlider("버퍼링 여유 시간 (s)", "2", 0.4, 7)
createSlider("화면 밝기 보정", "3", 0.6, 8)
createSlider("선명도", "0.5", 0.5, 9)

-- 오른쪽 컬럼 (Col 2)
local col2 = Instance.new("Frame")
col2.Name = "Col2"
col2.Size = UDim2.new(0.5, -18, 1, 0)
col2.BackgroundTransparency = 1
col2.Parent = content

local col2Layout = Instance.new("UIListLayout")
col2Layout.SortOrder = Enum.SortOrder.LayoutOrder
col2Layout.Padding = UDim.new(0, 0)
col2Layout.Parent = col2

-- 서브 탭 (화면 / 고급)
local subTabs = Instance.new("Frame")
subTabs.Size = UDim2.new(1, 0, 0, 24)
subTabs.BackgroundTransparency = 1
subTabs.LayoutOrder = 1
subTabs.Parent = col2

local subTabsLayout = Instance.new("UIListLayout")
subTabsLayout.FillDirection = Enum.FillDirection.Horizontal
subTabsLayout.SortOrder = Enum.SortOrder.LayoutOrder
subTabsLayout.Padding = UDim.new(0, 16)
subTabsLayout.Parent = subTabs

local function createSubTab(text, active)
	local tab = Instance.new("TextButton")
	tab.Size = UDim2.new(0, 30, 1, 0)
	tab.BackgroundTransparency = 1
	tab.Font = active and Enum.Font.GothamBold or Enum.Font.Gotham
	tab.Text = text
	tab.TextColor3 = active and COLORS.textHi or COLORS.textLo
	tab.TextSize = 12
	tab.Parent = subTabs
	return tab
end
createSubTab("화면", true)
createSubTab("고급", false)

local subLine = Instance.new("Frame")
subLine.Size = UDim2.new(1, 0, 0, 1)
subLine.Position = UDim2.new(0, 0, 0, 28)
subLine.BackgroundColor3 = COLORS.line
subLine.BorderSizePixel = 0
subLine.LayoutOrder = 2
subLine.Parent = col2

-- 드롭다운 박스 생성 헬퍼
local function createDropdownGroup(labelTitle, selectedText, order)
	local group = Instance.new("Frame")
	group.Size = UDim2.new(1, 0, 0, 68)
	group.BackgroundTransparency = 1
	group.LayoutOrder = order
	group.Parent = col2
	
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, 0, 0, 20)
	label.Position = UDim2.new(0, 0, 0, 10)
	label.BackgroundTransparency = 1
	label.Font = Enum.Font.Gotham
	label.Text = labelTitle
	label.TextColor3 = COLORS.textMid
	label.TextSize = 12.5
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = group
	
	local box = Instance.new("Frame")
	box.Size = UDim2.new(1, 0, 0, 36)
	box.Position = UDim2.new(0, 0, 0, 32)
	box.BackgroundColor3 = COLORS.bg2
	box.BorderSizePixel = 0
	box.Parent = group
	
	local bCorner = Instance.new("UICorner")
	bCorner.CornerRadius = UDim.new(0, 7)
	bCorner.Parent = box
	
	local bStroke = Instance.new("UIStroke")
	bStroke.Color = COLORS.line
	bStroke.Parent = box
	
	local text = Instance.new("TextLabel")
	text.Size = UDim2.new(1, -20, 1, 0)
	text.Position = UDim2.new(0, 10, 0, 0)
	text.BackgroundTransparency = 1
	text.Font = Enum.Font.Gotham
	text.Text = selectedText
	text.TextColor3 = COLORS.textHi
	text.TextSize = 13
	text.TextXAlignment = Enum.TextXAlignment.Left
	text.Parent = box
end

createDropdownGroup("화면 비율", "원본 비율 유지", 3)
createDropdownGroup("디코딩 방식", "하드웨어 가속", 4)
createDropdownGroup("색상 프로필", "표준", 5)

-- 기기별 설정 섹션 타이틀
local deviceSection = Instance.new("Frame")
deviceSection.Size = UDim2.new(1, 0, 0, 40)
deviceSection.BackgroundTransparency = 1
deviceSection.LayoutOrder = 6
deviceSection.Parent = col2

local dTitle = Instance.new("TextLabel")
dTitle.Size = UDim2.new(1, 0, 1, 0)
dTitle.Position = UDim2.new(0, 0, 0, 10)
dTitle.BackgroundTransparency = 1
dTitle.Font = Enum.Font.GothamBold
dTitle.Text = "기기별 설정"
dTitle.TextColor3 = COLORS.textLo
dTitle.TextSize = 11.5
dTitle.TextXAlignment = Enum.TextXAlignment.Left
dTitle.Parent = deviceSection

-- 잠긴 스위치 Row (모바일 데이터 사용)
local function createLockedRow(text, order)
	local row = Instance.new("Frame")
	row.Size = UDim2.new(1, 0, 0, 42)
	row.BackgroundTransparency = 1
	row.LayoutOrder = order
	row.Parent = col2
	
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, -60, 1, 0)
	label.BackgroundTransparency = 1
	label.Font = Enum.Font.Gotham
	label.Text = text
	label.TextColor3 = COLORS.textHi
	label.TextSize = 12.5
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = row
	
	local switch = Instance.new("Frame")
	switch.Size = UDim2.new(0, 38, 0, 22)
	switch.Position = UDim2.new(1, -38, 0.5, -11)
	switch.BackgroundColor3 = COLORS.track
	switch.BackgroundTransparency = 0.65 -- off-locked opacity 처리 (.35)
	switch.BorderSizePixel = 0
	switch.Parent = row
	
	local sCorner = Instance.new("UICorner")
	sCorner.CornerRadius = UDim.new(1, 0)
	sCorner.Parent = switch
	
	local knob = Instance.new("Frame")
	knob.Size = UDim2.new(0, 18, 0, 18)
	knob.Position = UDim2.new(0, 2, 0.5, -9)
	knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	knob.BackgroundTransparency = 0.65
	knob.BorderSizePixel = 0
	knob.Parent = switch
	
	local kCorner = Instance.new("UICorner")
	kCorner.CornerRadius = UDim.new(1, 0)
	kCorner.Parent = knob
end

createLockedRow("모바일 데이터 사용", 7)