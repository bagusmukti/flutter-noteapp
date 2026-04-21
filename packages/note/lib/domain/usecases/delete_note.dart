import '../repositories/note_repository.dart';
import '../entities/note.dart';

class DeleteNote {
  final NoteRepository repository;
  DeleteNote(this.repository);

  Future<void> call(String id) {
    return repository.deleteNote(id);
  }
}