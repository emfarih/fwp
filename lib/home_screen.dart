import 'package:flutter/material.dart';
import 'package:fwp/routes.dart'; // Ensure this imports your AppRoutes class

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // Default to the first tab

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index
    });
  }

  @override
  Widget build(BuildContext context) {
    // Define the screens to show based on the selected index
    final List<Widget> _screens = [
      AppRoutes.routes[AppRoutes.systemsList]!(context), // SystemsListScreen
      AppRoutes.routes[AppRoutes.checklistTemplatesList]!(
          context), // TemplatesScreen
    ];

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex, // Show the selected screen and maintain state
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
