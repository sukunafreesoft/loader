#Persistent
#NoEnv
SetBatchLines, -1
CoordMode, Mouse, Screen

; Переменные для управления
Global IsRunning := false
Global CheckInterval := 1  ; Интервал обновления (1 мс)
TelegramLink := "https://t.me/sukunasoft" ; Ссылка на Telegram

; Настройка GUI
Gui, Font, s12, Segoe UI
Gui, Color, 1e1e2e  ; Темный стильный фон

; Заголовок
Gui, Font, s16 cLime Bold
Gui, Add, Text, x20 y20, 🖱️ SUKUNA - Координаты мыши

Gui, Font, s10 cGray
Gui, Add, Text, x20 y60, Быстрый инструмент для отображения координат мыши.

; Кнопки управления
Gui, Font, s12 Bold, Segoe UI Symbol
Gui, Add, Button, x50 y120 w80 h80 BackgroundGreen cWhite gStartScript, ▶ F4
Gui, Add, Button, x160 y120 w80 h80 BackgroundYellow cBlack gPauseScript, ⏸ F5
Gui, Add, Button, x270 y120 w80 h80 BackgroundRed cWhite gExitScript, ⏹ F7

; Текущие координаты
Gui, Font, s10 cSkyBlue
Gui, Add, Text, x20 y220 w400 h30 vCoordText, Координаты: X=0 Y=0

; Кликабельная кнопка Telegram
Gui, Font, s10 CSkyBlue Bold
Gui, Add, Button, x20 y260 w200 h40 gOpenTelegram BackgroundGray, 📩 Наш Telegram

; Показ GUI
Gui, Show, w650 h350, 🖱️ SUKUNA - Координаты мыши
Return

StartScript:
    IsRunning := true
    SetTimer, ShowCoords, %CheckInterval%
    ToolTip, Отображение координат включено! (F4)
    Sleep, 1000
    ToolTip
Return

PauseScript:
    IsRunning := false
    SetTimer, ShowCoords, Off
    ToolTip, Отображение координат приостановлено! (F5)
    Sleep, 1000
    ToolTip
Return

ExitScript:
    ToolTip, Скрипт завершён! (F7)
    Sleep, 1000
    ExitApp
Return

ShowCoords:
    if (IsRunning) {
        ; Получение текущих координат мыши
        MouseGetPos, MouseX, MouseY

        ; Обновление текста в GUI
        GuiControl,, CoordText, Координаты: X=%MouseX% Y=%MouseY%
        
        ; Отображение координат возле указателя мыши
        Tooltip, X=%MouseX% Y=%MouseY%, %MouseX% + 15, %MouseY% + 15
    } else {
        Tooltip  ; Очистка подсказки, если скрипт приостановлен
    }
Return

OpenTelegram:
    Run, %TelegramLink%
Return

F4::
    IsRunning := true
    SetTimer, ShowCoords, %CheckInterval%
    ToolTip, Отображение координат включено! (F4)
    Sleep, 1000
    ToolTip
Return

F5::
    IsRunning := false
    SetTimer, ShowCoords, Off
    ToolTip, Отображение координат приостановлено! (F5)
    Sleep, 1000
    ToolTip
Return

F7::
    ToolTip, Скрипт завершён! (F7)
    Sleep, 1000
    ExitApp
Return

GuiClose:
    ExitApp
