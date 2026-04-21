import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:note/note.dart';
import 'note/presentation/bloc/note_bloc.dart';

final getIt = GetIt.instance;
final supabase = Supabase.instance.client;

void setupInjector() {
  // Register repository and datasource
  getIt.registerLazySingleton<NoteSupabaseDatasource>(
        () => NoteSupabaseDatasource(supabase),
  );
  getIt.registerLazySingleton<NoteRepositoryImpl>(
        () => NoteRepositoryImpl(getIt<NoteSupabaseDatasource>()),
  );
  // Register usecases
  getIt.registerLazySingleton(() =>
      GetNotes(getIt<NoteRepositoryImpl>()));
  getIt.registerLazySingleton(() =>
      CreateNote(getIt<NoteRepositoryImpl>()));
  getIt.registerLazySingleton(() =>
      UpdateNote(getIt<NoteRepositoryImpl>()));
  getIt.registerLazySingleton(() =>
      DeleteNote(getIt<NoteRepositoryImpl>()));
  // Register NoteBloc factory
  getIt.registerFactory<NoteBloc>(
        () => NoteBloc(
      getNotes: getIt<GetNotes>(),
      createNote: getIt<CreateNote>(),
      updateNote: getIt<UpdateNote>(),
      deleteNote: getIt<DeleteNote>(),
    ),
  );
}