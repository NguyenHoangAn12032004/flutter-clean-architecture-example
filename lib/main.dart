import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:rickmorty/data/datasources/local/local_storage.dart';
import 'package:rickmorty/data/datasources/network/api.dart';
import 'package:rickmorty/data/repositories_impl/character_repository_impl.dart';
import 'package:rickmorty/domain/usecases/get_all_characters.dart';
import 'package:rickmorty/presentation/app_root.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // 1. Initialize dependencies
  final sharedPref = await SharedPreferences.getInstance();
  final localStorage = LocalStorageImpl(sharedPreferences: sharedPref);
  final api = ApiImpl();
  
  // 2. Initialize Repository
  final characterRepository = CharacterRepositoryImpl(
    api: api,
    localStorage: localStorage,
  );
  
  // 3. Initialize Use Cases
  final getAllCharacters = GetAllCharacters(repository: characterRepository);

  // 4. Config
  Animate.restartOnHotReload = true;

  // 5. Run App
  runApp(AppRoot(getAllCharacters: getAllCharacters));
}
