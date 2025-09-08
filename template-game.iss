; -----------------------------
; Script Inno Setup for template-game
; -----------------------------

[Setup]
; Name display in the installer
AppName=template-gameInstaller
; Version display
AppVersion=2.3.0
; Company (facultatif)
AppPublisher=OMGG
; Website (facultatif)
AppPublisherURL=http://91.134.33.129/

; Default folder of the installation
DefaultDirName={pf}\template-game

; Name of the output file (in OutputDir)
OutputDir=.\Installer
OutputBaseFilename=template-game

; Installer icon (optionnal)
; SetupIconFile=Build\template-game.ico

Compression=zip
SolidCompression=yes

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
; Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"

[Files]
; Copy all Unity build files
Source: "*"; DestDir: "{app}"; Flags: recursesubdirs ignoreversion

[Icons]
; Shortcut in the starting menu
Name: "{group}\template-game"; Filename: "{app}\MonJeu.exe"

; Desktop Shortcut (if enabled in options)
Name: "{commondesktop}\template-game"; Filename: "{app}\template-game.exe"

[Run]
; Launche the game when installation end (optionnal)
Filename: "{app}\template-game.exe"; Description: "{cm:LaunchProgram,template-game}"; Flags: nowait postinstall skipifsilent
