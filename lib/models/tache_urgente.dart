import 'package:gestion_de_taches/models/tache.dart';
import 'package:gestion_de_taches/models/priorite.dart';

class TacheUrgente extends Tache{
  TacheUrgente({
    required int id,
    required String titre,
    required Priorite priorite,
    DateTime? dateLimite,
    bool estComplete = false,
  }) : super(
          id: id,
          titre: titre,
          priorite: Priorite.high, 
          dateLimite: dateLimite,
          estComplete: estComplete,
        );
@override
  void afficherDetails() {
    print(" [URGENT] $titre (Date limite : $dateLimite) - Terminé : $estComplete");
  }
    
}