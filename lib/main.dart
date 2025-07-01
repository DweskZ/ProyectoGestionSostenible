import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_application_1/core/models/usuario.dart';
import 'package:flutter_application_1/shared/home_scaffold.dart';
import 'package:flutter_application_1/features/auth/login_page.dart'; // lo haremos ahora
import 'package:geolocator/geolocator.dart';
import 'package:flutter_application_1/core/models/tour.dart';
import 'package:flutter_application_1/core/models/ave.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/core/models/avistamiento.dart';

Future<void> _insertarUsuariosDemo() async {
  final box = await Hive.openBox<Usuario>('usuarios');

  bool existe(String email) =>
      box.values.any((u) => u.email.toLowerCase() == email.toLowerCase());

  if (!existe('usuario@gmail.com')) {
    await box.put('turista_demo', Usuario(
      id: 'u1',
      nombre: 'Usuario',
      apellido: 'Visitante',
      email: 'usuario@gmail.com',
      telefono: '0999991111',
      password: '1234',
      rol: 'turista',
      cedula: '1234567890',
    ));
  }

  if (!existe('guia@gmail.com')) {
    await box.put('guia_demo', Usuario(
      id: 'g1',
      nombre: 'Guía',
      apellido: 'Ejemplo',
      email: 'guia@gmail.com',
      telefono: '0988882222',
      password: '1234',
      rol: 'guia',
      cedula: '9876543210',
      experiencia: '3 años en turismo ecológico',
      especialidades: ['Aves', 'Flora'],
      bio: 'Apasionado por la conservación de Manabí',
    ));
  }
}

Future<void> cargarAvesDemo() async {
  final box = await Hive.openBox<Ave>('aves');
  await box.clear();
  if (box.isEmpty) {
    final data = await rootBundle.loadString('assets/aves_catalogo.json');
    final List json = jsonDecode(data);
    for (var item in json) {
      final ave = Ave(
        familia: item['familia'],
        nombreIngles: item['nombreIngles'],
        nombreCientifico: item['nombreCientifico'],
        nombreEspanol: item['nombreEspanol'],
        nombreComun: item['nombreComun'],
        imagenUrl: item['imagenUrl'],
        sonidoUrl: item['sonidoUrl'],
        colorPredominante: item['colorPredominante'],
        formaPico: item['formaPico'],
        tamano: item['tamano'],
        habitat: item['habitat'],
        comportamiento: item['comportamiento'],
      );
      await box.add(ave);
    }
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UsuarioAdapter());
  Hive.registerAdapter(TourAdapter());
  Hive.registerAdapter(AveAdapter());
  Hive.registerAdapter(AvistamientoAdapter());
  await _insertarUsuariosDemo();
  await cargarAvesDemo();
  await Geolocator.requestPermission();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

Future<Widget> _verificarSesion() async {
  final box = await Hive.openBox<Usuario>('auth');
  final usuario = box.get('usuario');

  if (usuario != null) {
    if (usuario.rol == 'guia') {
      return const HomeScaffold();
    } else {
      return const HomeScaffold();
    }
  } else {
    return const LoginPage();
  }
}


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Corredor Ecológico',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: FutureBuilder(
        future: _verificarSesion(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          return snapshot.data!;
        },
      ),
    );
  }
}
