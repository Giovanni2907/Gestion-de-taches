import 'package:gestion_de_taches/models/priorite.dart';
abstract class IRepository<T> {
  Future<List<T>> getTasksByPriority(Priorite priorite);
  Future<T?> getById(int id);
  Future<void> add(T item);
  Future<void> delete(int id);
  Future<void> update(T item);
  Future<List<T>> getAll();
}