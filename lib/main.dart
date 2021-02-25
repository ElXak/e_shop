import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:theme_provider/theme_provider.dart';

import 'dark_them.dart';
import 'data/models/auth.dart';
import 'ui/home/home_screen.dart';
import 'ui/splash/splash_screen.dart';
import 'routes.dart';
import 'orange_theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthModel _auth = AuthModel();

  @override
  void initState() {
    try {
      _auth.loadSettings();
    } catch (e) {
      print('Error Loading Settings: $e');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthModel>.value(value: _auth),
      ],
      child: ThemeProvider(
        saveThemesOnChange: true,
        loadThemeOnInit: false,
        onInitCallback: (controller, previouslySavedThemeFuture) async {
          String savedTheme = await previouslySavedThemeFuture;
          if (savedTheme != null) {
            controller.setTheme(savedTheme);
          } else {
            Brightness platformBrightness =
                SchedulerBinding.instance.window.platformBrightness;
            if (platformBrightness == Brightness.dark) {
              controller.setTheme('dark');
            } else {
              // controller.setTheme('light');
              controller.setTheme('orange');
            }
            controller.forgetSavedTheme();
          }
        },
        themes: [
          AppTheme.light(id: 'light'),
          AppTheme(
            id: 'dark',
            description: 'Dark Theme',
            data: darkTheme(),
          ),
          AppTheme(
              id: 'orange',
              description: 'Rounded Orange Theme',
              data: orangeTheme()),
        ],
        child: ThemeConsumer(
          child: Builder(
            builder: (themeContext) => MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Lamode.TJ',
              theme: ThemeProvider.themeOf(themeContext).data,
              home: Consumer<AuthModel>(builder: (context, model, child) {
                if (model?.user != null) return HomeScreen();
                return SplashScreen();
              }),
              routes: routes,
            ),
          ),
        ),
      ),
    );
  }
}
