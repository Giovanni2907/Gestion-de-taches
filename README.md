# Gestion-de-taches

Une application en ligne de commande (CLI) robuste développée en **Dart**, permettant de gérer des tâches quotidiennes. Ce projet met en pratique les concepts de Programmation Orientée Objet (POO), le typage générique, la gestion des exceptions personnalisées, la persistance de données au format JSON, et la validation par tests unitaires.

---

## Fonctionnalités

* **Ajout de tâches** : Support des tâches standards (priorités `LOW` ou `MEDIUM`) et des tâches urgentes (priorité forcée à `HIGH`).
* **Persistance locale** : Sauvegarde automatique de vos tâches dans un fichier `taches.json`.
* **Gestion des états** : Possibilité de marquer une tâche comme terminée ou de la supprimer.
* **Architecture propre** : Utilisation du *Repository Pattern* avec des contrats d'interface stricts et asynchrones (`Future`).
* **Sécurité** : Gestion globale des erreurs via des exceptions personnalisées (`TacheException`).

---

## Prérequis

Assurez-vous d'avoir installé le SDK Dart sur votre machine. 
* Pour vérifier votre installation, ouvrez votre terminal et tapez :
    ```bash
    dart --version
    ```

---

## Installation et Configuration

1. **Cloner ou ouvrir le projet** dans votre éditeur (ex: VS Code).
2. **Récupérer les dépendances** nécessaires (notamment le package de test) en exécutant la commande suivante dans votre terminal :
   ```bash
   dart pub get

## Lancement des tests
  - Le test s'effectue avec la commande dart test tapé dans le terminal de l'IDE

## Lancement de l'app
  - L'app se met en marche avec la commande dart run encore une fois tapé dans le terminal de l'IDE
