import '../repositories/documents_repository.dart';

/// Notifies listeners (e.g. History) when saved documents change.
class WatchDocumentChanges {
  final DocumentsRepository _repository;
  const WatchDocumentChanges(this._repository);

  Stream<void> call() => _repository.changes;
}
