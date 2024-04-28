import 'package:albums/src/login/login_view.dart';
import 'package:albums/src/services/auth_service.dart';
import 'package:albums/src/services/hardcoded_auth_service.dart';
import 'package:albums/src/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'sample_feature/sample_item_details_view.dart';
import 'sample_feature/sample_item_list_view.dart';
import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    final userProvider = ChangeNotifierProvider(create: (_) => UserService());
    final authProvider = Provider<AuthService>(
        create: (context) => HardCodedAuthService(context.read<UserService>()));

    final materialApp = ListenableBuilder(
      listenable: settingsController,
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
        themeMode: settingsController.themeMode,
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
                  return SettingsView(controller: settingsController);
                case SampleItemDetailsView.routeName:
                  return const SampleItemDetailsView();
                case SampleItemListView.routeName:
                default:
                  return const SampleItemListView();
              }
            },
          );
        },
      ),
    );

    return MultiProvider(
      providers: [userProvider, authProvider],
      child: materialApp,
    );
  }
}
