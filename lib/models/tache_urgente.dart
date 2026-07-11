import 'package:gestion_de_taches/models/tache.dart';
import 'package:gestion_de_taches/models/priorite.dart';

class UrgentTask extends Task{
  UrgentTask({
    required super.id,
    required super.titre,
    super.dateLimite,
    bool estComplete = false,
  }) : super(priorite: Priorite.high,
        );
@override
  void afficherDetails() {
    print(" [URGENT] $titre (Date limite : $dateLimite) - Terminé : $estComplete");
  }
    
}