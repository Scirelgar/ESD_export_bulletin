@echo off

chcp 1252>nul

goto :Commentaire
Ce script renvoi l'utilisateur à la documentation en ligne du programme.

Auteur: Samuel Richard
Date: 2023-05-03
:Commentaire

SETLOCAL EnableExtensions ENABLEDELAYEDEXPANSION

:: Variables

:: Programme principal
:main
echo.

start "" https://github.com/Scirelgar/ESD_export_bulletin#programme-dexport-des-bulletins

timeout /t 5 >nul

Exit /b %errorlevel%

:: Functions
::_______________________________________________________________________________________________

ENDLOCAL