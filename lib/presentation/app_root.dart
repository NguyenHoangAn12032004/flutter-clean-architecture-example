import 'package:flutter/material.dart';
import 'package:rickmorty/domain/usecases/get_all_characters.dart';
import 'package:rickmorty/presentation/theme.dart';
import 'package:rickmorty/presentation/app.dart';

class AppRoot extends StatefulWidget {
  final GetAllCharacters getAllCharacters;
  const AppRoot({super.key, required this.getAllCharacters});

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  var themeMode = ThemeMode.dark;

  @override
  Widget build(BuildContext context) {
    const theme = CustomTheme();

    return MaterialApp(
      themeMode: themeMode,
      theme: theme.toThemeData(),
      darkTheme: theme.toThemeDataDark(),
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) {
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              title: const Text(
                'Rick & Morty (Bloc)',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    final useLight = themeMode == ThemeMode.dark ? true : false;
                    handleBrightnessChange(useLight);
                  },
                  icon: const Icon(Icons.light_mode),
                ),
              ],
            ),
            body: AppUsingBloc(getAllCharacters: widget.getAllCharacters),
          );
        },
      ),
    );
  }

  void handleBrightnessChange(bool useLight) {
    setState(() {
      themeMode = useLight ? ThemeMode.light : ThemeMode.dark;
    });
  }
}
