@echo off

chcp 1252 >nul

goto :Commentaire
Ce script copie les bulletins des eleves dans le dossier de l'ecole correspondante en comparant les dossiers d'origine et de destination.

Structure de l'origine:         dirInput\code_ecole\nom,eleve_bulletin.pdf 
                            ex. dirInput\123456\Tremblay, Jean_Bulletin final  ?t ? - MAP426.pdf

Structure de la destination:    dirNuage\code_ecole - nom_ecole\classification\nom,eleve_bulletin.pdf
                            ex. dirNuage\123456 - Marie-Clarac\Ete2023\Tremblay, Jean_Bulletin final  ?t ? - MAP426.pdf

Auteur: Samuel Richard
Date: 2023-05-02
:Commentaire

:: Variables
set dirInput=%USERPROFILE%\École Secondaire Duval\Communication Interscolaire ESD - Partage de fichiers\input
set dirNuage=%USERPROFILE%\École Secondaire Duval\Communication Interscolaire ESD - Partage de fichiers\Nuage(output)
set dirEngine=%USERPROFILE%\École Secondaire Duval\Communication Interscolaire ESD - Partage de fichiers\Engine
set folderA=
set folderName=
SETLOCAL EnableExtensions ENABLEDELAYEDEXPANSION

:: Programme principal
:main
call :folderNamePrompt
cd "%dirInput%"
for /d %%a in (*) do (
    set folderA=%%a
    echo !folderA!
    echo _______________
    call :folderLookUpLoop
    )

echo Creation des dossiers terminee. Appuyez sur une touche pour quitter...
pause >nul

Exit /b %errorlevel%
 

:: Functions
::_______________________________________________________________________________________________
:: Cette fonction cherche pour chaque sous-dossier (folderA) dans dirInput un sous-dossier avec le meme nom dans dirNuage (folderB)
:: Si un sous-dossier avec le meme nom est trouve, la fonction appelle la fonction createSubFolder qui cree un sous-dossier du nom de folderName dans le sous-dossier de dirNuage
:: Si un sous-dossier avec le meme nom n'est pas trouve, la fonction affiche un message d'erreur
:folderLookUpLoop
cd "%dirNuage%"
set found="false"
for /d %%b in (*) do (
    set folderB=%%b
    set folderB=!folderB:~0,3!!folderB:~4,3!
    if !folderB!==!folderA! echo Dossier %folderName% cree. & set !found!="true" & call :createSubFolder "%%b" & goto :break
    
    )
if !found!=="false" echo Dossier non trouve. & goto :break
:break
echo.
goto :eof


:: Cette fonction concatene le nom du sous-dossier de dirNuage avec le nom du sous-dossier correspondant dans dirInput
:: Elle cree un sous-dossier dans le sous-dossier de dirNuage avec le nom de la variable folderName
:createSubFolder
set dirEcoleDest=%dirNuage%\%~1
cd "%dirEcoleDest%"
md "%folderName%"
goto :eof

:: Cette fonction demande a l'utilisateur d'entrer le nom d'un sous-dossier
:: Elle appelle la fonction confirmationfct pour confirmer le choix de l'utilisateur
:: Si l'utilisateur ne confirme pas son choix, la fonction se rappelle
:: Si l'utilisateur confirme son choix, la fonction se termine
:folderNamePrompt
set /p "folderName=Entrez le nom des nouveaux dossiers de session, sans espace (ex.Ete2022): "
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