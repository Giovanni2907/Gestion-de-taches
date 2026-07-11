# Gestion de Tâches (CLI)

Une application en ligne de commande (CLI) robuste développée en **Dart**, permettant de gérer des tâches quotidiennes. Ce projet met en pratique les concepts avancés de Programmation Orientée Objet (POO), l'implémentation d'interfaces, le typage générique (Repository Pattern), la gestion des exceptions personnalisées, la persistance des données au format JSON, et la validation par tests unitaires automatisés.

---

## Fonctionnalités

* **Gestion complète des tâches** : Ajout, listage, mise à jour (marquer comme complétée) et suppression de tâches.
* **Architecture Orientée Objet** : Utilisation de classes abstraites (`Task`) et d'héritage pour distinguer les tâches standards (`StandardTask` en priorité `low` ou `medium`) des tâches urgentes (`UrgentTask` forcée en priorité `high`).
* **Repository Pattern & Génériques** : Abstraction totale de la source de données via une interface générique `IRepository<T>`.
* **Persistance locale** : Sauvegarde et lecture asynchrones automatiques dans un fichier local `taches.json`.
* **Gestion des erreurs robuste** : Utilisation d'exceptions spécifiques (ex: `TacheException`, `JsonPersistenceException`) étendant toutes la classe native `Exception` de Dart, couplée à une validation des entrées utilisateur (`null safety`).

---

## Structure du Projet

Le projet suit une architecture en couches (*layer-first architecture*) structurée comme suit :
* `bin/` : Point d'entrée de l'application (exécution des commandes).
* `lib/models/` : Classes de données (`Tache`, `TacheStandard`, `TacheUrgente`) et enums (`Priorite`).
* `lib/repositories/` : Contrats d'interfaces génériques (`IRepository`) et implémentations (`JsonTaskRepository`, `MemoireRepository`).
* `lib/exceptions/` : Exceptions personnalisées.
* `test/` : Suite de tests unitaires pour valider la logique métier et le filtrage.

---

## Prérequis

Assurez-vous d'avoir installé le SDK Dart sur votre machine.
Pour vérifier votre installation, ouvrez votre terminal et exécutez :
```bash
dart --version

---
## Installation et Configuration

1. **Cloner ou ouvrir le projet** dans votre éditeur (ex: VS Code).
2. **Récupérer les dépendances** nécessaires (notamment le package de test) en exécutant la commande suivante dans votre terminal :
   ```bash
   dart pub get
   ```

---

## Lancement des tests
  - Le test s'effectue avec la commande suivante tapé dans le terminal de l'IDE
    ```bash
    dart test
    ```
---

## Lancement de l'app
  - L'app se met en marche avec la commande dart run encore une fois tapé dans le terminal de l'IDE
```bash
    dart run 
``` 

---