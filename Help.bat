@echo off

chcp 1252>nul

goto :Commentaire
Ce script imprime la documentation du programme.

Auteur: Samuel Richard
Date: 2023-05-03
Version: 0.1
:Commentaire

SETLOCAL EnableExtensions ENABLEDELAYEDEXPANSION

:: Variables

:: Programme principal
:main
echo.

pause

Exit /b %errorlevel%

:: Functions
::_______________________________________________________________________________________________

ENDLOCAL