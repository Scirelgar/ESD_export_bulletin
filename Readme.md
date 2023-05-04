# Programme d'export des bulletins

## Informations
### Version: 1.0
### Auteur: Samuel Richard
### Dernière mise à jour: 2023-05-04

## Description
Ce programme permet d'exporter des fichiers à l'intérieur du site SharePoint _Établissement scolaires - Partage de fichier_ hébergé par l'École secondaire Duval en plus de géréer la création et la suppression des dossiers de session pour chaque école.

## Structure des fichiers
Les répertoires source et destination sont prédéfinis et ne peuvent être modifiés.

Chemin du répertoire source: 
```
École Secondaire Duval\Site Établissements scolaires - Partage de fichier\input
```

Chemin du répertoire destination: 
```
École Secondaire Duval\Site Établissements scolaires - Partage de fichier\Nuage(output)
```

Le répertoire source contient les dossiers exportés par _COBA - Pédagogie_ et identifiés par code d'organisme. Chaque dossier ne devrait contenir que les fichiers PDF des bulletins.

Le répertoire destination contient les dossiers de toutes les écoles identifiés par code d'organisme et nom selon la syntaxe suivante : `code d'organisme - nom de l'école`. Chaque dossier d'école contient des sous-dossiers de session dont la création et la suppression sont gérées par le programme. Chaque sous-dossier de session contient les bulletins de tous les élèves de l'école pour la session correspondante. Par exemple, le dossier `Nuage(output)\123456 - École secondaire Duval\Ete2023` contient les bulletins de tous les élèves de l'École secondaire Duval pour la session d'été 2023.

![Screenshot de la structure de dossier.](C:\Users\samue\École Secondaire Duval\Site Établissements scolaires - Partage de fichier\Engine\assets\Capture_Structure.jpg)

