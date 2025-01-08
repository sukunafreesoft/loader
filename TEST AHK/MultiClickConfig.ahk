#Persistent
#NoEnv
#SingleInstance, Force
SetBatchLines, -1
CoordMode, Pixel, Screen
CoordMode, Mouse, Screen

; Переменные
Global IsRunning := false
Global CheckInterval := 50
Global ClickCoordinatesX := [0, 0, 0, 0, 0]
Global ClickCoordinatesY := [0, 0, 0, 0, 0]
Global IsSelecting := false
Global LoopClick := [false, false, false, false, false]  ; Состояние зацикливания

; Создаем GUI
Gui, +Resize +MinSize800x600
Gui, Font, s10, Segoe UI
Gui, Color, 282228 ; Тёмный фон

; Логотип
Gui, Add, Picture, x10 y10 w140 h140, logo.png  ; Укажите путь к вашему логотипу

; Заголовок
Gui, Font, s25 cFuchsia Bold
Gui, Add, Text, x180 y10, ♕ SUKUNA - MultiClick Config

; Подзаголовок
Gui, Font, s12 cGray
Gui, Add, Text, x180 y80, Telegram : @ssukunaa_228228 | TikTok : @ssukunaa228`n`nНастройте координаты, задержку и зацыкливание для каждого клика.

; Ползунки, кнопки координат и флажки зацикливания
Gui, Font, s10 cWhite
Loop, 5 {
    yPos := (A_Index * 60 + 120)
    Gui, Add, Text, x20 y%yPos%, Задержка %A_Index%:
    Gui, Add, Slider, vSpeed%A_Index% Range1-1000 AltSubmit x120 y%yPos% w200 gUpdateSpeed, 50
    Gui, Add, Text, x330 y%yPos% w50 vSpeedText%A_Index%, 50 ms
    Gui, Add, Button, x400 y%yPos% w100 h30 gSetCoordinateHandler, 📍 Клик %A_Index%
    Gui, Add, Text, x520 y%yPos% vCoord%A_Index%, X: 0 Y: 0
    Gui, Add, Checkbox, x620 y%yPos% vLoopFlag%A_Index% gToggleLoop, 🔄 Зациклить
}

; Управляющие кнопки
Gui, Font, s13 Bold
Gui, Add, Button, x50 y490 w130 h50 cWhite BackgroundGreen gStartScriptHandler, ▶ Play F4
Gui, Add, Button, x200 y490 w130 h50 cBlack BackgroundYellow gPauseScriptHandler, ⏸ Pause F5
Gui, Add, Button, x350 y490 w130 h50 gRestartScriptHandler, 🔄 Restart F8
Gui, Add, Button, x500 y490 w130 h50 cWhite BackgroundRed gExitScriptHandler, ⏹ Exit F7
Gui, Add, Button, x650 y490 w130 h50 gOpenTelegramHandler, 📲 Telegram

; Показ GUI
Gui, Show, w850 h500, ♕ SUKUNA - MultiClick Config
Return

; Метки обновления
UpdateSpeed:
    Loop, 5 {
        GuiControlGet, Speed, , Speed%A_Index%
        GuiControl,, SpeedText%A_Index%, %Speed% ms
    }
Return

; Функция для записи координат
SetCoordinateHandler:
    GuiControlGet, ButtonText, FocusV
    RegExMatch(ButtonText, "\d+", Index)  ; Извлекаем номер кнопки
    SetCoordinate(Index)
Return

SetCoordinate(Index) {
    Global IsSelecting, ClickCoordinatesX, ClickCoordinatesY
    IsSelecting := true
    ToolTip, Наведите курсор и нажмите ЛКМ для записи координат.

    ; Ждем нажатия ЛКМ
    Loop {
        if (!IsSelecting)
            Break
        MouseGetPos, X, Y
        ToolTip, X: %X% Y: %Y%
        Sleep, 50
    }

    ClickCoordinatesX[Index] := X
    ClickCoordinatesY[Index] := Y

    GuiControl,, Coord%Index%, X: %X% Y: %Y%
    ToolTip
}

~LButton::
    if (IsSelecting) {
        IsSelecting := false
    }
Return

; Управление скриптом
StartScriptHandler:
    StartScript()
Return

PauseScriptHandler:
    PauseScript()
Return

ExitScriptHandler:
    ExitScript()
Return

RestartScriptHandler:
    Reload  ; Перезапускает текущий скрипт
Return

ClickCoordinates:
    if (IsRunning) {
        Loop, 5 {
            X := ClickCoordinatesX[A_Index]
            Y := ClickCoordinatesY[A_Index]
            GuiControlGet, Speed, , Speed%A_Index%
            LoopFlag := LoopClick[A_Index]
            if (X != 0 && Y != 0) {
                if (LoopFlag) {  ; Зацикленный клик
                    While (IsRunning && LoopClick[A_Index]) {
                        PerformClick(X, Y, Speed)
                    }
                } else {
                    PerformClick(X, Y, Speed)
                }
            }
        }
    }
Return

PerformClick(X, Y, Speed) {
    DllCall("SetCursorPos", "Int", X, "Int", Y)
    DllCall("mouse_event", "UInt", 2, "Int", 0, "Int", 0, "UInt", 0, "UInt", 0) ; Нажатие
    Sleep, 10
    DllCall("mouse_event", "UInt", 4, "Int", 0, "Int", 0, "UInt", 0, "UInt", 0) ; Отпускание
    Sleep, Speed
}

; Функция переключения состояния флажка
ToggleLoop:
    GuiControlGet, ButtonText, FocusV
    RegExMatch(ButtonText, "\d+", Index)  ; Извлекаем номер флажка
    GuiControlGet, LoopState, , LoopFlag%Index%
    LoopClick[Index] := LoopState
Return

; Кнопка открытия Telegram
OpenTelegramHandler:
    Run, https://t.me/sukunasoft  ; Замените на ссылку на ваш Telegram
Return

GuiClose:
    ExitApp

; Горячие клавиши
F4::
    StartScript()
Return

F5::
    PauseScript()
Return

F7::
    ExitScript()
Return

F8::
    Reload  ; Горячая клавиша для рестарта
Return

; Функции запуска, паузы и выхода
StartScript() {
    Global IsRunning
    IsRunning := true
    SetTimer, ClickCoordinates, %CheckInterval%
    ToolTip, Скрипт запущен!
    Sleep, 500
    ToolTip
}

PauseScript() {
    Global IsRunning
    IsRunning := false
    SetTimer, ClickCoordinates, Off
    ToolTip, Скрипт приостановлен!
    Sleep, 500
    ToolTip
}

ExitScript() {
    ToolTip, Скрипт завершён!
    Sleep, 500
    ExitApp
}
