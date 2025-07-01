import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/models/ave.dart';
import 'package:flutter_application_1/core/models/avistamiento.dart';
import 'package:flutter_application_1/core/services/auth_service.dart';
import 'package:flutter_application_1/core/services/avistamiento_service.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class RegistroAvistamientoPage extends StatefulWidget {
  const RegistroAvistamientoPage({super.key});

  @override
  State<RegistroAvistamientoPage> createState() => _RegistroAvistamientoPageState();
}

class _RegistroAvistamientoPageState extends State<RegistroAvistamientoPage> {
  List<Ave> aves = [];
  Ave? aveSeleccionada;
  final _cantidadController = TextEditingController();
  final _notasController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _cargarAves();
  }

  Future<void> _cargarAves() async {
    final jsonStr = await rootBundle.loadString('assets/aves_catalogo.json');
    final List<dynamic> data = jsonDecode(jsonStr);
    final List<Ave> avesCargadas = data.map((e) => Ave.fromJson(e)).toList();

    setState(() {
      aves = avesCargadas;
      aveSeleccionada = aves.first;
    });
  }

  Future<void> _guardarAvistamiento() async {
    if (aveSeleccionada == null || _cantidadController.text.isEmpty) return;

    final usuario = await AuthService.usuarioActual();
    if (usuario == null) return;

    final avistamiento = Avistamiento(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      aveId: aveSeleccionada!.nombreCientifico,
      usuarioId: usuario.id,
      fecha: DateTime.now(),
      cantidad: int.tryParse(_cantidadController.text) ?? 1,
      notas: _notasController.text,
    );

    await AvistamientoService.registrarAvistamiento(avistamiento);
    if (mounted) Navigator.pop(context);
  }

  Widget _buildGaleriaAves() {
    return SizedBox(
      height: 180,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: aves.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final ave = aves[index];
          final seleccionada = aveSeleccionada?.nombreComun == ave.nombreComun;

          return GestureDetector(
            onTap: () {
              setState(() {
                aveSeleccionada = ave;
              });
            },
            child: Container(
              width: 140,
              decoration: BoxDecoration(
                border: Border.all(
                  color: seleccionada ? Colors.green : Colors.grey.shade300,
                  width: seleccionada ? 2 : 1,
                ),
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                    child: Image.asset(
                      ave.imagenUrl,
                      height: 100,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      ave.nombreComun,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Registrar Avistamiento')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: aves.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                children: [
                  const Text('Selecciona el ave avistada:', style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 12),
                  _buildGaleriaAves(),
                  const SizedBox(height: 24),
                  TextField(
                    controller: _cantidadController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Cantidad',
                      prefixIcon: Icon(Icons.format_list_numbered),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _notasController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: 'Notas adicionales',
                      prefixIcon: Icon(Icons.note),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: _guardarAvistamiento,
                    icon: const Icon(Icons.save),
                    label: const Text('Guardar Avistamiento'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors.primary,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
