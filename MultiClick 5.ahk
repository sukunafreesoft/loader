#Persistent
#NoEnv
SetBatchLines, -1
CoordMode, Pixel, Screen
CoordMode, Mouse, Screen

; Переменные для управления
Global IsRunning := false
Global CheckInterval := 50  ; Интервал между вызовами функции ClickCoordinates (50 мс)

; Информация об авторе и ссылке
TelegramLink := "https://t.me/sukunasoft"

; Настройки GUI
Gui, Font, s12, Segoe UI
Gui, Color, 1e1e2e  ; Темный стильный фон

; Заголовок
Gui, Font, s16 cLime Bold
Gui, Add, Text, x20 y20, 🖱️ SUKUNA - MultiClick 5

Gui, Font, s10 cGray
Gui, Add, Text, x20 y60, Быстрый автокликер для GTA 5 RP (5 координат). Идеально для такси и других задач.

; Кнопки управления
Gui, Font, s12 Bold, Segoe UI Symbol
Gui, Add, Button, x50 y120 w80 h80 BackgroundGreen cWhite gStartScript, ▶ F4
Gui, Add, Button, x160 y120 w80 h80 BackgroundYellow cBlack gPauseScript, ⏸ F5
Gui, Add, Button, x270 y120 w80 h80 BackgroundRed cWhite gExitScript, ⏹ F7

; Разделитель
Gui, Font, s10 cGray
Gui, Add, Text, x20 y220 w500, ────────────────────────────────────────────

; Кликабельная кнопка Telegram
Gui, Font, s10 CSkyBlue Bold
Gui, Add, Button, x20 y260 w200 h40 gOpenTelegram BackgroundGray, 📩 Наш Telegram

; Показ GUI
Gui, Show, w650 h350, 🖱️ SUKUNA - MultiClick 5
Return

StartScript:
    IsRunning := true
    SetTimer, ClickCoordinates, %CheckInterval%
    ToolTip, Скрипт запущен! (F4)
    Sleep, 500
    ToolTip
Return

PauseScript:
    IsRunning := false
    SetTimer, ClickCoordinates, Off
    ToolTip, Скрипт приостановлен! (F5)
    Sleep, 500
    ToolTip
Return

ExitScript:
    ToolTip, Скрипт завершён! (F7)
    Sleep, 500
    ExitApp
Return

OpenTelegram:
    Run, %TelegramLink%
Return

F4:: ; Горячая клавиша для старта
    Gosub, StartScript
Return

F5:: ; Горячая клавиша для паузы
    Gosub, PauseScript
Return

F7:: ; Горячая клавиша для выхода
    Gosub, ExitScript
Return

ClickCoordinates:
    if (IsRunning) {
        ; Заданные координаты для кликов (X, Y)
        ClickCoordinatesList := [[1293, 445], [1293, 495], [1293, 545], [1293, 595], [1293, 645]]

        ; Клик по каждой координате из списка
        Loop, % ClickCoordinatesList.Length() {
            X := ClickCoordinatesList[A_Index][1]
            Y := ClickCoordinatesList[A_Index][2]

            ; Случайный сдвиг координат (чтобы избежать подозрений)
            Random, OffsetX, -3, 3
            Random, OffsetY, -3, 3
            Random, Delay, 10, 30  ; Случайная задержка между кликами

            ; Перемещение мыши в указанную позицию
            DllCall("SetCursorPos", "Int", X + OffsetX, "Int", Y + OffsetY)

            ; Эмуляция клика через DllCall
            DllCall("mouse_event", "UInt", 2, "Int", 0, "Int", 0, "UInt", 0, "UInt", 0) ; Нажатие
            Sleep, 10
            DllCall("mouse_event", "UInt", 4, "Int", 0, "Int", 0, "UInt", 0, "UInt", 0) ; Отпускание

            ; Пауза между кликами
            Sleep, %Delay%
        }
    }
Return

GuiClose:
    ExitApp
