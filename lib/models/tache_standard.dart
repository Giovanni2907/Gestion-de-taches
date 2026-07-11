import 'package:gestion_de_taches/models/priorite.dart';
import 'package:gestion_de_taches/models/tache.dart';

class StandardTask extends Task{
  StandardTask({
    required super.id,
    required super.titre,
    required super.priorite,
    super.dateLimite,
    bool estComplete = false,
  }) : assert(priorite != Priorite.high, 'La priorité d\'une tâche standard ne peut pas être haute.');

  @override
  void afficherDetails() {
    print(" [STANDARD] $titre (Date limite : $dateLimite) - Terminé : $estComplete");
  }
}