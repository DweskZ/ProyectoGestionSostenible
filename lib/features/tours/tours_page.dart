import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/models/tour.dart';
import 'package:flutter_application_1/core/models/usuario.dart';
import 'package:flutter_application_1/core/services/auth_service.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_application_1/features/tours/crear_tour_page.dart';
import 'package:flutter_application_1/features/tours/detalle_tour_page.dart';
import 'package:flutter_application_1/features/tours/participantes_page.dart';

class ToursPage extends StatefulWidget {
  const ToursPage({super.key});

  @override
  State<ToursPage> createState() => _ToursPageState();
}

class _ToursPageState extends State<ToursPage> {
  Usuario? _usuario;
  List<Tour> _misTours = [];
  List<Tour> _otrosTours = [];

  @override
  void initState() {
    super.initState();
    _cargarDatos();
  }

  Future<void> _cargarDatos() async {
    _usuario = await AuthService.usuarioActual();
    final box = await Hive.openBox<Tour>('tours');
    final all = box.values.toList();

    setState(() {
      _misTours = ( _usuario?.rol == 'guia' )
          ? all.where((t) => t.guiaId == _usuario!.id).toList()
          : [];
      _otrosTours = ( _usuario != null )
          ? all.where((t) => t.guiaId != _usuario!.id).toList()
          : all;
    });
  }

  void _crearTour() {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => const CrearTourPage()),
  ).then((refresco) {
    if (refresco == true) _cargarDatos();
  });
}


  void _verParticipantes() {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => const ParticipantesPage()),
  );
}


  @override
  Widget build(BuildContext context) {
    final esGuia = _usuario?.rol == 'guia';

    return Scaffold(
      appBar: AppBar(title: const Text('Tours')),
      body: RefreshIndicator(
        onRefresh: _cargarDatos,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            if (esGuia && _misTours.isNotEmpty)
              ...[
                const Text('Mis Tours', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                ..._misTours.map((t) => _tourCard(t, esMio: true)),
                const Divider(height: 32),
              ],
            const Text('Tours disponibles', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            if (_otrosTours.isEmpty)
              const Text('No hay tours disponibles.')
            else
              ..._otrosTours.map((t) => _tourCard(t, esMio: false)),
          ],
        ),
      ),
      floatingActionButton: esGuia ? _fabMenu() : null,
    );
  }

  Widget _tourCard(Tour t, {required bool esMio}) {
    return Card(
      child: ListTile(
        title: Text(t.nombre),
        subtitle: Text('${t.fecha.toLocal().toIso8601String().split('T').first} - Guía: ${t.guiaId}'),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetalleTourPage(tour: t),
          ),
        ).then((_) => _cargarDatos());
      },
      ),
    );
  }

  Widget _fabMenu() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton(
          heroTag: 'ver_participantes',
          mini: true,
          onPressed: _verParticipantes,
          tooltip: 'Ver participantes',
          child: const Icon(Icons.group),
        ),
        const SizedBox(height: 12),
        FloatingActionButton(
          heroTag: 'crear_tour',
          onPressed: _crearTour,
          tooltip: 'Crear nuevo tour',
          child: const Icon(Icons.add),
        ),
      ],
    );
  }
}
