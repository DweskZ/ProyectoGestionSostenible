import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/models/tour.dart';
import 'package:flutter_application_1/core/models/usuario.dart';
import 'package:flutter_application_1/core/services/auth_service.dart';
import 'package:hive/hive.dart';

class ParticipantesPage extends StatefulWidget {
  const ParticipantesPage({super.key});

  @override
  State<ParticipantesPage> createState() => _ParticipantesPageState();
}

class _ParticipantesPageState extends State<ParticipantesPage> {
  Usuario? _guia;
  List<Tour> _toursDelGuia = [];

  @override
  void initState() {
    super.initState();
    _cargar();
  }

  Future<void> _cargar() async {
    final usuario = await AuthService.usuarioActual();
    final box = await Hive.openBox<Tour>('tours');
    final todos = box.values.toList();

    setState(() {
      _guia = usuario;
      _toursDelGuia = todos.where((t) => t.guiaId == usuario?.id).toList();
    });
  }

  void _verParticipantes(Tour tour) async {
    final boxUsuarios = await Hive.openBox<Usuario>('usuarios');
    final participantes = boxUsuarios.values
        .where((u) => tour.participantesIds.contains(u.id))
        .toList();

    showModalBottomSheet(
      context: context,
      builder: (_) => ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Participantes de "${tour.nombre}"',
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          if (participantes.isEmpty)
            const Text('Aún no hay participantes.')
          else
            ...participantes.map((u) => ListTile(
                  leading: const Icon(Icons.person),
                  title: Text('${u.nombre} ${u.apellido}'),
                  subtitle: Text(u.email),
                )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mis tours y participantes')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: _toursDelGuia.isEmpty
            ? [const Text('No has creado tours aún.')]
            : _toursDelGuia.map((tour) {
                return Card(
                  child: ListTile(
                    title: Text(tour.nombre),
                    subtitle: Text('📅 ${tour.fecha.toLocal().toIso8601String().split('T').first}'),
                    trailing: const Icon(Icons.group),
                    onTap: () => _verParticipantes(tour),
                  ),
                );
              }).toList(),
      ),
    );
  }
}
