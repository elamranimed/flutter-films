import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/favorites_provider.dart';
import 'providers/theme_provider.dart';
import 'screens/home_screen.dart';
import 'screens/favorites_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/transition_demo.dart';
import 'screens/navigation_examples.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Films App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorSchemeSeed: Colors.deepPurple,
            useMaterial3: true,
            brightness: Brightness.light,
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
              elevation: 2.0,
            ),
          ),
          darkTheme: ThemeData(
            colorSchemeSeed: Colors.deepPurple,
            useMaterial3: true,
            brightness: Brightness.dark,
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.deepPurple.shade700,
              foregroundColor: Colors.white,
              elevation: 2.0,
            ),
          ),
          themeMode: themeProvider.themeMode,
          home: const MainScreen(),
          // Route nommées (exemple de navigation nommée)
          routes: {
            '/home': (context) => const MainScreen(),
            '/named-demo': (context) => const NamedRouteDemoPage(),
          },
        );
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    FavoritesScreen(),
    NavigationExamplesScreen(),
    TransitionDemoScreen(),
    ProfileScreen(),
  ];

  void _onNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onNavItemTapped,
        backgroundColor: Colors.deepPurple,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            label: 'Films',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoris',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.navigation),
            label: 'Navigation',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.animation),
            label: 'Transitions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}

/// Page for the named route demo (/named-demo).
class NamedRouteDemoPage extends StatelessWidget {
  const NamedRouteDemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Route nommée'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              size: 80.0,
              color: Colors.green.withValues(alpha: 0.7),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Navigation par route nommée réussie!',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10.0),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              child: Text(
                'Cette page a été ouverte avec:\nNavigator.pushNamed(context, \'/named-demo\')',
                style: TextStyle(fontSize: 14.0, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
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
