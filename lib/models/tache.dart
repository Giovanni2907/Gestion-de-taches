import 'package:gestion_de_taches/models/priorite.dart';

abstract class Tache {
  final int id;
  final String titre;
  final Priorite priorite;
  final DateTime? dateLimite;
  bool estComplete;

  Tache({
    required this.id,
    required this.titre,
    required this.priorite,
    required this.dateLimite,
    this.estComplete = false,
  });

  void afficherDetails();

}