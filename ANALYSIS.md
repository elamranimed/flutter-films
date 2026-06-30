# Analyse des exemples du cours - Navigation Flutter

## 7 Exemples de Navigation Flutter

### ✅ Exemple 1: Navigator.push() - Navigation basique
**Fichier**: `lib/screens/home_screen.dart`

Démontre la navigation simple vers un écran de détails:
```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => FilmDetailsScreen(film: film),
  ),
);
```

**Utilisation**: Clic sur un film dans la liste d'accueil → Affiche les détails

---

### ✅ Exemple 2: Navigator.pop() - Retour arrière
**Fichier**: `lib/screens/film_details.dart`

Retour à l'écran précédent:
```dart
Navigator.pop(context);
```

**Utilisation**: Bouton "Retour" automatique dans AppBar

---

### ✅ Exemple 3: Routes nommées avec MaterialApp.routes
**Fichier**: `lib/main.dart`

Définition centralisée des routes:
```dart
routes: {
  '/home': (context) => const MainScreen(),
},
```

**Référence**: Pour futures extensions avec plus de routes nommées

---

### ✅ Exemple 4: Passage de paramètres
**Fichier**: `lib/screens/navigation_examples.dart` - `ParameterPassingPage`

Transmission de données lors de la navigation:
```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const ParameterPassingPage(
      title: 'Film très populaire',
      rating: 9.2,
    ),
  ),
);
```

**Utilisation**: La page reçoit et affiche les paramètres

---

### ✅ Exemple 5: pushReplacementNamed()
**Fichier**: `lib/screens/navigation_examples.dart`

Remplace la page actuelle dans la pile:
```dart
Navigator.pushReplacementNamed(context, '/newRoute');
```

**Utilisation**: Après login pour empêcher le retour vers l'écran de connexion

---

### ✅ Exemple 6: popUntil() - Navigation sélective
**Fichier**: `lib/screens/navigation_examples.dart`

Nettoie la pile jusqu'à une condition:
```dart
Navigator.popUntil(context, (route) => route.isFirst);
```

**Utilisation**: Revenir à l'écran d'accueil en supprimant plusieurs écrans

---

### ✅ Exemple 7: PageRouteBuilder - Transitions personnalisées
**Fichier**: `lib/screens/transition_demo.dart`

Trois animations personnalisées:

#### 7a. Transition Slide (glissement)
```dart
PageRouteBuilder(
  pageBuilder: (context, animation, secondaryAnimation) => child,
  transitionsBuilder: (context, animation, secondaryAnimation, child) {
    const begin = Offset(0.0, 1.0);
    const end = Offset.zero;
    final tween = Tween(begin: begin, end: end);
    final offsetAnimation = animation.drive(tween);
    return SlideTransition(position: offsetAnimation, child: child);
  },
);
```

#### 7b. Transition Fade (fondu)
```dart
FadeTransition(opacity: animation, child: child);
```

#### 7c. Transition Scale (zoom)
```dart
ScaleTransition(scale: animation, child: child);
```

---

## 🎯 Navigation avec BottomNavigationBar (Exemple bonus)

**Fichier**: `lib/main.dart` - `MainScreen`

5 écrans accessibles par onglets:
```dart
BottomNavigationBar(
  type: BottomNavigationBarType.fixed,
  currentIndex: _selectedIndex,
  onTap: _onNavItemTapped,
  items: const [
    BottomNavigationBarItem(icon: Icon(Icons.movie), label: 'Films'),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favoris'),
    BottomNavigationBarItem(icon: Icon(Icons.navigation), label: 'Navigation'),
    BottomNavigationBarItem(icon: Icon(Icons.animation), label: 'Transitions'),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
  ],
);
```

**Gestion d'état**: Utilise `setState()` pour changer d'onglet

---

## 📊 Matrice de couverture

| Concept | Fichier | Statut | Type |
|---------|---------|--------|------|
| Navigator.push() | home_screen.dart | ✅ | Implémenté |
| Navigator.pop() | film_details.dart | ✅ | Implémenté |
| Routes nommées | main.dart | ✅ | Déclaré |
| Paramètres | navigation_examples.dart | ✅ | Implémenté |
| pushReplacementNamed() | navigation_examples.dart | ✅ | Documenté |
| popUntil() | navigation_examples.dart | ✅ | Documenté |
| PageRouteBuilder | transition_demo.dart | ✅ | Implémenté |
| Transitions (Slide) | transition_demo.dart | ✅ | Implémenté |
| Transitions (Fade) | transition_demo.dart | ✅ | Implémenté |
| Transitions (Scale) | transition_demo.dart | ✅ | Implémenté |
| BottomNavigationBar | main.dart | ✅ | Implémenté |

---

## 🎓 Exécution pratique

### Pour tester la navigation basique:
1. Lancer l'app → Onglet "Films"
2. Cliquer sur un film → Accède aux détails (Navigator.push)
3. Cliquer "Retour" ou utiliser le bouton retour → Revient (Navigator.pop)

### Pour tester les transitions:
1. Onglet "Transitions"
2. Cliquer sur un bouton (Slide, Fade, Scale)
3. Observer l'animation personnalisée

### Pour tester les autres techniques:
1. Onglet "Navigation"
2. Explorer les 6 exemples de navigation

### Pour tester BottomNavigationBar:
1. Cliquer sur chaque onglet en bas
2. Naviguer entre les 5 écrans principaux

---

## 💡 Points clés à retenir

1. **Navigator.push()** ajoute à la pile
2. **Navigator.pop()** retire de la pile
3. **Routes nommées** centralisent les définitions
4. **Paramètres** se passent via constructeur Widget
5. **PageRouteBuilder** permet les animations custom
6. **BottomNavigationBar** + `setState()` = multi-écrans
7. **popUntil()** nettoie plusieurs écrans

---

## 🔧 Extensions possibles

- Ajouter une base de données pour les favoris
- Implémenter Provider pour état global
- Ajouter plus d'exemples de transitions
- Créer des routes nommées dynamiques avec arguments
- Ajouter une barre de recherche pour filtrer les films
