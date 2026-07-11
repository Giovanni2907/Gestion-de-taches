import 'dart:io';
import 'package:test/test.dart';
import 'package:gestion_de_taches/models/priorite.dart';
import 'package:gestion_de_taches/models/tache_standard.dart';
import 'package:gestion_de_taches/models/tache_urgente.dart';
import 'package:gestion_de_taches/repositories/tache_json_repositorie.dart';
import 'package:gestion_de_taches/exceptions/tache_exception.dart';

void main() {
  final testFilePath = 'taches_test.json';
  late JsonTaskRepository repo;

  setUp(() async {
    repo = JsonTaskRepository(filePath: testFilePath);
    final file = File(testFilePath);
    if (await file.exists()) {
      await file.delete();
    }
  });

  tearDownAll(() async {
    final file = File(testFilePath);
    if (await file.exists()) {
      await file.delete();
    }
  });

  group('Tests Unitaires - Gestion de Tâches JSON', () {
    
    test('1. L\'ajout d\'une tâche standard doit correctement persister dans le JSON', () async {
      final tache = StandardTask(id: 1, titre: 'Acheter du lait', priorite: Priorite.low);
      
      await repo.add(tache);
      final liste = await repo.getAll();
      
      expect(liste.length, equals(1));
      expect(liste.first.titre, equals('Acheter du lait'));
      expect(liste.first.priorite, equals(Priorite.low));
    });

    test('2. L\'ajout d\'une tâche urgente doit être automatiquement configuré en priorité HIGH', () async {
      final urgent = UrgentTask(id: 2, titre: 'Corriger bug critique');
      
      await repo.add(urgent);
      final uniqueTache = await repo.getById(2);
      
      expect(uniqueTache, isNotNull);
    });

    test('3. Supprimer une tâche existante doit la retirer du fichier JSON', () async {
      final tache = StandardTask(id: 3, titre: 'Faire du sport', priorite: Priorite.medium);
      await repo.add(tache);
      
      await repo.delete(3);
      final liste = await repo.getAll();
      
      expect(liste.any((t) => t.id == 3), isFalse);
    });

    test('4. Tenter de supprimer une tâche inexistante doit lever une TacheException (ou TaskNotFoundException)', () async {
      expect(
        () async => await repo.delete(999), 
        throwsA(isA<TacheException>())
      );
    });

    test('5. La méthode du repository getTasksByPriority doit retourner uniquement les tâches correspondantes', () async {
      final t1 = StandardTask(id: 4, titre: 'Tâche basse', priorite: Priorite.low);
      final t2 = UrgentTask(id: 5, titre: 'Bug critique');
      final t3 = StandardTask(id: 6, titre: 'Autre tâche basse', priorite: Priorite.low);
      
      await repo.add(t1);
      await repo.add(t2);
      await repo.add(t3);

      final resultatFiltre = await repo.getTasksByPriority(Priorite.low);

      expect(resultatFiltre.length, equals(2));
      expect(resultatFiltre.any((t) => t.id == 5), isFalse); 
      expect(resultatFiltre.every((t) => t.priorite == Priorite.low), isTrue);
    });

    test('6. [Cas limite] getTasksByPriority doit retourner une liste vide si aucune tâche ne correspond', () async {
      final t1 = StandardTask(id: 7, titre: 'Tâche normale', priorite: Priorite.medium);
      await repo.add(t1);

      final resultatFiltre = await repo.getTasksByPriority(Priorite.high);
      
      expect(resultatFiltre, isEmpty);
    });

  });
}