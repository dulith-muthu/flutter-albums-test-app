import 'package:albums/src/services/api/albums_service.dart';
import 'package:albums/src/services/auth_service.dart';
import 'package:albums/src/services/hardcoded_auth_service.dart';
import 'package:albums/src/services/user_service.dart';
import 'package:albums/src/views/login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'services/settings_controller.dart';
import 'views/home/home_view.dart';
import 'views/settings/settings_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required SettingsController settingsController,
  }) : _settingsController = settingsController;

  final SettingsController _settingsController;

  @override
  Widget build(BuildContext context) {
    final userProvider = ChangeNotifierProvider(create: (_) => UserService());
    final authProvider = Provider<IAuthService>(
        create: (context) => HardCodedAuthService(context.read<UserService>()));
    final albumsProvider = Provider<AlbumsApiService>(
        create: (context) => AlbumsApiService(context.read<UserService>()));

    final materialApp = ListenableBuilder(
      listenable: _settingsController,
      builder: (context, child) => MaterialApp(
        restorationScopeId: 'app',
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''),
        ],
        onGenerateTitle: (BuildContext context) =>
            AppLocalizations.of(context)!.appTitle,
        theme: ThemeData(),
        darkTheme: ThemeData.dark(),
        themeMode: _settingsController.themeMode,
        onGenerateRoute: (RouteSettings routeSettings) {
          return MaterialPageRoute<void>(
            settings: routeSettings,
            builder: (BuildContext context) {
              final userService = context.watch<UserService>();
              if (!userService.isAuthenticated()) {
                return const LoginView();
              }
              switch (routeSettings.name) {
                case SettingsView.routeName:
                  return SettingsView(controller: _settingsController);
                case HomeView.routeName:
                default:
                  return const HomeView();
              }
            },
          );
        },
      ),
    );

    return MultiProvider(
      providers: [userProvider, authProvider, albumsProvider],
      child: materialApp,
    );
  }
}
