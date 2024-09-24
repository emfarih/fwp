import 'package:flutter/material.dart';
import 'package:fwp/routes.dart'; // Make sure this imports your AppRoutes class

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // Default to the first tab

  void _onItemTapped(int index) {
    print('BottomNavigationBar: Tapped on index $index'); // Print tapped index
    setState(() {
      _selectedIndex = index; // Update the selected index
    });
  }

  @override
  Widget build(BuildContext context) {
    // Define the screens to show based on the selected index
    final List<Widget> _screens = [
      Navigator(
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) {
              return AppRoutes.routes[AppRoutes.systemsList]!(context);
            },
          );
        },
      ), // Default screen for Inspection
      Navigator(
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) {
              return AppRoutes
                  .routes[AppRoutes.checklistTemplatesList]!(context);
            },
          );
        },
      ), // Screen for Template
    ];

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex, // Show the selected screen
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.check),
            label: 'Inspection',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Templates',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
