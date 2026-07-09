import 'package:gestion_de_taches/exceptions/tache_exception.dart';
import 'package:gestion_de_taches/models/tache.dart';
import 'package:gestion_de_taches/repositories/repositorie_Interface.dart';

class MemoireRepositorie implements RepositoryInterface<Tache>{

final List<Tache> _taches = [];

  @override
  Future<Tache?> getById(int id) async{
    if (_taches.isEmpty) {
      return null;
    }
    else{
    final resultat = _taches.where((tache) => tache.id == id);
  }
  }

  @override
  Future<void> add(Tache item) async{
    if (_taches.any((tache) => tache.id == item.id)) {
      throw Exception('Une tâche avec cet ID existe déjà.');
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
  Future<List<Tache>> getAll() async{
    return List.unmodifiable(_taches);
  }
}