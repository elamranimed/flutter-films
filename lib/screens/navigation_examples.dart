import 'package:flutter/material.dart';

class NavigationExamplesScreen extends StatefulWidget {
  const NavigationExamplesScreen({Key? key}) : super(key: key);

  @override
  State<NavigationExamplesScreen> createState() =>
      _NavigationExamplesScreenState();
}

class _NavigationExamplesScreenState extends State<NavigationExamplesScreen> {
  int _navigationCounter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exemples de navigation'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Exemples de techniques de navigation Flutter',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20.0),
              _buildExampleCard(
                title: 'Navigator.push()',
                description:
                    'Ajoute une nouvelle page à la pile de navigation',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DetailsPage(
                        title: 'Navigator.push()',
                        description:
                            'Cette page a été ouverte avec Navigator.push()',
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 15.0),
              _buildExampleCard(
                title: 'pushReplacementNamed()',
                description:
                    'Remplace la page actuelle par une nouvelle dans la pile',
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Remplacera la page actuelle'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
              ),
              const SizedBox(height: 15.0),
              _buildExampleCard(
                title: 'Navigator.pushNamed()',
                description: 'Navigation par route nommée sans paramètre',
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Navigation par route nommée'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
              ),
              const SizedBox(height: 15.0),
              _buildExampleCard(
                title: 'Passage de paramètres',
                description:
                    'Transmettre des données d\'une page à une autre',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ParameterPassingPage(
                        title: 'Film très populaire',
                        rating: 9.2,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 15.0),
              _buildExampleCard(
                title: 'popUntil()',
                description:
                    'Revient en arrière jusqu\'à une condition spécifique',
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Utilisé pour nettoyer la pile'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
              ),
              const SizedBox(height: 15.0),
              _buildExampleCard(
                title: 'Navigator.pop()',
                description: 'Revient à la page précédente',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DetailsPage(
                        title: 'Navigator.pop()',
                        description:
                            'Utilisez le bouton retour pour revenir en arrière',
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 15.0),
              _buildExampleCard(
                title: 'Transitions personnalisées',
                description:
                    'PageRouteBuilder pour des animations personnalisées',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TransitionExamplePage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExampleCard({
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 5.0,
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
        subtitle: Text(description),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}

class DetailsPage extends StatelessWidget {
  final String title;
  final String description;

  const DetailsPage({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.info,
              size: 80.0,
              color: Colors.deepPurple.withOpacity(0.5),
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18.0),
              ),
            ),
            const SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: const EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 30.0,
                ),
              ),
              child: const Text(
                'Retour',
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ParameterPassingPage extends StatelessWidget {
  final String title;
  final double rating;

  const ParameterPassingPage({
    Key? key,
    required this.title,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres reçus'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle,
              size: 80.0,
              color: Colors.green,
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Paramètres reçus:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20.0),
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.deepPurple, width: 2.0),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                children: [
                  Text(
                    'Titre: $title',
                    style: const TextStyle(fontSize: 18.0),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    'Note: ⭐ $rating/10',
                    style: const TextStyle(fontSize: 18.0),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: const EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 30.0,
                ),
              ),
              child: const Text(
                'Retour',
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TransitionExamplePage extends StatelessWidget {
  const TransitionExamplePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation personnalisée'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100.0,
              height: 100.0,
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const Icon(
                Icons.animation,
                color: Colors.white,
                size: 50.0,
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Transition personnalisée avec PageRouteBuilder',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
              ),
              child: const Text(
                'Retour',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
