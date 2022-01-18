#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.5
 Author: Edgar Ignite

#ce ----------------------------------------------------------------------------

#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <MsgBoxConstants.au3>
#include <File.au3>

#Region ### START Koda GUI section ### Form=
Global $Form1 = GUICreate("Untitled - Notepad", 868, 588, 583, 234, BitOR($GUI_SS_DEFAULT_GUI,$WS_MAXIMIZEBOX,$WS_SIZEBOX,$WS_THICKFRAME,$WS_TABSTOP))
; File Button
Global $MenuItem1 = GUICtrlCreateMenu("&File")
Global $MenuItem6 = GUICtrlCreateMenuItem("New"&@TAB&"Ctrl+N", $MenuItem1)
Global $MenuItem7 = GUICtrlCreateMenuItem("New Windows"&@TAB&"Ctrl+Shift+N", $MenuItem1)
Global $MenuItem8 = GUICtrlCreateMenuItem("Open..."&@TAB&"Ctrl+O", $MenuItem1)
Global $MenuItem9 = GUICtrlCreateMenuItem("Save"&@TAB&"Ctrl+S", $MenuItem1)
Global $MenuItem10 = GUICtrlCreateMenuItem("Save As..."&@TAB&"Ctrl+Shift+S", $MenuItem1)
Global $MenuItem11 = GUICtrlCreateMenuItem("", $MenuItem1)
Global $MenuItem12 = GUICtrlCreateMenuItem("Page Setup...", $MenuItem1)
Global $MenuItem13 = GUICtrlCreateMenuItem("Print..."&@TAB&"Ctrl+P", $MenuItem1)
Global $MenuItem14 = GUICtrlCreateMenuItem("", $MenuItem1)
Global $MenuItem15 = GUICtrlCreateMenuItem("Exit", $MenuItem1)
; Edit Button
Global $MenuItem2 = GUICtrlCreateMenu("&Edit")
Global $MenuItem3 = GUICtrlCreateMenuItem("Undo"&@TAB&"Ctrl+Z", $MenuItem2)
Global $MenuItem4 = GUICtrlCreateMenuItem("", $MenuItem2)
Global $MenuItem16 = GUICtrlCreateMenuItem("Cut"&@TAB&"Ctrl+X", $MenuItem2)
Global $MenuItem17 = GUICtrlCreateMenuItem("Copy"&@TAB&"Ctrl+C", $MenuItem2)
Global $MenuItem18 = GUICtrlCreateMenuItem("Paste"&@TAB&"Ctrl+V", $MenuItem2)
Global $MenuItem19 = GUICtrlCreateMenuItem("Delete"&@TAB&"Del", $MenuItem2)
Global $MenuItem20 = GUICtrlCreateMenuItem("", $MenuItem2)
Global $MenuItem21 = GUICtrlCreateMenuItem("Find"&@TAB&"Ctrl+F", $MenuItem2)
Global $MenuItem22 = GUICtrlCreateMenuItem("Find Next"&@TAB&"F3", $MenuItem2)
Global $MenuItem23 = GUICtrlCreateMenuItem("Find Pervious"&@TAB&"Shift+F3", $MenuItem2)
Global $MenuItem26 = GUICtrlCreateMenuItem("Replace"&@TAB&"Ctrl+H", $MenuItem2)
Global $MenuItem24 = GUICtrlCreateMenuItem("Go to"&@TAB&"Ctrl+G", $MenuItem2)
Global $MenuItem25 = GUICtrlCreateMenuItem("", $MenuItem2)
Global $MenuItem27 = GUICtrlCreateMenuItem("Select all"&@TAB&"Ctrl+A", $MenuItem2)
Global $MenuItem28 = GUICtrlCreateMenuItem("Time/Date"&@TAB&"F5", $MenuItem2)
Global $MenuItem29 = GUICtrlCreateMenuItem("", $MenuItem2)
Global $MenuItem30 = GUICtrlCreateMenuItem("Font", $MenuItem2)
; View Button
Global $MenuItem5 = GUICtrlCreateMenu("&View")
Global $MenuItem31 = GUICtrlCreateMenu("Zoom"&@TAB&"Ctrl+Down", $MenuItem5)
Global $MenuItem32 = GUICtrlCreateMenuItem("Zoom in"&@TAB&"Ctrl+Plus", $MenuItem31)
Global $MenuItem33 = GUICtrlCreateMenuItem("Zoom out"&@TAB&"Ctrl+Minus", $MenuItem31)
Global $MenuItem34 = GUICtrlCreateMenuItem("Restore Default Zoom"&@TAB&"Ctrl+O", $MenuItem31)
Global $MenuItem35 = GUICtrlCreateMenuItem("Status bar", $MenuItem5)
GUICtrlSetState(-1, $GUI_CHECKED)
Global $MenuItem36 = GUICtrlCreateMenuItem("Word map", $MenuItem5)
GUICtrlSetState(-1, $GUI_CHECKED)

; Help Button
Global $MenuItem92 = GUICtrlCreateMenu("&About")
Global $MenuItem93 = GUICtrlCreateMenuItem("Developer"&@TAB&"Ctrl+D", $MenuItem92)

; Main Form
Global $Edit1 = GUICtrlCreateEdit("", 0, 0, 900, 600)
GUICtrlSetResizing(-1, $GUI_DOCKAUTO)
GUICtrlSetFont(-1, 14, 400, 0, "JetBrains Mono")
Global $Form1_AccelTable[11][2] = [["^+{DOWN}", $MenuItem8],["{ENTER}", $MenuItem9],["{F17}", $MenuItem10],["{F9}", $MenuItem11],["{F13}", $MenuItem12],["{CAPS LOCK}", $MenuItem18],["^{SYS REQ}", $MenuItem25],["+4", $MenuItem28],["^{DOWN}", $MenuItem31],["^x", $MenuItem32],["{CAPS LOCK}", $MenuItem36]]
GUISetAccelerators($Form1_AccelTable)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###


Func _IsChecked($idControlID)
    Return BitAND(GUICtrlRead($idControlID), $GUI_CHECKED) = $GUI_CHECKED
EndFunc   ;==>_IsChecked

Func SaveFile($check)
	Local $content = GUICtrlRead($Edit1)
	If $content Then
		Local $fp = FileSaveDialog('Save', @ScriptDir, "Text Documents (*.txt) | All Files(*.*)", 2 + 16, '', $Form1)
		If $fp Then
			FileWrite($fp, $content) ; lưu content vào trong file và lưu lại file
			FileClose($fp) ; đóng file lại

			If $check == True Then
				GUICtrlSetData($Edit1, '') ; reset form data của notepad
			EndIf

			Return $fp ; trả về đường đẫn của file
		EndIf
	Else
		Return 'Untitled'
	EndIf
EndFunc

Func UpdateFileName($fpTemp)
	; đổi tiêu đề windows
	Local $drive, $dir, $fileName, $ext
	Local $arr = _PathSplit($fpTemp, $drive, $dir, $fileName, $ext)
	WinSetTitle($Form1, '', $fileName & $ext & ' - Notepad')
EndFunc

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
		; Files
		Case $MenuItem6 ; New
			; Nếu đang có nội dung thì hỏi người dùng có muốn lưu không
			; Còn không thì không có chuyện gì sảy ra
			SaveFile(True)

		Case $MenuItem7 ; New Windows

		Case $MenuItem8 ; Open
			; hỏi người dùng đường dẫn tới tẹp tin
			; đọc nội dung của tẹp tin
			Local $fp = FileOpenDialog('Open', @ScriptDir, "Text Documents (*.txt) | All Files(*.*)", 1, '', $Form1)
			If $fp Then
				; đọc dữ liệu từ trong file và gán nó vào lại trong notepad
				$fpTemp = FileOpen($fp, 128) ; Mở file ra
				Local $data = FileRead($fpTemp) ; đọc dữ liệu
				FileClose($fpTemp) ; đóng file gốc lại
				GUICtrlSetData($Edit1, $data) ; ghi data lên notepad
				UpdateFileName($fp) ; Cập nhật tiêu đề
			EndIf

		Case $MenuItem9 ; Save
			; Kiểm tra xem người dùng có nhập gì chưa
			; Nhập rồi thì mới lưu
			; Tuy nhiên phần sử lí này giống như Đoạn đầu tiên
			Local $fp = SaveFile(False)
			UpdateFileName($fp) ; Cập nhật tiêu đề

		Case $MenuItem10 ; Save As
		Case $MenuItem12 ; Page Setup
		Case $MenuItem13 ; Print
		Case $MenuItem15 ; Exit
			Exit

		; Edit
		Case $MenuItem3 ; Undo
		Case $MenuItem16 ; Cut
		Case $MenuItem17 ; Copy
		Case $MenuItem18 ; Paste
		Case $MenuItem19 ; Delete
		Case $MenuItem21 ; Find
		Case $MenuItem22 ; Find Next
		Case $MenuItem23 ; Find Previous
		Case $MenuItem26 ; Replace
		Case $MenuItem24 ; Go to
		Case $MenuItem27 ; Select all
		Case $MenuItem28 ; Time/Date
		Case $MenuItem30 ; Font

		; View
		Case $MenuItem31 ; Zoom
		Case $MenuItem32 ; Zoom in
		Case $MenuItem33 ; Zoom out
		Case $MenuItem34 ; Restore Default Zoom

		Case $MenuItem35 ; Status bar
			If _IsChecked($MenuItem35) Then
				GUICtrlSetState($MenuItem35, $GUI_UNCHECKED)
			Else
				GUICtrlSetState($MenuItem35, $GUI_CHECKED)
			EndIf

		Case $MenuItem36 ; Word Map
			If _IsChecked($MenuItem36) Then
				GUICtrlSetState($MenuItem36, $GUI_UNCHECKED)
			Else
				GUICtrlSetState($MenuItem36, $GUI_CHECKED)
			EndIf

		Case $MenuItem93 ; About
			MsgBox(64 + 262144, 'About', 'Developed by Edgar_Ignite')

		; Main form
		Case $Form1
		Case $Edit1
	EndSwitch
WEnd
