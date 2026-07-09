import 'package:gestion_de_taches/models/priorite.dart';
import 'package:gestion_de_taches/models/tache.dart';

class TacheStandard extends Tache{
  TacheStandard({
    required int id,
    required String titre,
    required Priorite priorite,
    DateTime? dateLimite,
    bool estComplete = false,
  }) : assert(priorite != Priorite.high, 'La priorité d\'une tâche standard ne peut pas être haute.'), 
  super(
          id: id,
          titre: titre,
          priorite: priorite,
          dateLimite: dateLimite,
          estComplete: estComplete,
        );
  @override
  void afficherDetails() {
    print(" [STANDARD] $titre (Date limite : $dateLimite) - Terminé : $estComplete");
  }
}