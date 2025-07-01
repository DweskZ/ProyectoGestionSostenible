import 'package:flutter/material.dart';

class InicioPage extends StatelessWidget {
  const InicioPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colors.surface,
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'Bienvenido al Corredor Ecológico',
            style: text.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: colors.primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Descubre, observa y registra la biodiversidad de Manabí.',
            style: text.titleMedium?.copyWith(
              color: colors.onSurface.withOpacity(0.7),
            ),
          ),

          const SizedBox(height: 24),

          // Imagen destacada con mejor visibilidad
          Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: SizedBox(
              height: 220,
              child: Image.asset(
                'assets/corredor1.png',
                fit: BoxFit.contain, // Muestra todo, pero ocupa más altura
                alignment: Alignment.center,
              ),
            ),
          ),
        ),


          const SizedBox(height: 32),

          Text(
            '📰 Noticias recientes',
            style: text.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: colors.onBackground,
            ),
          ),
          const SizedBox(height: 12),

          _noticiaCard(
            context,
            titulo: 'Nueva especie registrada en el manglar',
            fecha: '6 de junio 2025',
            icono: Icons.eco_outlined,
          ),
          _noticiaCard(
            context,
            titulo: 'Cierre temporal del sendero norte',
            fecha: '4 de junio 2025',
            icono: Icons.construction_outlined,
          ),
        ],
      ),
    );
  }

  Widget _noticiaCard(
    BuildContext context, {
    required String titulo,
    required String fecha,
    required IconData icono,
  }) {
    final colors = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: colors.secondary.withOpacity(0.05),
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: colors.primary.withOpacity(0.1),
          foregroundColor: colors.primary,
          child: Icon(icono),
        ),
        title: Text(
          titulo,
          style: text.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          '📅 $fecha',
          style: text.bodySmall?.copyWith(
            color: colors.onBackground.withOpacity(0.6),
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          // TODO: abrir detalle de noticia
        },
      ),
    );
  }
}
