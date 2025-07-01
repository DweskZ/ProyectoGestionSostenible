import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/models/tour.dart';
import 'package:flutter_application_1/core/models/usuario.dart';
import 'package:flutter_application_1/core/services/auth_service.dart';
import 'package:hive/hive.dart';

class DetalleTourPage extends StatefulWidget {
  final Tour tour;

  const DetalleTourPage({super.key, required this.tour});

  @override
  State<DetalleTourPage> createState() => _DetalleTourPageState();
}

class _DetalleTourPageState extends State<DetalleTourPage> {
  Usuario? _usuarioActual;
  bool _yaUnido = false;

  @override
  void initState() {
    super.initState();
    _cargarUsuario();
  }

  Future<void> _cargarUsuario() async {
    final u = await AuthService.usuarioActual();
    final ya = widget.tour.participantesIds.contains(u?.id);
    setState(() {
      _usuarioActual = u;
      _yaUnido = ya;
    });
  }

  Future<void> _unirseAlTour() async {
    if (_usuarioActual == null) return;

    final box = await Hive.openBox<Tour>('tours');
    final tour = box.get(widget.tour.id);

    if (tour != null && !tour.participantesIds.contains(_usuarioActual!.id)) {
      tour.participantesIds.add(_usuarioActual!.id);
      await tour.save();
      setState(() => _yaUnido = true);

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Te has unido al tour correctamente.'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = widget.tour;

    return Scaffold(
      appBar: AppBar(title: Text(t.nombre)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(t.descripcion,
                style: const TextStyle(fontSize: 16, height: 1.4)),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 18),
                const SizedBox(width: 8),
                Text('${t.fecha.toLocal().toIso8601String().split('T').first}'),
              ],
            ),
            const SizedBox(height: 12),
            if (t.direccion != null)
              Row(
                children: [
                  const Icon(Icons.location_on, size: 18),
                  const SizedBox(width: 8),
                  Expanded(child: Text(t.direccion!)),
                ],
              ),
            const SizedBox(height: 12),
            if (t.whatsappGrupoUrl != null)
              Row(
                children: [
                  const Icon(Icons.chat, size: 18),
                  const SizedBox(width: 8),
                  Expanded(child: Text(t.whatsappGrupoUrl!)),
                ],
              ),
            const Spacer(),
            if (_usuarioActual?.rol == 'turista')
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _yaUnido ? null : _unirseAlTour,
                  child: Text(_yaUnido ? 'Ya estás unido' : 'Unirme al tour'),
                ),
              )
          ],
        ),
      ),
    );
  }
}
