@echo off

chcp 1252>nul

goto :Commentaire
Ce script imprime un menu pour l'utilisateur et appelle les scripts correspondants aux choix de l'utilisateur.

Auteur: Samuel Richard
Date: 2023-05-03
Version: 1.0
:Commentaire

SETLOCAL EnableExtensions ENABLEDELAYEDEXPANSION

:: Variables
set dirEngine=C:\Users\samue\�cole Secondaire Duval\Site �tablissements scolaires - Partage de fichier\Engine

:: Programme principal
:main
cd "%dirEngine%"
echo.
echo Menu
echo 1. Creer des sous dossiers
echo 2. Effacer des sous dossiers
echo 3. Copier des bulletins
echo 4. Aide
echo 0. Quitter
echo.
set /p choice=Choisissez une option:
echo.
if %choice%==1 (call CreateFolder.bat & goto :main)
if %choice%==2 (call DeleteFolder.bat & goto :main)
if %choice%==3 (call CopyBulletins.bat & goto :main)
if %choice%==4 (call Help.bat & goto :main)
if %choice%==0 goto :eof
echo Choix invalide. Appuyez sur une touche pour recommencer...
pause >nul
goto :main

Exit /b %errorlevel%

ENDLOCAL