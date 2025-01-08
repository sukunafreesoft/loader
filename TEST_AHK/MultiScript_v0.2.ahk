#Persistent
#NoEnv
SetBatchLines, -1
CoordMode, Mouse, Screen

; Переменные
TelegramLink := "https://t.me/sukunasoft" ; Ссылка на Telegram
SelectedScript := "" ; Хранит имя выбранного скрипта

; Настройка GUI
Gui, Font, s12, Segoe UI
Gui, Color, 1e1e2e  ; Темный фон

; Полупрозрачная панель
Gui, Add, Text, x20 y20 w760 h460 BackgroundTrans Border hwndPanel

; Заголовок
Gui, Font, s20 Bold cFuchsia, Segoe UI
Gui, Add, Text, x40 y40, 🎌 SUKUNA - MultiScript Меню

; Подзаголовок
Gui, Font, s10 cWhite
Gui, Add, Text, x40 y80, Выберите скрипт из списка ниже и нажмите "Запустить".

; Список скриптов
Gui, Font, s12 cWhite
Gui, Add, DropDownList, x40 y120 w500 vSelectedScript, 1. AutoClick 1|2. MultiClick 5|3. Coordinates|4. MultiClickConfig|5. Test

; Кнопка запуска
Gui, Font, s12 Bold, Segoe UI
Gui, Add, Button, x570 y120 w150 h40 BackgroundGreen cBlack gRunScript, 🚀 Запустить

; Разделитель
Gui, Add, Text, x40 y180 w720 h2 BackgroundWhite

; Кнопки управления
Gui, Font, s12 Bold
Gui, Add, Button, x40 y220 w200 h50 BackgroundSkyBlue cBlack gOpenTelegram, 📩 Telegram
Gui, Add, Button, x300 y220 w200 h50 BackgroundRed cWhite gExitMenu, ⏹ Выход

; Нижняя информация
Gui, Font, s10 cGray
Gui, Add, Text, x40 y320, © 2025 SUKUNA Soft. Все права защищены.
Gui, Add, Text, x40 y340, Аниме-стиль и яркий интерфейс для удобства использования.

; Показ GUI
Gui, Show, w800 h500, 🎌 SUKUNA - MultiScript Меню
Return

; Запуск выбранного скрипта
RunScript:
    Gui, Submit, NoHide
    if (SelectedScript = "1. AutoClick 1") {
        Run, AutoClick_1.ahk
    } else if (SelectedScript = "2. MultiClick 5") {
        Run, MultiClick_5.ahk
    } else if (SelectedScript = "3. Coordinates") {
        Run, Coordinates.ahk
    } else if (SelectedScript = "4. MultiClickConfig") {
        Run, %A_ScriptDir%\MultiClickConfig.ahk

    } else if (SelectedScript = "4. Test") {
        Run, Test.ahk

    } else {
        MsgBox, 48, ERROR, Скрипт не найден или не выбран, убедитесь что скрипт находиться в одной папке с загрузчиком, также убедитесь в правильном названии скрипта.
    }
Return

; Открытие Telegram
OpenTelegram:
    Run, %TelegramLink%
Return

; Выход из меню
ExitMenu:
    ExitApp
Return

GuiClose:
    ExitApp
