import 'package:hive/hive.dart';

part 'ave.g.dart';

@HiveType(typeId: 2)
class Ave extends HiveObject {
  @HiveField(0) String familia;
  @HiveField(1) String nombreIngles;
  @HiveField(2) String nombreCientifico;
  @HiveField(3) String nombreEspanol;
  @HiveField(4) String nombreComun;
  @HiveField(5) String imagenUrl;
  @HiveField(6) String sonidoUrl;
  @HiveField(7) String colorPredominante;
  @HiveField(8) String formaPico;
  @HiveField(9) String tamano;
  @HiveField(10) String habitat;
  @HiveField(11) String comportamiento;

  Ave({
    required this.familia,
    required this.nombreIngles,
    required this.nombreCientifico,
    required this.nombreEspanol,
    required this.nombreComun,
    required this.imagenUrl,
    required this.sonidoUrl,
    required this.colorPredominante,
    required this.formaPico,
    required this.tamano,
    required this.habitat,
    required this.comportamiento,
  });

  factory Ave.fromJson(Map<String, dynamic> json) => Ave(
        familia: json['familia'] ?? '',
        nombreIngles: json['nombreIngles'] ?? '',
        nombreCientifico: json['nombreCientifico'] ?? '',
        nombreEspanol: json['nombreEspanol'] ?? '',
        nombreComun: json['nombreComun'] ?? '',
        imagenUrl: json['imagenUrl'] ?? '',
        sonidoUrl: json['sonidoUrl'] ?? '',
        colorPredominante: json['colorPredominante'] ?? '',
        formaPico: json['formaPico'] ?? '',
        tamano: json['tamano'] ?? '',
        habitat: json['habitat'] ?? '',
        comportamiento: json['comportamiento'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'familia': familia,
        'nombreIngles': nombreIngles,
        'nombreCientifico': nombreCientifico,
        'nombreEspanol': nombreEspanol,
        'nombreComun': nombreComun,
        'imagenUrl': imagenUrl,
        'sonidoUrl': sonidoUrl,
        'colorPredominante': colorPredominante,
        'formaPico': formaPico,
        'tamano': tamano,
        'habitat': habitat,
        'comportamiento': comportamiento,
      };
}
