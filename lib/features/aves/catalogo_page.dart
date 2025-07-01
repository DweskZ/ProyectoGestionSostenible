import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_application_1/core/models/ave.dart';

class CatalogoPage extends StatefulWidget {
  const CatalogoPage({super.key});
  @override State<CatalogoPage> createState() => _CatalogoPageState();
}

class _CatalogoPageState extends State<CatalogoPage> {
  String? filtroColor;
  String? filtroPico;
  final colores = ['amarillo','naranja','rojo','rosado','marrón','verde','azul','negro','blanco','gris'];
  final picos = ['fino','curvado','grueso','recto','corto'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          spacing: 8,
          children: [
            DropdownButton<String>(
              hint: const Text('Color'),
              value: filtroColor,
              items: colores.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
              onChanged: (v) => setState(() => filtroColor = v),
            ),
            DropdownButton<String>(
              hint: const Text('Pico'),
              value: filtroPico,
              items: picos.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
              onChanged: (v) => setState(() => filtroPico = v),
            ),
            TextButton.icon(
              onPressed: () => setState(() {
                filtroColor = null; filtroPico = null;
              }),
              icon: const Icon(Icons.clear_all),
              label: const Text('Limpiar'),
            )
          ],
        ),
        Expanded(
          child: ValueListenableBuilder(
            valueListenable: Hive.box<Ave>('aves').listenable(),
            builder: (_, box, __) {
              var aves = box.values.toList();
              if (filtroColor != null) aves = aves.where((a) => a.colorPredominante == filtroColor).toList();
              if (filtroPico != null) aves = aves.where((a) => a.formaPico == filtroPico).toList();
              return GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16),
                itemCount: aves.length,
                itemBuilder: (_, i) {
                  final ave = aves[i];
                  return GestureDetector(
                    onTap: () {
                      // TODO: mostrar detalle ave
                    },
                    child: Card(
                      elevation: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(child: Image.asset(ave.imagenUrl, fit: BoxFit.cover)),
                          const SizedBox(height: 8),
                          Text(ave.nombreComun, textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        )
      ],
    );
  }
}
