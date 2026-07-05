import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres'),
      ),
      body: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              const Text(
                'Apparence',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: RadioGroup<ThemeMode>(
                  groupValue: themeProvider.themeMode,
                  onChanged: (mode) {
                    if (mode != null) {
                      themeProvider.setThemeMode(mode);
                    }
                  },
                  child: Column(
                    children: [
                      RadioListTile<ThemeMode>(
                        title: const Text('Système'),
                        subtitle: const Text(
                            'Suivre les paramètres du système'),
                        secondary: const Icon(Icons.settings_suggest),
                        value: ThemeMode.system,
                      ),
                      const Divider(height: 1),
                      RadioListTile<ThemeMode>(
                        title: const Text('Clair'),
                        subtitle: const Text('Thème clair'),
                        secondary: const Icon(Icons.light_mode),
                        value: ThemeMode.light,
                      ),
                      const Divider(height: 1),
                      RadioListTile<ThemeMode>(
                        title: const Text('Sombre'),
                        subtitle: const Text('Thème sombre'),
                        secondary: const Icon(Icons.dark_mode),
                        value: ThemeMode.dark,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32.0),
              const Text(
                'À propos',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: const ListTile(
                  leading: Icon(Icons.info_outline),
                  title: Text('Films App'),
                  subtitle: Text('Version 1.0.0'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
