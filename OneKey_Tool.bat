@echo off
mode con cols=100 lines=30
color 0b
title PotPlayer Portable OneKey Tool

echo PotPlayer ��ɫ��Я��һ���������� v1.0.0
echo ===============================================================================
echo ��������������������ɫ��Я�� PotPlayer������32λ��64λ����ɫ��PotPlayer��дע���
echo ===============================================================================
echo ��ѡ����Ҫ���ӵĶ������������ࣺ
echo 1.���������� OpenCodec (ռ��Ӳ�̿ռ�ϴ�)
echo 2.ֻ���� FFmpegMininum (ռ��Ӳ�̿ռ��С)
echo ===============================================================================
:choice0
set /p choice=������Ӧѡ��ǰ�����֣������س���
if /i %choice%==2 goto FFmpegMininum
if /i %choice%==1 goto OpenCodec
echo ������Ч�����������룡
goto choice0

:OpenCodec
:: �ӹ������ذ�װ��
cd /d %~dp0
wget.exe -N --no-check-certificate https://t1.daumcdn.net/potplayer/PotPlayer/Version/Latest/PotPlayerSetup.exe
wget.exe -N --no-check-certificate https://t1.daumcdn.net/potplayer/PotPlayer/Version/Latest/PotPlayerSetup64.exe
:: ��ѡ���ص�ַ
:: wget.exe -N --no-check-certificate https://get.daum.net/PotPlayer/Version/Latest/PotPlayerSetup.exe
:: wget.exe -N --no-check-certificate https://get.daum.net/PotPlayer64/Version/Latest/PotPlayerSetup64.exe
wget.exe -N --no-check-certificate https://get.daum.net/PotPlayer/Codec/OpenCodecSetup.exe
wget.exe -N --no-check-certificate https://get.daum.net/PotPlayer/Codec/OpenCodecSetup64.exe
title PotPlayer Portable OneKey Tool
:: ��ȡ PotPlayer �汾�Ų������ļ���
set batPath =%~dp0
for /f "skip=1 tokens=2 delims==" %%i in (
  'wmic datafile where "name='%batPath :\=\\%PotPlayerSetup.exe'" get Version /format:list'
) do for /f "delims=" %%v in ("%%i") do set "version=%%v"
mkdir PotPlayer_%version%
:: ��ѹ32λ�� Potplayer
7z.exe x PotPlayerSetup.exe -o.\PotPlayer -y
:: �����ļ�
cd PotPlayer
rd /s /q $0
rd /s /q $PLUGINSDIR
rd /s /q Html
if exist Logos\PotPlayer_1.png (del /f /q Logos\PotPlayer.png & rename Logos\PotPlayer_1.png PotPlayer.png)
del /f /q UrlList
rename History\Chinese(Simplified).txt Chinese(Simplified).bak
rename History\English.txt English.bak
rename History\Korean.txt Korean.bak
rename Language\Chinese(Simplified).ini Chinese(Simplified).bak
rename Language\English.ini English.bak
rename Language\Korean.ini Korean.bak
del /f /q History\*.txt
del /f /q Language\*.ini
rename History\Chinese(Simplified).bak Chinese(Simplified).txt
rename History\English.bak English.txt
rename History\Korean.bak Korean.txt
rename Language\Chinese(Simplified).bak Chinese(Simplified).ini
rename Language\English.bak English.ini
rename Language\Korean.bak Korean.ini
md Module\FFmpeg
del /f Alarm.wav
del /f D_Exec.exe
del /f DesktopHook.exe
del /f FileList.txt
del /f KillPot.exe
del /f LGPL.TXT
del /f LogManager.exe
del /f PotNotify.exe
del /f PotPlayer.exe
del /f PotPlayerXP.exe
del /f PotScreenSaver.scr
del /f uninstall.exe.nsis
md For_WinXP_User
move PotPlayerMiniXP.exe For_WinXP_User
move DesktopHook.dll For_WinXP_User
rename For_WinXP_User\PotPlayerMiniXP.exe PotPlayerMini.exe
:: ����Ƥ���ļ� ini�����ļ���
xcopy /s /i /y ..\Data\Skins .\Skins
copy ..\Data\PotPlayerMini64.ini .\
rename .\PotPlayerMini64.ini PotPlayerMini.ini
copy ..\Data\readme.txt .\For_WinXP_User
:: ��ȡ OpenCodec ����������Ӧλ��
cd ..
7z.exe x OpenCodecSetup.exe -o.\OpenCodecSetup -y
xcopy /s /i /y .\OpenCodecSetup\Module .\PotPlayer\Module
:: ������ɫ���ѹ������
7z a PotPlayer.7z PotPlayer\
rename PotPlayer.7z PotPlayer_%version%_Public.7z
move PotPlayer_%version%_Public.7z PotPlayer_%version%
rename PotPlayerSetup.exe PotPlayerSetup_%version%_Public.exe
move PotPlayerSetup_%version%_Public.exe PotPlayer_%version%
move OpenCodecSetup.exe PotPlayer_%version%
rd /s /q PotPlayer
rd /s /q OpenCodecSetup
:: ��ѹ����64λ�� Potplayer
7z.exe x PotPlayerSetup64.exe -o.\PotPlayer64 -y
cd PotPlayer64
rd /s /q $0
rd /s /q $PLUGINSDIR
rd /s /q Html
if exist Logos\PotPlayer_1.png (del /f /q Logos\PotPlayer.png & rename Logos\PotPlayer_1.png PotPlayer.png)
del /f /q UrlList
rename History\Chinese(Simplified).txt Chinese(Simplified).bak
rename History\English.txt English.bak
rename History\Korean.txt Korean.bak
rename Language\Chinese(Simplified).ini Chinese(Simplified).bak
rename Language\English.ini English.bak
rename Language\Korean.ini Korean.bak
del /f /q History\*.txt
del /f /q Language\*.ini
rename History\Chinese(Simplified).bak Chinese(Simplified).txt
rename History\English.bak English.txt
rename History\Korean.bak Korean.txt
rename Language\Chinese(Simplified).bak Chinese(Simplified).ini
rename Language\English.bak English.ini
rename Language\Korean.bak Korean.ini
md Module\FFmpeg
del /f Alarm.wav
del /f D_Exec64.exe
del /f DesktopHook64.dll
del /f DesktopHook64.exe
del /f FileList.txt
del /f KillPot64.exe
del /f LGPL.TXT
del /f LogManager.exe
del /f PotNotify64.exe
del /f PotPlayer64.exe
del /f PotPlayerMiniXP64.exe
del /f PotPlayerXP64.exe
del /f PotScreenSaver64.scr
del /f uninstall.exe.nsis
xcopy /s /i /y ..\Data\Skins .\Skins
copy ..\Data\PotPlayerMini64.ini .\
cd ..
7z.exe x OpenCodecSetup64.exe -o.\OpenCodecSetup64 -y
xcopy /s /i /y .\OpenCodecSetup64\Module .\PotPlayer64\Module
7z a PotPlayer64.7z PotPlayer64\
rename PotPlayer64.7z PotPlayer64_%version%_Public.7z
move PotPlayer64_%version%_Public.7z PotPlayer_%version%
rename PotPlayerSetup64.exe PotPlayerSetup64_%version%_Public.exe
move PotPlayerSetup64_%version%_Public.exe PotPlayer_%version%
move OpenCodecSetup64.exe PotPlayer_%version%
rd /s /q PotPlayer64
rd /s /q OpenCodecSetup64
goto end1

:FFmpegMininum
:: �ӹ����������谲װ��
cd /d %~dp0
wget.exe -N --no-check-certificate https://t1.daumcdn.net/potplayer/PotPlayer/Version/Latest/PotPlayerSetup.exe
wget.exe -N --no-check-certificate https://t1.daumcdn.net/potplayer/PotPlayer/Version/Latest/PotPlayerSetup64.exe
:: ��ѡ���ص�ַ
:: wget.exe -N --no-check-certificate https://get.daum.net/PotPlayer/Version/Latest/PotPlayerSetup.exe
:: wget.exe -N --no-check-certificate https://get.daum.net/PotPlayer64/Version/Latest/PotPlayerSetup64.exe
wget.exe -N --no-check-certificate https://get.daum.net/PotPlayer/v4/Module/FFmpeg/FFmpegMininum.dll
wget.exe -N --no-check-certificate https://get.daum.net/PotPlayer64/v4/Module/FFmpeg/FFmpegMininum64.dll
title PotPlayer Portable OneKey Tool
:: ��ȡ PotPlayer �汾�Ų������ļ���
set batPath =%~dp0
for /f "skip=1 tokens=2 delims==" %%i in (
  'wmic datafile where "name='%batPath :\=\\%PotPlayerSetup.exe'" get Version /format:list'
) do for /f "delims=" %%v in ("%%i") do set "version=%%v"
mkdir PotPlayer_%version%
:: ��ѹ����32λ�� Potplayer
7z.exe x PotPlayerSetup.exe -o.\PotPlayer -y
cd PotPlayer
rd /s /q $0
rd /s /q $PLUGINSDIR
rd /s /q Html
if exist Logos\PotPlayer_1.png (del /f /q Logos\PotPlayer.png & rename Logos\PotPlayer_1.png PotPlayer.png)
del /f /q UrlList
rename History\Chinese(Simplified).txt Chinese(Simplified).bak
rename History\English.txt English.bak
rename History\Korean.txt Korean.bak
rename Language\Chinese(Simplified).ini Chinese(Simplified).bak
rename Language\English.ini English.bak
rename Language\Korean.ini Korean.bak
del /f /q History\*.txt
del /f /q Language\*.ini
rename History\Chinese(Simplified).bak Chinese(Simplified).txt
rename History\English.bak English.txt
rename History\Korean.bak Korean.txt
rename Language\Chinese(Simplified).bak Chinese(Simplified).ini
rename Language\English.bak English.ini
rename Language\Korean.bak Korean.ini
md Module\FFmpeg
del /f Alarm.wav
del /f D_Exec.exe
del /f DesktopHook.exe
del /f FileList.txt
del /f KillPot.exe
del /f LGPL.TXT
del /f LogManager.exe
del /f PotNotify.exe
del /f PotPlayer.exe
del /f PotPlayerXP.exe
del /f PotScreenSaver.scr
del /f uninstall.exe.nsis
md For_WinXP_User
move PotPlayerMiniXP.exe For_WinXP_User
move DesktopHook.dll For_WinXP_User
rename For_WinXP_User\PotPlayerMiniXP.exe PotPlayerMini.exe
xcopy /s /i /y ..\Data\Skins .\Skins
copy ..\Data\PotPlayerMini64.ini .\
rename .\PotPlayerMini64.ini PotPlayerMini.ini
copy ..\Data\readme.txt .\For_WinXP_User
cd ..
move FFmpegMininum.dll .\PotPlayer\Module\FFmpeg
7z a PotPlayer.7z PotPlayer\
rename PotPlayer.7z PotPlayer_%version%_Public.7z
move PotPlayer_%version%_Public.7z PotPlayer_%version%
rename PotPlayerSetup.exe PotPlayerSetup_%version%_Public.exe
move PotPlayerSetup_%version%_Public.exe PotPlayer_%version%
rd /s /q PotPlayer
:: ��ѹ����64λ�� Potplayer
7z.exe x PotPlayerSetup64.exe -o.\PotPlayer64 -y
cd PotPlayer64
rd /s /q $0
rd /s /q $PLUGINSDIR
rd /s /q Html
if exist Logos\PotPlayer_1.png (del /f /q Logos\PotPlayer.png & rename Logos\PotPlayer_1.png PotPlayer.png)
del /f /q UrlList
rename History\Chinese(Simplified).txt Chinese(Simplified).bak
rename History\English.txt English.bak
rename History\Korean.txt Korean.bak
rename Language\Chinese(Simplified).ini Chinese(Simplified).bak
rename Language\English.ini English.bak
rename Language\Korean.ini Korean.bak
del /f /q History\*.txt
del /f /q Language\*.ini
rename History\Chinese(Simplified).bak Chinese(Simplified).txt
rename History\English.bak English.txt
rename History\Korean.bak Korean.txt
rename Language\Chinese(Simplified).bak Chinese(Simplified).ini
rename Language\English.bak English.ini
rename Language\Korean.bak Korean.ini
md Module\FFmpeg
del /f Alarm.wav
del /f D_Exec64.exe
del /f DesktopHook64.dll
del /f DesktopHook64.exe
del /f FileList.txt
del /f KillPot64.exe
del /f LGPL.TXT
del /f LogManager.exe
del /f PotNotify64.exe
del /f PotPlayer64.exe
del /f PotPlayerMiniXP64.exe
del /f PotPlayerXP64.exe
del /f PotScreenSaver64.scr
del /f uninstall.exe.nsis
xcopy /s /i /y ..\Data\Skins .\Skins
copy ..\Data\PotPlayerMini64.ini .\
cd ..
move FFmpegMininum64.dll .\PotPlayer64\Module\FFmpeg
7z a PotPlayer64.7z PotPlayer64\
rename PotPlayer64.7z PotPlayer64_%version%_Public.7z
move PotPlayer64_%version%_Public.7z PotPlayer_%version%
rename PotPlayerSetup64.exe PotPlayerSetup64_%version%_Public.exe
move PotPlayerSetup64_%version%_Public.exe PotPlayer_%version%
rd /s /q PotPlayer64
goto end2

:end1
cls
echo ===============================================================================
echo PotPlayer ������ɣ����ɵ��ļ�λ�� PotPlayer_%version% �ļ����¡�˵�����£�
echo ===============================================================================
echo 32λ��ɫ��(����������OpenCodec)               PotPlayer_%version%_Public.7z
echo 64λ��ɫ��(����������OpenCodec)               PotPlayer64_%version%_Public.7z
echo 32λ�ٷ���װ��                                PotPlayerSetup_%version%_Public.exe
echo 64λ�ٷ���װ��                                PotPlayerSetup64_%version%_Public.exe
echo 32λ OpenCodec                                OpenCodecSetup.exe
echo 64λ OpenCodec                                OpenCodecSetup64.exe
echo ===============================================================================
goto end

:end2
cls
echo ===============================================================================
echo PotPlayer ������ɣ����ɵ��ļ�λ�� PotPlayer_%version% �ļ����¡�˵�����£�
echo ===============================================================================
echo 32λ��ɫ��(����FFmpegMininum.dll)           PotPlayer_%version%_Public.7z
echo 64λ��ɫ��(����FFmpegMininum64.dll)         PotPlayer64_%version%_Public.7z
echo 32λ�ٷ���װ��                              PotPlayerSetup_%version%_Public.exe
echo 64λ�ٷ���װ��                              PotPlayerSetup64_%version%_Public.exe
echo ===============================================================================
goto end

:end
pause