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
    
    test('1. L\'ajout d\'une tache standard doit correctement persister dans le JSON', () async {
      final tache = TacheStandard(id: 1, titre: 'Acheter du lait', priorite: Priorite.low);
      
      await repo.add(tache);
      final liste = await repo.getAll();
      
      expect(liste.length, equals(1));
      expect(liste.first.titre, equals('Acheter du lait'));
      expect(liste.first.priorite, equals(Priorite.low));
    });

    test('2. L\'ajout d\'une tahce urgente doit être automatiquement configuré en priorité HIGH', () async {
      final urgent = TacheUrgente(id: 2, titre: 'Corriger bug critique', priorite: Priorite.high);
      
      await repo.add(urgent);
      final uniqueTache = await repo.getById(2);
      
      expect(uniqueTache, isNotNull);
      expect(uniqueTache!.priorite, equals(Priorite.high));
    });

    test('3. Supprimer une tâche existante doit la retirer du fichier JSON', () async {
      final tache = TacheStandard(id: 3, titre: 'Faire du sport', priorite: Priorite.medium);
      await repo.add(tache);
      
      await repo.delete(3);
      final liste = await repo.getAll();
      
      expect(liste.any((t) => t.id == 3), isFalse);
    });

    test('4. Tenter de supprimer une tâche inexistante doit lever TaskNotFoundException', () async {
      expect(
        () async => await repo.delete(999), 
        throwsA(isA<TacheException>())
      );
    });

    test('5. Filtrage par priorité',() async{
      final tache2 = TacheUrgente(id: 5, titre: 'Tâche haute priorité', priorite: Priorite.high);
      await repo.add(tache2);

      final toutesLesTaches = await repo.getAll();
      final tachesHautePriorite = toutesLesTaches.where((t) => t.priorite == Priorite.high).toList();

      expect(tachesHautePriorite.length, equals(1));
      expect(tachesHautePriorite.first.titre, equals('Tâche haute priorité'));
    }); 

  });
}