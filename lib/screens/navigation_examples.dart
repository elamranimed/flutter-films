import 'package:flutter/material.dart';

class NavigationExamplesScreen extends StatefulWidget {
  const NavigationExamplesScreen({Key? key}) : super(key: key);

  @override
  State<NavigationExamplesScreen> createState() =>
      _NavigationExamplesScreenState();
}

class _NavigationExamplesScreenState extends State<NavigationExamplesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exemples de navigation'),
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

              // 1. Navigator.push()
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

              // 2. pushReplacement() — fully working demo
              _buildExampleCard(
                title: 'pushReplacement()',
                description:
                    'Remplace la page actuelle par une nouvelle dans la pile',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FakeLoginPage(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 15.0),

              // 3. pushNamed() — fully working demo
              _buildExampleCard(
                title: 'Navigator.pushNamed()',
                description:
                    'Navigation par route nommée vers /named-demo',
                onTap: () {
                  Navigator.pushNamed(context, '/named-demo');
                },
              ),
              const SizedBox(height: 15.0),

              // 4. Passage de paramètres
              _buildExampleCard(
                title: 'Passage de paramètres',
                description:
                    'Transmettre des données d\'une page à une autre',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const ParameterPassingPage(
                        title: 'Film très populaire',
                        rating: 9.2,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 15.0),

              // 5. popUntil() — fully working demo
              _buildExampleCard(
                title: 'popUntil()',
                description:
                    'Naviguez A → B → C puis revenez au début',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PopUntilPageA(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 15.0),

              // 6. Navigator.pop()
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
                            'Utilisez le bouton retour pour revenir en arrière avec Navigator.pop()',
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 15.0),

              // 7. Transitions personnalisées
              _buildExampleCard(
                title: 'Transitions personnalisées',
                description:
                    'PageRouteBuilder pour des animations personnalisées',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const TransitionExamplePage(),
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

// ======== Reusable Details Page ========

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
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.info,
              size: 80.0,
              color: Colors.deepPurple.withValues(alpha: 0.5),
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
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 30.0,
                ),
              ),
              child: const Text(
                'Retour',
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ======== Parameter Passing Page ========

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
                border: Border.all(
                    color: Colors.deepPurple, width: 2.0),
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
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 30.0,
                ),
              ),
              child: const Text(
                'Retour',
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ======== Transition Example Page ========

class TransitionExamplePage extends StatelessWidget {
  const TransitionExamplePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation personnalisée'),
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
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
              ),
              child: const Text('Retour'),
            ),
          ],
        ),
      ),
    );
  }
}

// ======== Fake Login Page (pushReplacement demo) ========

class FakeLoginPage extends StatelessWidget {
  const FakeLoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connexion (démo)'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.login,
                size: 80.0,
                color: Colors.deepPurple,
              ),
              const SizedBox(height: 20.0),
              const Text(
                'Page de connexion simulée',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10.0),
              const Text(
                'Cliquez sur "Se connecter" pour voir pushReplacement en action.\n'
                'La page de login sera remplacée par le tableau de bord.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14.0, color: Colors.grey),
              ),
              const SizedBox(height: 30.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const FakeDashboardPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    padding:
                        const EdgeInsets.symmetric(vertical: 14.0),
                  ),
                  child: const Text(
                    'Se connecter',
                    style: TextStyle(fontSize: 16.0),
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

// ======== Fake Dashboard Page (pushReplacement target) ========

class FakeDashboardPage extends StatelessWidget {
  const FakeDashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tableau de bord'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.dashboard,
                size: 80.0,
                color: Colors.green,
              ),
              const SizedBox(height: 20.0),
              const Text(
                'Bienvenue sur le tableau de bord!',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10.0),
              const Text(
                'pushReplacement a remplacé la page de login.\n'
                'Le bouton retour ne ramène PAS à la page de connexion,\n'
                'il revient directement aux exemples de navigation.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14.0, color: Colors.grey),
              ),
              const SizedBox(height: 30.0),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Retour aux exemples'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ======== popUntil Demo Pages (A → B → C) ========

class PopUntilPageA extends StatelessWidget {
  const PopUntilPageA({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page A'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.looks_one,
              size: 80.0,
              color: Colors.blue,
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Page A (1ère page)',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            const Text(
              'Naviguez vers Page B, puis Page C.\n'
              'Depuis Page C, popUntil reviendra\n'
              'directement à la page de départ.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14.0, color: Colors.grey),
            ),
            const SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PopUntilPageB(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 30.0,
                ),
              ),
              child: const Text(
                'Aller à Page B →',
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PopUntilPageB extends StatelessWidget {
  const PopUntilPageB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page B'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.looks_two,
              size: 80.0,
              color: Colors.orange,
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Page B (2ème page)',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            const Text(
              'Continuez vers Page C pour voir popUntil en action.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14.0, color: Colors.grey),
            ),
            const SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PopUntilPageC(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 30.0,
                ),
              ),
              child: const Text(
                'Aller à Page C →',
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PopUntilPageC extends StatelessWidget {
  const PopUntilPageC({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page C'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.looks_3,
              size: 80.0,
              color: Colors.red,
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Page C (3ème page)',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                'Cliquez le bouton ci-dessous pour exécuter:\n'
                'Navigator.popUntil(context, (route) => route.isFirst)\n\n'
                'Cela nettoie toute la pile et revient à la page initiale.',
                textAlign: TextAlign.center,
                style:
                    TextStyle(fontSize: 14.0, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(
                    context, (route) => route.isFirst);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 30.0,
                ),
              ),
              child: const Text(
                'popUntil() → Retour au début',
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
