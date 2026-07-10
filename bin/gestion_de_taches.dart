import 'dart:io';
import 'package:gestion_de_taches/models/priorite.dart';
import 'package:gestion_de_taches/models/tache_standard.dart';
import 'package:gestion_de_taches/models/tache.dart'; 
import 'package:gestion_de_taches/models/tache_urgente.dart';
import 'package:gestion_de_taches/repositories/tache_json_repositorie.dart';
import 'package:gestion_de_taches/repositories/repositorie_interface.dart';
import 'package:gestion_de_taches/exceptions/tache_exception.dart';

void main() async {
  final IRepository<Tache> repository = JsonTaskRepository();

  print("====================================================");
  print("   BIENVENUE DANS L'APPLICATION GESTION DE TÂCHES   ");
  print("====================================================");

  while (true) {
    print("\n--- MENU PRINCIPAL ---");
    print("1. Lister toutes les tâches");
    print("2. Ajouter une tâche");
    print("3. Marquer une tâche comme terminée");
    print("4. Supprimer une tâche");
    print("5. Quitter");
    stdout.write(" Choisissez une option (1-5) : ");

    final choix = stdin.readLineSync();

    try {
      switch (choix) {
        case '1':
          print("\n --- VOS TÂCHES ---");
          final list = await repository.getAll();
          if (list.isEmpty) {
            print("Aucune tâche enregistrée pour le moment.");
          } else {
            for (var t in list) {
              t.afficherDetails();
            }
          }
          break;

        case '2':
          print("\n --- AJOUTER UNE TÂCHE ---");
          stdout.write("ID de la tâche (Nombre entier unique) : ");
          final idInput = stdin.readLineSync();
          if (idInput == null || int.tryParse(idInput) == null) {
            print(" ID invalide. L'ID doit être un nombre entier.");
            break;
          }
          final id = int.parse(idInput);

          stdout.write("Titre de la tâche : ");
          final titre = stdin.readLineSync() ?? "";
          if (titre.trim().isEmpty) {
            print("Le titre ne peut pas être vide.");
            break;
          }

          print("Niveau de priorité : 1 = LOW, 2 = MEDIUM, 3 = HIGH");
          stdout.write("Votre choix : ");
          final pChoix = stdin.readLineSync();

          Tache nouvelleTache;
          if (pChoix == '3') {
            nouvelleTache = TacheUrgente(id: id, titre: titre, priorite: Priorite.high);
          } else if (pChoix == '2') {
            nouvelleTache = TacheStandard(id: id, titre: titre, priorite: Priorite.medium);
          } else {
            nouvelleTache = TacheStandard(id: id, titre: titre, priorite: Priorite.low);
          }

          await repository.add(nouvelleTache);
          print("Tâche ajoutée avec succès dans le fichier JSON !");
          break;

        case '3':
          print("\n --- TERMINER UNE TÂCHE ---");
          stdout.write("Entrez l'ID de la tâche complétée : ");
          final idTerminer = int.parse(stdin.readLineSync()!);

          final cache = await repository.getById(idTerminer);
          if (cache == null) throw TacheException(idTerminer);
          break;

        case '4':
          print("\n --- SUPPRIMER UNE TÂCHE ---");
          stdout.write("Entrez l'ID de la tâche à supprimer : ");
          final idSuppr = int.parse(stdin.readLineSync()!);

          await repository.delete(idSuppr);
          print(" Tâche retirée du système avec succès !");
          break;

        case '5':
          print("\n Au revoir et bonne journée !");
          exit(0);

        default:
          print(" Option inconnue. Veuillez entrer un chiffre entre 1 et 5.");
      }
    } on TacheException catch (e) {
      print(e);
    } on JsonPersistenceException catch (e) {
      print(e);
    } catch (e) {
      print(" Une erreur inattendue est survenue : $e");
    }
  }
}