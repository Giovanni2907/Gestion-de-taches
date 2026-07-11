import 'package:gestion_de_taches/exceptions/tache_exception.dart';
import 'package:gestion_de_taches/models/tache.dart';
import 'package:gestion_de_taches/repositories/repositorie_interface.dart';
import 'package:gestion_de_taches/models/priorite.dart';

class MemoireRepositorie implements IRepository<Task>{

final List<Task> _taches = [];

  @override
  Future<Task?> getById(int id) async{
    final trouvees = _taches.where((tache) => tache.id == id);
    return trouvees.isEmpty ? null : trouvees.first;
  }

  @override
  Future<void> add(Task item) async{
    if (_taches.any((tache) => tache.id == item.id)) {
      throw JsonPersistenceException("Une tâche avec l'ID ${item.id} existe déjà.");
    }
    else{
    _taches.add(item);
  }
  }

  @override
  Future<void> delete(int id) async{
    final existe = _taches.any((tache)=> tache.id == id);
    if(!existe){
      throw TacheException(id);
    }
    _taches.removeWhere((tache) => tache.id == id);
  }

  @override
  Future<List<Task>> getTasksByPriority(Priorite priorite) async{
    final tachesFiltres = _taches.where((tache) => tache.priorite == priorite).toList();
    return List.unmodifiable(tachesFiltres);
  }

  @override
  Future<void> update(Task item) async{
    final index = _taches.indexWhere((tache) => tache.id == item.id);
    if (index == -1) {
      throw TacheException(item.id);
    }
    _taches[index] = item;
}
@override
  Future<List<Task>> getAll() async{
    return List.unmodifiable(_taches);
}
}