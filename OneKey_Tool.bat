@echo off
mode con cols=100 lines=30
color 0b
title PotPlayer Portable OneKey Tool
echo PotPlayer ��ɫ��Я��һ���������� v2.0.0
echo ===============================================================================
echo ����������һ�����ء����������� PotPlayer ��ɫ�档�밴��˵��������
echo ===============================================================================
echo ��ѡ��Ҫ�����İ汾��
echo 1.PotPlayer ��ɫ�� 64λ
echo 2.PotPlayer ��ɫ�� 32λ
echo ===============================================================================
:choice0
set /p choice=������Ӧѡ��ǰ�����֣������س���
if /i %choice%==2 goto x86
if /i %choice%==1 goto x64
echo ������Ч�����������룡
goto choice0
:x64
:: �ӹ������ذ�װ��
cd /d %~dp0
:: ��ѡ���ص�ַ
wget.exe -N --no-check-certificate https://t1.daumcdn.net/potplayer/PotPlayer/Version/Latest/PotPlayerSetup64.exe
:: wget.exe -N --no-check-certificate https://get.daum.net/PotPlayer64/Version/Latest/PotPlayerSetup64.exe
:: ��ȡ PotPlayer �汾�Ų������ļ���
set batPath =%~dp0
for /f "skip=1 tokens=2 delims==" %%i in (
  'wmic datafile where "name='%batPath :\=\\%PotPlayerSetup64.exe'" get Version /format:list'
) do for /f "delims=" %%v in ("%%i") do set "version=%%v"
mkdir PotPlayer_%version%
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
cd ..
cls
title PotPlayer Portable OneKey Tool
echo ===============================================================================
echo ��ѡ�񸽼ӵı���������ͣ�
echo 1.���� FFmpegMininum (ռ�ÿռ��С)
echo 2.���������� OpenCodec (ռ�ÿռ�ϴ�)
echo 3.��������ʱ��Ч������ LAVFilters madVR XySubFilter (�����PotPlayer�ֶ����ã�Ѱ�ҽ���취��)
echo ===============================================================================
:choice11
set /p choice=������Ӧѡ��ǰ�����֣������س���
:: if /i %choice%==3 goto madVR
if /i %choice%==2 goto OpenCodec
if /i %choice%==1 goto FFmpegMininum
echo ������Ч�����������룡
goto choice11
:FFmpegMininum
wget.exe -N --no-check-certificate https://get.daum.net/PotPlayer64/v4/Module/FFmpeg/FFmpegMininum64.dll
move FFmpegMininum64.dll .\PotPlayer64\Module\FFmpeg
goto tag11
:OpenCodec
wget.exe -N --no-check-certificate https://get.daum.net/PotPlayer/Codec/OpenCodecSetup64.exe
:: wget.exe -N --no-check-certificate https://t1.daumcdn.net/potplayer/PotPlayer/Codec/OpenCodecSetup64.exe
7z.exe x OpenCodecSetup64.exe -o.\OpenCodecSetup64 -y
xcopy /s /i /y .\OpenCodecSetup64\Module .\PotPlayer64\Module
rd /s /q OpenCodecSetup64
cls
title PotPlayer Portable OneKey Tool
echo ===============================================================================
echo ��ѡ���Ƿ��� OpenCodecSetup64.exe �������ã�
echo 1.��
echo 2.��
echo ===============================================================================
:choice17
set /p choice=������Ӧѡ��ǰ�����֣������س���
if /i %choice%==2 goto keepOpenCodecsetupN
if /i %choice%==1 goto keepOpenCodecsetupY
echo ������Ч�����������룡
goto choice17
:keepOpenCodecsetupY
move OpenCodecSetup64.exe PotPlayer_%version%
goto tag11
:keepOpenCodecsetupN
del /f OpenCodecSetup64.exe
goto tag11
:madVR
:: �ݿգ������PotPlayer�ֶ����ã�Ѱ�ҽ���취�С�
:tag11
cls
title PotPlayer Portable OneKey Tool
echo ===============================================================================
echo ��ѡ���Ƿ񸽼�Ƥ���ļ���
echo 1.��
echo 2.��
echo ===============================================================================
:choice12
set /p choice=������Ӧѡ��ǰ�����֣������س���
if /i %choice%==2 goto SkinsN
if /i %choice%==1 goto SkinsY
echo ������Ч�����������룡
goto choice12
:SkinsY
xcopy /s /i /y .\Data\Skins .\PotPlayer64\Skins
goto tag12
:SkinsN
goto tag12
:tag12
cls
title PotPlayer Portable OneKey Tool
echo ===============================================================================
echo ��ѡ���Ƿ񸽼�TVֱ��Դ(���ڹۿ�����ֱ��)��
echo 1.��
echo 2.��
echo ===============================================================================
:choice13
set /p choice=������Ӧѡ��ǰ�����֣������س���
if /i %choice%==2 goto TVlistN
if /i %choice%==1 goto TVlistY
echo ������Ч�����������룡
goto choice13
:TVlistY
xcopy /s /i /y .\Data\Playlist .\PotPlayer64\Playlist
goto tag13
:TVlistN
goto tag13
:tag13
cls
title PotPlayer Portable OneKey Tool
echo ===============================================================================
echo ���� Update_Tool �� PotPlayer �ļ����¡�
echo ����һ������ PotPlayer �������ȶ��棬���������á�
echo ��ע�⣡������ʱ�������� PotPlayer x64 with all OpenCodec�����������ѡ��
echo ===============================================================================
echo ��ѡ���Ƿ񸽼� Update Tool��
echo 1.��
echo 2.��
echo ===============================================================================
:choice14
set /p choice=������Ӧѡ��ǰ�����֣������س���
if /i %choice%==2 goto updatetoolN
if /i %choice%==1 goto updatetoolY
echo ������Ч�����������룡
goto choice14
:updatetoolY
cd PotPlayer64
mkdir Update_Tool
xcopy /s /i /y ..\Data\Update_Tool\Update_Tool_x64_OpenCodec.bat .\Update_Tool\
rename .\Update_Tool\Update_Tool_x64_OpenCodec.bat Update_Tool.bat
xcopy /s /i /y ..\Data\x64\* .\Update_Tool\
cd ..
goto tag14
:updatetoolN
goto tag14
:tag14
cls
title PotPlayer Portable OneKey Tool
echo ===============================================================================
echo ��ѡ���Ƿ����Զ�������(����ֻ���Զ������µĿ��أ������Զ����أ�����Ŀ���)��
echo 1.��
echo 2.��
echo ===============================================================================
:choice15
set /p choice=������Ӧѡ��ǰ�����֣������س���
if /i %choice%==2 goto checkupdateN
if /i %choice%==1 goto checkupdateY
echo ������Ч�����������룡
goto choice15
:checkupdateY
copy .\Data\Config\PotPlayerMini64_AutoCheckUpdate.ini .\PotPlayer64\
rename .\PotPlayer64\PotPlayerMini64_AutoCheckUpdate.ini PotPlayerMini64.ini
goto tag15
:checkupdateN
copy .\Data\Config\PotPlayerMini64.ini .\PotPlayer64\
goto tag15
:tag15
7z a PotPlayer64.7z PotPlayer64\
rename PotPlayer64.7z PotPlayer64_%version%_Public.7z
move PotPlayer64_%version%_Public.7z PotPlayer_%version%
rd /s /q PotPlayer64
cls
title PotPlayer Portable OneKey Tool
echo ===============================================================================
echo ��ѡ���Ƿ��� PotPlayerSetup64.exe �������ã�
echo 1.��
echo 2.��
echo ===============================================================================
:choice16
set /p choice=������Ӧѡ��ǰ�����֣������س���
if /i %choice%==2 goto keepsetupN
if /i %choice%==1 goto keepsetupY
echo ������Ч�����������룡
goto choice16
:keepsetupY
rename PotPlayerSetup64.exe PotPlayerSetup64_%version%_Public.exe
move PotPlayerSetup64_%version%_Public.exe PotPlayer_%version%
goto tag16
:keepsetupN
del /f PotPlayerSetup64.exe
goto tag16
:tag16
goto end1

:x86
:: �ӹ������ذ�װ��
cd /d %~dp0
:: ��ѡ���ص�ַ
wget.exe -N --no-check-certificate https://t1.daumcdn.net/potplayer/PotPlayer/Version/Latest/PotPlayerSetup.exe
:: wget.exe -N --no-check-certificate https://get.daum.net/PotPlayer/Version/Latest/PotPlayerSetup.exe
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
cls
title PotPlayer Portable OneKey Tool
echo ===============================================================================
echo ��ѡ���Ƿ��� XP ϵͳ��֧���ļ��������ã�
echo 1.��
echo 2.��
echo ===============================================================================
:choice28
set /p choice=������Ӧѡ��ǰ�����֣������س���
if /i %choice%==2 goto xpN
if /i %choice%==1 goto xpY
echo ������Ч�����������룡
goto choice28
:xpY
md For_WinXP_User
move PotPlayerMiniXP.exe For_WinXP_User
move DesktopHook.dll For_WinXP_User
rename For_WinXP_User\PotPlayerMiniXP.exe PotPlayerMini.exe
copy ..\Data\WinXP\readme.txt .\For_WinXP_User
goto tag28
:xpN
del /f PotPlayerMiniXP.exe
del /f DesktopHook.dll
goto tag28
:tag28
cd ..
cls
title PotPlayer Portable OneKey Tool
echo ===============================================================================
echo ��ѡ�񸽼ӵı���������ͣ�
echo 1.���� FFmpegMininum (ռ�ÿռ��С)
echo 2.���������� OpenCodec (ռ�ÿռ�ϴ�)
echo 3.��������ʱ��Ч������ LAVFilters madVR XySubFilter (�����PotPlayer�ֶ����ã�Ѱ�ҽ���취��)
echo ===============================================================================
:choice21
set /p choice=������Ӧѡ��ǰ�����֣������س���
:: if /i %choice%==3 goto madVR_x86
if /i %choice%==2 goto OpenCodec_x86
if /i %choice%==1 goto FFmpegMininum_x86
echo ������Ч�����������룡
goto choice21
:FFmpegMininum_x86
wget.exe -N --no-check-certificate https://get.daum.net/PotPlayer/v4/Module/FFmpeg/FFmpegMininum.dll
move FFmpegMininum.dll .\PotPlayer\Module\FFmpeg
goto tag21
:OpenCodec_x86
wget.exe -N --no-check-certificate https://get.daum.net/PotPlayer/Codec/OpenCodecSetup.exe
:: wget.exe -N --no-check-certificate https://t1.daumcdn.net/potplayer/PotPlayer/Codec/OpenCodecSetup.exe
7z.exe x OpenCodecSetup.exe -o.\OpenCodecSetup -y
xcopy /s /i /y .\OpenCodecSetup\Module .\PotPlayer\Module
rd /s /q OpenCodecSetup
cls
title PotPlayer Portable OneKey Tool
echo ===============================================================================
echo ��ѡ���Ƿ��� OpenCodecSetup.exe �������ã�
echo 1.��
echo 2.��
echo ===============================================================================
:choice27
set /p choice=������Ӧѡ��ǰ�����֣������س���
if /i %choice%==2 goto keepOpenCodecsetupN_x86
if /i %choice%==1 goto keepOpenCodecsetupY_x86
echo ������Ч�����������룡
goto choice27
:keepOpenCodecsetupY_x86
move OpenCodecSetup.exe PotPlayer_%version%
goto tag21
:keepOpenCodecsetupN_x86
del /f OpenCodecSetup.exe
goto tag21
:madVR_x86
:: �ݿգ������PotPlayer�ֶ����ã�Ѱ�ҽ���취�С�
:tag21
cls
title PotPlayer Portable OneKey Tool
echo ===============================================================================
echo ��ѡ���Ƿ񸽼�Ƥ���ļ���
echo 1.��
echo 2.��
echo ===============================================================================
:choice22
set /p choice=������Ӧѡ��ǰ�����֣������س���
if /i %choice%==2 goto SkinsN_x86
if /i %choice%==1 goto SkinsY_x86
echo ������Ч�����������룡
goto choice22
:SkinsY_x86
xcopy /s /i /y .\Data\Skins .\PotPlayer\Skins
goto tag22
:SkinsN_x86
goto tag22
:tag22
cls
title PotPlayer Portable OneKey Tool
echo ===============================================================================
echo ��ѡ���Ƿ񸽼�TVֱ��Դ(���ڹۿ�����ֱ��)��
echo 1.��
echo 2.��
echo ===============================================================================
:choice23
set /p choice=������Ӧѡ��ǰ�����֣������س���
if /i %choice%==2 goto TVlistN_x86
if /i %choice%==1 goto TVlistY_x86
echo ������Ч�����������룡
goto choice23
:TVlistY_x86
xcopy /s /i /y .\Data\Playlist .\PotPlayer\Playlist
goto tag23
:TVlistN_x86
goto tag23
:tag23
:: ��ʱ���գ����ڼ��� update tool x86
:tag24
cls
title PotPlayer Portable OneKey Tool
echo ===============================================================================
echo ��ѡ���Ƿ����Զ�������(����ֻ���Զ������µĿ��أ������Զ����أ�����Ŀ���)��
echo 1.��
echo 2.��
echo ===============================================================================
:choice25
set /p choice=������Ӧѡ��ǰ�����֣������س���
if /i %choice%==2 goto checkupdateN_x86
if /i %choice%==1 goto checkupdateY_x86
echo ������Ч�����������룡
goto choice25
:checkupdateY_x86
copy .\Data\Config\PotPlayerMini64_AutoCheckUpdate.ini .\PotPlayer\
rename .\PotPlayer\PotPlayerMini64_AutoCheckUpdate.ini PotPlayerMini.ini
goto tag25
:checkupdateN_x86
copy .\Data\Config\PotPlayerMini64.ini .\PotPlayer\
rename .\PotPlayer\PotPlayerMini64.ini PotPlayerMini.ini
goto tag25
:tag25
7z a PotPlayer.7z PotPlayer\
rename PotPlayer.7z PotPlayer_%version%_Public.7z
move PotPlayer_%version%_Public.7z PotPlayer_%version%
rd /s /q PotPlayer
cls
title PotPlayer Portable OneKey Tool
echo ===============================================================================
echo ��ѡ���Ƿ��� PotPlayerSetup.exe �������ã�
echo 1.��
echo 2.��
echo ===============================================================================
:choice26
set /p choice=������Ӧѡ��ǰ�����֣������س���
if /i %choice%==2 goto keepsetupN_x86
if /i %choice%==1 goto keepsetupY_x86
echo ������Ч�����������룡
goto choice26
:keepsetupY_x86
rename PotPlayerSetup.exe PotPlayerSetup_%version%_Public.exe
move PotPlayerSetup_%version%_Public.exe PotPlayer_%version%
goto tag26
:keepsetupN_x86
del /f PotPlayerSetup.exe
goto tag26
:tag26
goto end1

:end1
cls
echo ===============================================================================
echo PotPlayer ��ɫ�� ������ɡ�
echo ===============================================================================
echo ���ɵ��ļ�λ�ڡ�PotPlayer_%version%���ļ����¡�
echo ===============================================================================
goto end
:end
pause
