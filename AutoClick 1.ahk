#Persistent
#NoEnv
SetBatchLines, -1
CoordMode, Mouse, Screen

; Переменные
Global IsRunning := false
Global ClickInterval := 500 ; Интервал между кликами (мс, по умолчанию 500)
TelegramLink := "https://t.me/sukunasoft" ; Ссылка на Telegram

; Настройка GUI
Gui, Font, s12, Segoe UI
Gui, Color, 1e1e2e  ; Темный стильный фон

; Заголовок
Gui, Font, s16 cLime Bold
Gui, Add, Text, x20 y20, 🖱️ SUKUNA - MultiClick

Gui, Font, s10 cGray
Gui, Add, Text, x20 y60, Быстрый автокликер с настройкой скорости.

; Слайдер для настройки скорости
Gui, Font, s12, Segoe UI
Gui, Add, Text, x20 y100 cWhite, Скорость кликов (мс):
Gui, Add, Slider, x200 y100 w300 Range1-1000 vClickInterval gUpdateSpeed, %ClickInterval%
Gui, Add, Text, x520 y100 w100 vSpeedDisplay cLime, %ClickInterval% мс ; Отображение текущей скорости

; Кнопки управления
Gui, Font, s12 Bold, Segoe UI Symbol
Gui, Add, Button, x50 y160 w80 h80 BackgroundGreen cWhite gStartScript, ▶ F4
Gui, Add, Button, x160 y160 w80 h80 BackgroundYellow cBlack gPauseScript, ⏸ F5
Gui, Add, Button, x270 y160 w80 h80 BackgroundRed cWhite gExitScript, ⏹ F7

; Разделитель
Gui, Font, s10 cGray
Gui, Add, Text, x20 y260 w500, ────────────────────────────────────────────

; Кликабельная кнопка Telegram
Gui, Font, s10 CSkyBlue Bold
Gui, Add, Button, x20 y300 w200 h40 gOpenTelegram BackgroundGray, 📩 Наш Telegram

; Показ GUI
Gui, Show, w650 h400, 🖱️ SUKUNA - MultiClick
Return

; Запуск автокликера
StartScript:
    IsRunning := true
    SetTimer, FastClick, %ClickInterval%
    ToolTip, Скрипт запущен! (F4)
    Sleep, 500
    ToolTip
Return

; Пауза автокликера
PauseScript:
    IsRunning := false
    SetTimer, FastClick, Off
    ToolTip, Скрипт приостановлен! (F5)
    Sleep, 500
    ToolTip
Return

; Завершение скрипта
ExitScript:
    ToolTip, Скрипт завершён! (F7)
    Sleep, 500
    ExitApp
Return

; Открытие Telegram
OpenTelegram:
    Run, %TelegramLink%
Return

; Обновление скорости кликов
UpdateSpeed:
    Gui, Submit, NoHide
    GuiControl,, SpeedDisplay, %ClickInterval% мс ; Обновить отображение текущей скорости
Return

; Основная функция для кликов
FastClick:
    if (IsRunning) {
        ; Эмуляция клика мыши
        DllCall("mouse_event", "UInt", 2, "UInt", 0, "UInt", 0, "UInt", 0, "UInt", 0) ; Нажатие
        Sleep, 10
        DllCall("mouse_event", "UInt", 4, "UInt", 0, "UInt", 0, "UInt", 0, "UInt", 0) ; Отпускание
    }
Return

; Горячие клавиши
F4:: ; Запуск
    Gosub, StartScript
Return

F5:: ; Пауза
    Gosub, PauseScript
Return

F7:: ; Завершение
    Gosub, ExitScript
Return

GuiClose:
    ExitApp
