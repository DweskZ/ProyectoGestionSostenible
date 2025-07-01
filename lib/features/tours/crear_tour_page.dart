import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:hive/hive.dart';

import 'package:flutter_application_1/core/models/tour.dart';
import 'package:flutter_application_1/core/services/auth_service.dart';

class CrearTourPage extends StatefulWidget {
  const CrearTourPage({super.key});

  @override
  State<CrearTourPage> createState() => _CrearTourPageState();
}

class _CrearTourPageState extends State<CrearTourPage> {
  final _formKey = GlobalKey<FormState>();
  final _nombreCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _dirCtrl = TextEditingController();
  final _whatsCtrl = TextEditingController();
  DateTime? _fecha;
  LatLng? _posSeleccionada;
  late GoogleMapController _mapController;

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _descCtrl.dispose();
    _dirCtrl.dispose();
    _whatsCtrl.dispose();
    super.dispose();
  }

  Future<void> _pedirPermisoUbicacion() async {
    await Geolocator.requestPermission();
  }

  Future<void> _setPosInicial() async {
  try {
    final pos = await Geolocator.getCurrentPosition();
    _mapController.animateCamera(CameraUpdate.newLatLngZoom(
      LatLng(pos.latitude, pos.longitude),
      14,
    ));
  } catch (_) {
    _mapController.animateCamera(CameraUpdate.newLatLngZoom(
      const LatLng(-1.05, -80.45), // Default Manabí
      9,
    ));
  }
}



  Future<void> _submit() async {
    if (!_formKey.currentState!.validate() ||
        _fecha == null ||
        _posSeleccionada == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Completa todos los campos y selecciona fecha y ubicación'),
      ));
      return;
    }

    final usuario = await AuthService.usuarioActual();
    final box = await Hive.openBox<Tour>('tours');

    final nuevo = Tour(
      id: const Uuid().v4(),
      nombre: _nombreCtrl.text.trim(),
      descripcion: _descCtrl.text.trim(),
      fecha: _fecha!,
      guiaId: usuario!.id,
      participantesIds: [],
      latitud: _posSeleccionada!.latitude,
      longitud: _posSeleccionada!.longitude,
      direccion: _dirCtrl.text.trim(),
      whatsappGrupoUrl: _whatsCtrl.text.trim().isEmpty
          ? null
          : _whatsCtrl.text.trim(),
    );

    await box.put(nuevo.id, nuevo);
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    final fechaText =
        _fecha == null ? 'Elegir fecha' : DateFormat.yMMMMd().format(_fecha!);

    return Scaffold(
      appBar: AppBar(title: const Text('Crear nuevo tour')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Form(
            key: _formKey,
            child: Column(children: [
              _campo('Nombre del tour', _nombreCtrl, Icons.tour),
              _campo('Descripción', _descCtrl, Icons.description, maxLines: 3),
              const SizedBox(height: 12),
              Row(children: [
                Expanded(child: Text('Fecha: $fechaText')),
                TextButton(
                  onPressed: () async {
                    final f = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (f != null) setState(() => _fecha = f);
                  },
                  child: const Text('Seleccionar'),
                )
              ]),
              _campo('Dirección', _dirCtrl, Icons.location_on),
              _campo('WhatsApp (opcional)', _whatsCtrl, Icons.chat),
            ]),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 250,
            child: GoogleMap(
              onMapCreated: (ctrl) {
                _mapController = ctrl;
                _pedirPermisoUbicacion().then((_) => _setPosInicial());
              },
              initialCameraPosition: const CameraPosition(
                target: LatLng(-1.05, -80.45), // Coordenadas de Manabí (aprox.)
                zoom: 9,
              ),  
              myLocationEnabled: true,
              onTap: (pos) => setState(() => _posSeleccionada = pos),
              markers: _posSeleccionada != null
                  ? {
                      Marker(
                        markerId: const MarkerId('sel'),
                        position: _posSeleccionada!,
                      )
                    }
                  : {},
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _posSeleccionada != null
                ? 'Ubicado en: ${_posSeleccionada!.latitude.toStringAsFixed(5)}, ${_posSeleccionada!.longitude.toStringAsFixed(5)}'
                : 'Toca el mapa para seleccionar la ubicación',
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.save),
              label: const Text('Guardar Tour'),
              onPressed: _submit,
            ),
          ),
        ]),
      ),
    );
  }

  Widget _campo(String label, TextEditingController ctrl, IconData icon,
      {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        controller: ctrl,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: const OutlineInputBorder(),
        ),
        validator: (val) =>
            val == null || val.isEmpty ? 'Campo requerido' : null,
      ),
    );
  }
}
