import 'dart:convert';
import 'dart:io';
import '../models/tache.dart';
import '../models/tache_standard.dart';
import '../models/tache_urgente.dart';
import '../models/priorite.dart';
import '../exceptions/tache_exception.dart';
import 'repositorie_interface.dart';

class JsonTaskRepository implements RepositoryInterface<Tache> {
  final String filePath;

  JsonTaskRepository({this.filePath = 'taches.json'});

  // --- Fonction utilitaire pour lire le fichier ---
  Future<List<Tache>> _loadFromFile() async {
    try {
      final file = File(filePath);
      if (!await file.exists()) {
        return []; // Si le fichier n'existe pas encore, on part d'une liste vide
      }

      final jsonString = await file.readAsString();
      if (jsonString.trim().isEmpty) return [];

      final List<dynamic> jsonList = jsonDecode(jsonString);

      // C'est ici qu'on utilise .map() ! On transforme chaque Map JSON en vrai objet Tache
      return jsonList.map((json) {
        final priorite = Priorite.values.byName(json['priorite']);
        final id = json['id'] as int;
        final titre = json['titre'] as String;
        final estComplete = json['estComplete'] as bool;
        final dateLimiteRaw = json['dateLimite'];
        final DateTime? dateLimite = dateLimiteRaw != null ? DateTime.parse(dateLimiteRaw as String) : null;

        if (priorite == Priorite.high) {
          final tache = TacheUrgente(id: id, titre: titre, priorite: priorite, dateLimite: dateLimite);
          tache.estComplete = estComplete;
          return tache;
        } else {
          final tache = TacheStandard(id: id, titre: titre, priorite: priorite, dateLimite: dateLimite);
          tache.estComplete = estComplete;
          return tache;
        }
      }).toList();
    } catch (e) {
      throw JsonPersistenceException("Impossible de lire le fichier JSON : $e");
    }
  }

  // --- Fonction utilitaire pour sauvegarder dans le fichier ---
  Future<void> _saveToFile(List<Tache> taches) async {
    try {
      final file = File(filePath);
      
      // On transforme nos objets Tache en Map (Dictionnaire) pour le JSON
      final jsonList = taches.map((tache) => {
        'id': tache.id,
        'titre': tache.titre,
        'priorite': tache.priorite.name,
        'estComplete': tache.estComplete,
        'dateLimite': tache.dateLimite?.toIso8601String(),
      }).toList();

      // On écrit le texte JSON dans le fichier
      await file.writeAsString(jsonEncode(jsonList));
    } catch (e) {
      throw JsonPersistenceException("Impossible de sauvegarder dans le fichier JSON : $e");
    }
  }

  // --- Implémentation des méthodes du contrat ---

  @override
  Future<void> add(Tache item) async {
    final taches = await _loadFromFile();
    taches.add(item);
    await _saveToFile(taches);
  }

  @override
  Future<List<Tache>> getAll() async {
    return await _loadFromFile();
  }

  @override
  Future<Tache?> getById(int id) async {
    final taches = await _loadFromFile();
    final trouvees = taches.where((t) => t.id == id);
    return trouvees.isEmpty ? null : trouvees.first;
  }

  @override
  Future<void> delete(int id) async {
    final taches = await _loadFromFile();
    if (!taches.any((t) => t.id == id)) throw TacheException(id);
    taches.removeWhere((t) => t.id == id);
    await _saveToFile(taches);
  }
}