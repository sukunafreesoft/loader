; === Лоадер для загрузки и выполнения скрипта напрямую в AHK v1 ===
ExecuteScriptFromURL(URL) {
    ; Создаем объект HTTP-запроса
    HttpRequest := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    
    ; Открываем соединение и отправляем запрос
    HttpRequest.Open("GET", URL, False)
    HttpRequest.Send()
    
    ; Проверяем статус ответа (200 = успешный запрос)
    If (HttpRequest.Status = 200) {
        ; Получаем содержимое скрипта
        ScriptContent := HttpRequest.ResponseText
        
        ; Выполняем скрипт
        Exec(ScriptContent)
    } Else {
        ; Сообщаем об ошибке, если запрос не удался
        MsgBox, 48, Ошибка, Ошибка загрузки файла:`nКод ошибки: %HttpRequest.Status%`nСообщение: %HttpRequest.StatusText%
    }
}

; Функция для выполнения кода AHK
Exec(ScriptCode) {
    ; Создаем временный файл для выполнения скрипта
    TempFile := A_Temp "\TempScript.ahk"
    File := FileOpen(TempFile, "w")
    File.Write(ScriptCode)
    File.Close()
    
    ; Запускаем временный скрипт
    Run, %TempFile%, , UseErrorLevel
}

; === Основная часть программы ===

; Ссылка на скрипт для выполнения
URL := "https://raw.githubusercontent.com/sukunafreesoft/loader/main/MultiScript_v0.2.ahk"

; Загружаем и выполняем скрипт
ExecuteScriptFromURL(URL)
