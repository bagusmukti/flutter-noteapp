import 'package:core_services/supabase/supabase_client.dart';
import 'package:flutter/material.dart';
import 'injector.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'note/presentation/pages/note_list_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: SupabaseConfig.url,
    anonKey: SupabaseConfig.anonKey,
  );
  setupInjector();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Practice Note App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const NoteListPage(),
    );
  }
}