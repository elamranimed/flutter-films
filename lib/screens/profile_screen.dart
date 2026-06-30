import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 120.0,
                height: 120.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.deepPurple.withOpacity(0.3),
                ),
                child: const Icon(
                  Icons.person,
                  size: 80.0,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 20.0),
              const Text(
                'Cinéphile',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              const Text(
                'Amoureux des films',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 40.0),
              const Divider(),
              const SizedBox(height: 20.0),
              const Text(
                'À propos de cette application',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                'Films App v1.0.0\n\n'
                'Une application Flutter pour découvrir et gérer vos films préférés.\n\n'
                'Démonstration des concepts de navigation Flutter:\n'
                '• Navigation par push/pop\n'
                '• BottomNavigationBar\n'
                '• Passage de paramètres\n'
                '• PageRouteBuilder pour les transitions',
                style: TextStyle(
                  fontSize: 14.0,
                  height: 1.6,
                  color: Colors.grey[700],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40.0),
              ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Paramètres à venir...'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                icon: const Icon(Icons.settings),
                label: const Text('Paramètres'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 20.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
