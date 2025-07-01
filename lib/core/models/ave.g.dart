// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ave.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AveAdapter extends TypeAdapter<Ave> {
  @override
  final int typeId = 2;

  @override
  Ave read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Ave(
      familia: fields[0] as String,
      nombreIngles: fields[1] as String,
      nombreCientifico: fields[2] as String,
      nombreEspanol: fields[3] as String,
      nombreComun: fields[4] as String,
      imagenUrl: fields[5] as String,
      sonidoUrl: fields[6] as String,
      colorPredominante: fields[7] as String,
      formaPico: fields[8] as String,
      tamano: fields[9] as String,
      habitat: fields[10] as String,
      comportamiento: fields[11] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Ave obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.familia)
      ..writeByte(1)
      ..write(obj.nombreIngles)
      ..writeByte(2)
      ..write(obj.nombreCientifico)
      ..writeByte(3)
      ..write(obj.nombreEspanol)
      ..writeByte(4)
      ..write(obj.nombreComun)
      ..writeByte(5)
      ..write(obj.imagenUrl)
      ..writeByte(6)
      ..write(obj.sonidoUrl)
      ..writeByte(7)
      ..write(obj.colorPredominante)
      ..writeByte(8)
      ..write(obj.formaPico)
      ..writeByte(9)
      ..write(obj.tamano)
      ..writeByte(10)
      ..write(obj.habitat)
      ..writeByte(11)
      ..write(obj.comportamiento);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
