require("hs.ipc")
require("io")
hs.ipc.cliInstall()
hs.allowAppleScript(true)

local fastKeyStroke = function(modifiers, character)
	hs.eventtap.event.newKeyEvent(modifiers, character, true):post()
	hs.eventtap.event.newKeyEvent(modifiers, character, false):post()
end

k = hs.hotkey.modal.new({}, "F17")
k2 = hs.hotkey.modal.new({}, "F16")
k3 = hs.hotkey.modal.new({}, "F15")
hs.hotkey.bind({}, 'F18', function() k:enter() end, function() k:exit() end, function() end)
k:bind({}, 'tab', function() k2:enter() end, function() k2:exit() end, function() end)
k:bind({}, 'q', function() k3:enter() end, function() k3:exit() end, function() end)

--------------------------------------------------------------
-- 브라우저 back, forward 단축키
--------------------------------------------------------------
hs.hotkey.bind({'cmd'}, '1', function() hs.eventtap.keyStroke({'cmd'}, 'left') end)
hs.hotkey.bind({'cmd'}, '2', function() hs.eventtap.keyStroke({'cmd'}, 'right') end)

hs.window.filter.new({'GroovyConsole'})
    :subscribe(hs.window.filter.windowFocused,function()
		k:bind('', 'n', function() fastKeyStroke({'cmd'}, 'left') end)
		k:bind('', '/', function() fastKeyStroke({'cmd'}, 'right') end)
		k2:bind('', 'n', function() fastKeyStroke({'cmd', 'shift'}, 'left') end)
		k2:bind('', '/', function() fastKeyStroke({'cmd', 'shift'}, 'right') end)
	end)
    :subscribe(hs.window.filter.windowUnfocused,function()
		k:bind('', 'n', function() fastKeyStroke({}, 'home') end)
		k:bind('', '/', function() fastKeyStroke({}, 'end') end)
		k2:bind('', 'n', function() fastKeyStroke({'shift'}, 'home') end)
		k2:bind('', '/', function() fastKeyStroke({'shift'}, 'end') end)
	end)

k:bind('', 'j', function() fastKeyStroke({}, 'left') end, nil, function() fastKeyStroke({}, 'left') end)
k:bind('', ';', function() fastKeyStroke({}, 'right') end, nil, function() fastKeyStroke({}, 'right') end)
k:bind('', 'k', function() fastKeyStroke({}, 'down') end, nil, function() fastKeyStroke({}, 'down') end)
k:bind('', 'l', function() fastKeyStroke({}, 'up') end, nil, function() fastKeyStroke({}, 'up') end)
k:bind('', 'e', function() fastKeyStroke({}, 'delete') end, nil, function() fastKeyStroke({}, 'delete') end)
k:bind('', 'd', function() fastKeyStroke({}, 'forwarddelete') end, nil, function() fastKeyStroke({}, 'forwarddelete') end)
k:bind('', 'n', function() fastKeyStroke({}, 'home') end)
k:bind('', '/', function() fastKeyStroke({}, 'end') end)

--k:bind('', '3', function() fastKeyStroke({'cmd', 'ctrl'}, 'd') end)
k:bind('', 'delete', function() k:exit() fastKeyStroke({'alt'}, 'delete') k:enter() end)

k:bind('', 'c', function() k:exit() fastKeyStroke({'cmd'}, 'c') k:enter() end)
k:bind('', 'v', function() k:exit() fastKeyStroke({'cmd'}, 'v') k:enter() end)
k:bind('', 'x', function() k:exit() fastKeyStroke({'cmd'}, 'x') k:enter() end)

--k:bind('', 'c', function() fastKeyStroke({'cmd'}, 'c') end)
--k:bind('', 'x', function() fastKeyStroke({'cmd'}, 'x') end)
k:bind('', 'space', function() k:exit() hs.eventtap.keyStroke({'cmd', 'shift', 'alt'}, 'f12') k:enter() end)

k:bind('', 's', function() k:exit() fastKeyStroke({'cmd'}, 's') k:enter() end)
k:bind('', 'a', function()
	fastKeyStroke({}, 'home')
	fastKeyStroke({'shift'}, 'end')
end)
k:bind('', 'r', function()
	k:exit()
	fastKeyStroke({'cmd'}, 'right')
	fastKeyStroke({}, 'space')
	fastKeyStroke({'cmd', 'shift'}, 'left')
	fastKeyStroke({'cmd', 'shift'}, 'left')
	fastKeyStroke({}, 'forwarddelete')
	fastKeyStroke({}, 'forwarddelete')
	k:enter()
end)

--------------------------------------------------------------
-- reload script
--------------------------------------------------------------
k:bind('', 'f3', function()
	k:exit()
	fastKeyStroke({'cmd'}, 's')
	hs.alert.show('reloading')
	hs.reload()
	k:enter()
end)

k:bind('', '6', function()
	k:exit()
	fastKeyStroke({}, 'ik')
	k:enter()
end)

k:bind('', 'f5', function()
	aa = hs.application.find('Finder')
	hs.eventtap.event.newMouseEvent(hs.eventtap.event.types.leftmousedown, hs.geometry.point(100, 100), {}):post(aa)
	hs.timer.usleep(200000)
	hs.eventtap.event.newMouseEvent(hs.eventtap.event.types.leftmouseup, hs.geometry.point(100, 100), {}):post(aa)
		hs.alert.show('reloading')
end)

k:bind('', 'f4', function()
	k:exit()
	local u = hs.window.get('BlueStacks 앱 플레이어'):isVisible()
	print(u)
	print('----------------------')
	k:enter()
end)

k:bind('', '2', function() hs.osascript.applescript([[
	tell application "Atom"
		tell application "Finder" to set filePath to POSIX path of first item of (get selection as alias list)
		activate
		open filePath
	end tell
]]) end)

k:bind('', '3', function()
	fastKeyStroke({'cmd'}, 'c')
	hs.osascript.applescript([[
		--tell application "System Events" to keystroke "c" using command down
		tell application "Allkdic"
			activate
		end tell
		tell application "System Events" to tell process "올ㅋ사전"
			tell (menu bar item 1 of menu bar 1)
				click
				--keystroke "v" using command down
				--key code 36
			end tell
		end tell
	]])
	fastKeyStroke({'cmd'}, 'v')
	fastKeyStroke({}, 'return')
end)

k:bind('', '8', function() hs.osascript.applescript([[
	tell application "TextEdit"
		tell application "Finder" to set filePath to POSIX path of first item of (get selection as alias list)
		activate
		open filePath
	end tell
]]) end)


--------------------------------------------------------------
-- 화면캡쳐
--------------------------------------------------------------
k:bind('', '4', function() hs.osascript.applescript([[
	do shell script "screencapture -i -c"
]]) end)

k:bind('', 'f12', function()
	--hs.alert.show(hs.application.frontmostApplication():bundleID())
	--hs.showError(cc)
	--hs.notify.new({title="Hammerspoon", informativeText="Hello World"}):send()
	hs.osascript.javascript([[
		var finder = Application('Finder');
		finder.selection
		var te = Application('TextEdit');
		te.open('/Users/1001152/Downloads/sk_admin.txt');
	]])
end)

k2:bind('', 'j', function() fastKeyStroke({'shift'}, 'left') end, nil, function() fastKeyStroke({'shift'}, 'left') end)
k2:bind('', ';', function() fastKeyStroke({'shift'}, 'right') end, nil, function() fastKeyStroke({'shift'}, 'right') end)
k2:bind('', 'k', function() fastKeyStroke({'shift'}, 'down') end, nil, function() fastKeyStroke({'shift'}, 'down') end)
k2:bind('', 'l', function() fastKeyStroke({'shift'}, 'up') end, nil, function() fastKeyStroke({'shift'}, 'up') end)
k2:bind('', 'n', function() fastKeyStroke({'shift'}, 'home') end)
k2:bind('', '/', function() fastKeyStroke({'shift'}, 'end') end)
k2:bind('', 'e', function() fastKeyStroke({'alt'}, 'delete') end)
k2:bind('', 'd', function() fastKeyStroke({'alt'}, 'forwarddelete') end)

k3:bind('', 'j', function() fastKeyStroke({'alt'}, 'left') end, nil, function() fastKeyStroke({'alt'}, 'left') end)
k3:bind('', ';', function() fastKeyStroke({'alt'}, 'right') end, nil, function() fastKeyStroke({'alt'}, 'right') end)

-- hs.hotkey.bind({'shift'}, 'space', nil, function() fastKeyStroke({'cmd'}, 'space') end)

test3 = function(a, b)
	x = tonumber(b)
	if x == nil then
		x = 1
	end
	hs.notify.new({title="Hammerspoon", informativeText=a}):send()
	hs.notify.new({title="Hammerspoon", informativeText=''..x}):send()
end

--------------------------------------------------------------
-- make book
--------------------------------------------------------------
mkbook = function(bookName, page)
	hs.notify.new({title="Hammerspoon", informativeText="start: "..bookName}):send()
	local logFile = os.tmpname()
	local w = hs.window.get('BlueStacks 앱 플레이어')
	w:focus()
	local pos = w:topLeft()
	local size = w:size()
	local sc = hs.screen.primaryScreen()
	local noChange = 0
	local i = tonumber(page)
	if i == nil then
		i = 1
	end
	local u = ''
	local temp1 = os.tmpname()
	local temp2 = os.tmpname()
	local mt, mr, mb, ml = 45, 0, 95, 0
	--local mt, mr, mb, ml = 150, 150, 200, 150
	local diff = 0

	if i == 1 then
		hs.execute('mkdir -p ~/.book')
		hs.execute('rm -rif ~/.book/*')
	end
	while noChange < 10 do
		w = hs.window.get('BlueStacks 앱 플레이어')
		if w == nil or not w:isVisible() then
			break
		end
		local f = string.format('~/.book/%04d.png', i)
		hs.timer.usleep(300000)
		hs.execute(string.format('screencapture -o -l%d %s', w:id(), f))
		hs.execute(string.format('/usr/local/opt/imagemagick/bin/convert -crop %dx%d+%d+%d %s %s', size.w * 2 - (ml + mr), size.h * 2 - (mt + mb), ml, mt, f, f))
		--local kk = string.format('/usr/local/opt/imagemagick/bin/convert -crop %dx%d+%d+%d %s %s', size.w, size.h -70, 0, 22, f, f)
		u = hs.execute(string.format('/usr/local/opt/imagemagick/bin/compare -metric ae -fuzz 5%% %s ~/.book/%04d.png null: 2>&1', f, i - 1))
		diff = tonumber(u)
		if diff == nil or diff > 40000 then
			hs.eventtap.leftClick({x = pos.x + size.w - 20, y = pos.y + size.h / 2 })
			i = i + 1
			noChange = 0
		elseif diff == 0 then
			noChange = noChange + 1
			if noChange % 4 == 3 then
				hs.eventtap.leftClick({x = pos.x + size.w - 20, y = pos.y + size.h / 2 })
				hs.execute(string.format('echo "[CLICK] %04d - %04d = %s" >> %s', i - 1, i, diff, logFile))
			else
				hs.execute(string.format('echo "[WAIT] %04d - %04d = %s" >> %s', i - 1, i, diff, logFile))
			end
		else
			hs.execute(string.format('/usr/local/opt/imagemagick/bin/convert -fill black -draw "rectangle 400, 1485, 795, 1575" ~/.book/%04d.png %s', i, temp1))
			hs.execute(string.format('/usr/local/opt/imagemagick/bin/convert -fill black -draw "rectangle 400, 1485, 795, 1575" ~/.book/%04d.png %s', i - 1, temp2))
			u = hs.execute(string.format('/usr/local/opt/imagemagick/bin/compare -metric ae -fuzz 5%% %s %s null: 2>&1', temp1, temp2))
			if tonumber(u) == 0 then
				break
			end
			hs.execute(string.format('/usr/local/opt/imagemagick/bin/convert -fill black -draw "rectangle 550, 800, 650, 900" ~/.book/%04d.png %s', i, temp1))
			hs.execute(string.format('/usr/local/opt/imagemagick/bin/convert -fill black -draw "rectangle 550, 800, 650, 900" ~/.book/%04d.png %s', i - 1, temp2))
			u = hs.execute(string.format('/usr/local/opt/imagemagick/bin/compare -metric ae -fuzz 5%% %s %s null: 2>&1', temp1, temp2))
			if tonumber(u) == 0 then
				hs.execute(string.format('echo "[WAIT] %04d - %04d = %s" >> %s', i - 1, i, diff, logFile))
			else
				hs.eventtap.leftClick({x = pos.x + size.w - 20, y = pos.y + size.h / 2 })
				i = i + 1
				noChange = 0
			end

		end
		if i > 1600 then
			break
		end
	end
	if w ~= nil and w:isVisible() then
		hs.execute('rm -rif ~/.book/'..string.format('%04d.png', i))
		hs.execute('rm -rif '..temp1)
		hs.execute('rm -rif '..temp2)
		local temp = os.tmpname().. '.zip'
		hs.execute('zip -j '.. temp ..' ~/.book/*.png')
		local pdf = os.tmpname().. '.pdf'
		hs.execute('/usr/local/opt/imagemagick/bin/convert ~/.book/*.png -page 500x700 -compress zip '.. pdf)

		hs.execute('ftp -u "ftp://userid:password@mintyeye.iptime.org/Book/zip/'..bookName..'.zip" '..temp)
		hs.execute('ftp -u "ftp://userid:password@mintyeye.iptime.org/Book/pdf/'..bookName..'.pdf" '..pdf)
		hs.execute(string.format('mv %s ~/.book/log.txt', logFile))
	end
	hs.notify.new({title="Hammerspoon", informativeText="finished: "..bookName}):send()
end
hs.notify.new({title="Hammerspoon", informativeText="Successfully reloaded"}):send()
