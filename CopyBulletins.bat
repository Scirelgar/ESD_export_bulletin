@echo off

chcp 1252 >nul

goto :Commentaire
Ce script effectue une copie de tous les bulletins se trouvcant dans dirInput vers dirNuage en fonction du dossier de session saisi par l'utilisateur.

Auteur: Samuel Richard
Date: 2023-05-03
Version: 1.0
:Commentaire

SETLOCAL EnableExtensions ENABLEDELAYEDEXPANSION

:: Variables
set dirInput=C:\Users\samue\École Secondaire Duval\Site Établissements scolaires - Partage de fichier\input
set dirNuage=C:\Users\samue\École Secondaire Duval\Site Établissements scolaires - Partage de fichier\Nuage(output)
set dirEngine=C:\Users\samue\École Secondaire Duval\Site Établissements scolaires - Partage de fichier\Engine
set folderName=
set folderA=
set folderB=

:: Programme principal
:main
call :folderNamePrompt
cd "%dirInput%"
for /d %%a in (*) do (
    set folderA=%%a
    echo !folderA!
    call :folderLookUpLoop
    echo _______________
    echo.
)

echo Copie des bulletins terminee. Appuyez sur une touche pour quitter...
pause >nul

Exit /b %errorlevel%

:: Functions
::_______________________________________________________________________________________________

:: Cette fonction cherche pour chaque sous-dossier (folderA) dans dirInput un sous-dossier avec le meme nom dans dirNuage (folderB)
:: Si un sous-dossier avec le meme nom est trouve, la fonction appelle copyBulletins qui copie les bulletins du sous-dossier de dirInput (%%a) vers 
:: le sous-dossier de dirNuage (%%b) dans le sous-dossier de session (folderName).
:: Si un sous-dossier avec le meme nom n'est pas trouve, la fonction affiche un message d'erreur.
:folderLookUpLoop
cd "%dirNuage%"
for /d %%b in (*) do (
    set folderB=%%b
    set folderB=!folderB:~0,6!
    if !folderB!==!folderA! (echo Dossier trouve. & call :copyBulletins "%%a" "%%b" & goto :break)
)
echo Dossier non trouve.
:break
goto :eof

:: Cette fonction copie les bulletins du sous-dossier de dirInput (%%a) vers le sous-dossier de dirNuage (%%b) dans le 
:: sous-dossier de session (folderName) s'il existe.
:: Si le sous-dossier de session n'existe pas, la fonction affiche un message d'erreur.
:copyBulletins
set dirEcoleDest=%~2
set dirEcoleSource=%~1
set dirOutput=%dirNuage%\%dirEcoleDest%\%folderName%
cd "%dirEcoleDest%"
if not exist "%folderName%" (echo Le dossier de session n'existe pas. & goto :eof)
if exist "%folderName%" (echo Copie des bulletins en cours... & powershell.exe -Command "Copy-Item '%dirInput%\%dirEcoleSource%\*' '%dirOutput%'" & goto :eof)


:: Cette fonction demande a l'utilisateur d'entrer le nom d'un sous-dossier
:: Elle appelle la fonction confirmationfct pour confirmer le choix de l'utilisateur
:: Si l'utilisateur ne confirme pas son choix, la fonction se rappelle
:: Si l'utilisateur confirme son choix, la fonction se termine
:folderNamePrompt
set /p "folderName=Entrez le nom du dossier de session dans lequel déposer les bulletin (ex.Ete2022): "
call :confirmationfct %folderName%, approve
if %approve%==0 (echo Vous avez repondu "Non" & goto :folderNamePrompt)
if %approve%==1 (echo Vous avec repondu "Oui". Appuyez sur une touche pour continuer...)
pause >nul
goto :eof

:: Cette fonction demande a l'utilisateur de confirmer son choix
:: Elle retourne true si l'utilisateur entre "O" et false si l'utilisateur entre "N"
:confirmationfct
echo.
set passedValue1=%~1
echo La valeur entree est : %passedValue1%
echo Voulez vous continuer? 1:Oui 2:Non
set /p "ouiNon= "
if %ouiNon%==1 (set %~2=1 & goto :break2)
if %ouiNon%==2 (set %~2=0 & goto :break2) 
else echo Veuillez repondre par "O" ou "N". & goto :confirmationfct
:break2
goto :eof

ENDLOCAL
