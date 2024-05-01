import 'package:albums/src/models/login_credentials.dart';
import 'package:albums/src/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  String _loginError = '';
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.appTitle),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _loginError,
                  style: const TextStyle(color: Colors.red),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _username,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.loginUsername,
                  ),
                ),
                const SizedBox(height: 16), // Add some spacing
                TextField(
                  obscureText: true,
                  controller: _password,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.loginPassword,
                  ),
                ),
                const SizedBox(height: 24), // Add more spacing
                ElevatedButton.icon(
                  onPressed: () => _isLoading ? null : _login(context),
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16.0)),
                  icon: _isLoading
                      ? Container(
                          width: 24,
                          height: 24,
                          padding: const EdgeInsets.all(2.0),
                          child: const CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3,
                          ),
                        )
                      : const Icon(Icons.login),
                  label: Text(AppLocalizations.of(context)!.loginButton),
                ),
              ],
            ),
          ),
        ));
  }

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<bool> _updateError(Object? error, StackTrace stackTrace) async {
    setState(() {
      _loginError = error.toString();
    });
    return true;
  }

  void _login(BuildContext context) {
    if (_isLoading) return;
    final authService = context.read<IAuthService>();
    final credentials =
        LoginCredentials(username: _username.text, password: _password.text);
    setState(() {
      _isLoading = true;
      _loginError = '';
    });
    authService
        .login(credentials)
        .then((value) => value)
        .onError(_updateError)
        .whenComplete(() => setState(() {
              _isLoading = false;
            }));
  }
}
