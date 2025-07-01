import 'package:flutter/material.dart';
import '../features/pages/inicio_page.dart';
import '../features/tours/tours_page.dart';
import '../features/aves/aves_page.dart';
import '../features/aves/catalogo_page.dart';
import '../features/pages/configuracion_page.dart';

class HomeScaffold extends StatefulWidget {
  const HomeScaffold({super.key});

  @override
  State<HomeScaffold> createState() => _HomeScaffoldState();
}

class _HomeScaffoldState extends State<HomeScaffold> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    InicioPage(),
    ToursPage(),
    AvesPage(),
    CatalogoPage(),
    ConfiguracionPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _pages[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Tours'),
          BottomNavigationBarItem(icon: Icon(Icons.visibility), label: 'Aves'),
          BottomNavigationBarItem(icon: Icon(Icons.library_books), label: 'Catálogo'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Configuración'),
        ],
      ),
    );
  }
}
