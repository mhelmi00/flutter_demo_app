import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/theme/theme_provider.dart';
import 'package:flutter_application_1/language/language_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => LanguageProvider())
      ],
      child: Consumer<ThemeProvider>(builder: (context, theme, _) {
        final languageProvider = Provider.of<LanguageProvider>(context);
        return MaterialApp(
          locale: languageProvider.currentLocale,
          title: 'Flutter Demo',
          theme: theme.isDark
              ? ThemeData.dark()
              : ThemeData(
                  colorScheme:
                      ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                  useMaterial3: true,
                ),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'), // English
            Locale('ms'), //Malay
          ],
          home: const MyHomePage(title: 'Flutter Demo Home Page'),
        );
      }),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    var mode = Provider.of<ThemeProvider>(context);
    final languageProvider = Provider.of<LanguageProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(AppLocalizations.of(context)!.apptitle),
        actions: <Widget>[
          DropdownButton<Locale>(
            value: languageProvider.currentLocale,
            onChanged: (Locale? locale) {
              if (locale != null) {
                languageProvider.changeLanguage(locale);
              }
            },
            items: const <DropdownMenuItem<Locale>>[
              DropdownMenuItem<Locale>(
                value: Locale('en'),
                child: Text('English'),
              ),
              DropdownMenuItem<Locale>(
                value: Locale('ms'),
                child: Text('Melayu'),
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              mode.themeMode,
            ),
            Text(AppLocalizations.of(context)!.counter),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: () {
              mode.toggleThemeData();
            },
            tooltip: 'Toggle Theme',
            child: const Icon(Icons.brightness_6),
          ),
        ],
      ),
    );
  }
}
