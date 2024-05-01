import 'package:albums/src/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../services/settings_controller.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key, required SettingsController controller})
      : _controller = controller;

  static const routeName = '/settings';

  final SettingsController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings),
      ),
      body: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Row(
                children: [
                  Text(AppLocalizations.of(context)!.settingsTheme),
                  const Spacer(),
                  DropdownButton<ThemeMode>(
                    value: _controller.themeMode,
                    onChanged: _controller.updateThemeMode,
                    items: [
                      DropdownMenuItem(
                        value: ThemeMode.system,
                        child: Text(
                            AppLocalizations.of(context)!.settingsThemeSystem),
                      ),
                      DropdownMenuItem(
                        value: ThemeMode.light,
                        child: Text(
                            AppLocalizations.of(context)!.settingsThemeLight),
                      ),
                      DropdownMenuItem(
                        value: ThemeMode.dark,
                        child: Text(
                            AppLocalizations.of(context)!.settingsThemeDark),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () => _logout(context),
                  child: Text(AppLocalizations.of(context)!.logoutButton),
                ),
              ),
            ],
          )),
    );
  }

  void _logout(BuildContext context) {
    final authService = context.read<IAuthService>();
    Navigator.pop(context);
    authService.logout().then((value) => null);
  }
}
