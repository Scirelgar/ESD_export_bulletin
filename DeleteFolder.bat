@echo off

chcp 1252 >nul

goto :Commentaire
Ce script efface les sous-dossiers dans dirNuage d'un nom specifique.

Auteur: Samuel Richard
Date: 2023-05-03
Version: 1.0
:Commentaire

:: Variables
set dirNuage=%USERPROFILE%\École Secondaire Duval\Communications Interscolaire ESD - Partage de fichiers\Nuage(output)
set folderA=
set folderName=

:: Programme principal
:main

call :folderNamePrompt
echo.
call :folderLookUpLoop
echo.
echo Effacement des dossiers terminee. Appuyez sur une touche pour quitter...
pause >nul

Exit /b %errorlevel%



:: Functions
::_______________________________________________________________________________________________

:: Cette fonction entre dans chaque sous-dossier de dirNuage et efface le sous-dossier de nom folderName
:folderLookUpLoop
cd "%dirNuage%"
for /d %%a in (*) do (
    set folderA=%%a
    echo !folderA!
    call :folderDelete
    echo _______________
    )
goto :eof

:: Cette fonction efface le sous-dossier de nom folderName dans le sous-dossier de dirNuage
:folderDelete
set dirEcoleDest=%dirNuage%\%folderA%
cd "%dirEcoleDest%"
if exist "%folderName%" (rd /s /q "%folderName%" & echo Dossier "%folderName%" efface.) else echo Dossier "%folderName%" non trouve.
goto :eof

:: Cette fonction demande a l'utilisateur d'entrer le nom d'un sous-dossier
:: Elle appelle la fonction confirmationfct pour confirmer le choix de l'utilisateur
:: Si l'utilisateur ne confirme pas son choix, la fonction se rappelle
:: Si l'utilisateur confirme son choix, la fonction se termine
:folderNamePrompt
set /p "folderName=Entrez le nom des dossiers de session a supprimer, sans espace (ex.Ete2022): "
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
