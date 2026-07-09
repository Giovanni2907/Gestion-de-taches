class TacheException {
  final int id;
  TacheException(this.id);

  @override
  String toString() => "🚨 Erreur : La tâche avec l'ID $id n'existe pas dans le système.";
}
class JsonPersistenceException implements Exception {
  final String message;
  JsonPersistenceException(this.message);

  @override
  String toString() => " Erreur de persistance : $message";
}