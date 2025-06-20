@echo off
setlocal enabledelayedexpansion

:: Scrivani DC KARAOKE CUSTOM DISC BUILDER - 20/06/2025 V1.0

:: Navega para o diretório onde os vídeos originais estão
cd put_your_any_kind_videos_here

:: Loop para processar todos os arquivos de vídeo no diretório atual
for %%F in (*.*) do (
    set "inputFile=%%~nF"
    set "extension=%%~xF"

    echo Processando %%F...

    :: Converte o vídeo para MPEG1
    REM NTSC NO FILTERS ..\app\ffmpeg -y -i "%%F" -target ntsc-vcd -aspect 4:3 "!inputFile!_.mpg"
	REM NTSC FILTERS ffmpeg -i input.mp4 \ -filter:v "scale=352:240:flags=lanczos,eq=contrast=1.15:brightness=0.05:saturation=1.3,hqdn3d=4.0:3.0:6.0:4.5,unsharp=5:5:1.0:5:5:0.0" \-target ntsc-vcd -aspect 4:3 "!inputFile!.mpg"
    REM PAL NO FILTERS ..\app\ffmpeg -y -i "%%F" -target pal-vcd -aspect 4:3 "!inputFile!.mpg"
    REM PAL FILTERS ..\app\ffmpeg -y -i "%%F" -filter:v "scale=352:288:flags=lanczos,eq=contrast=1.15:brightness=0.05:saturation=1.3,hqdn3d=4.0:3.0:6.0:4.5,unsharp=5:5:1.0:5:5:0.0" -target pal-vcd -aspect 4:3 "!inputFile!.mpg"
    ..\app\ffmpeg -y -i "%%F" -filter:v "scale=352:288:flags=lanczos,eq=contrast=1.15:brightness=0.05:saturation=1.3,hqdn3d=4.0:3.0:6.0:4.5,unsharp=5:5:1.0:5:5:0.0" -target pal-vcd -aspect 4:3 "!inputFile!.mpg"

    :: Move o arquivo convertido
    move /Y "!inputFile!.mpg" ..\app\KARAGYP\00_KARAOKE_VIDEOS\
)

cd ..\app
mkisofs -C 0,11702 -V KARAGYP -G IP.BIN -l -joliet-long -r -o KARAGYP.iso KARAGYP
cdi4dc KARAGYP.iso DCKARAOKE_ALL_IN_ONE_%DATE:~-4%-%DATE:~-7,-5%-%DATE:~-10,-8%_%time:~-11,2%-%time:~-8,2%.cdi

del *.iso
move /Y *.cdi ..\
move /Y KARAGYP\00_KARAOKE_VIDEOS\*.*  ..\converted_videos\

echo.
echo === Creation is complete ===
pause
exit /b
