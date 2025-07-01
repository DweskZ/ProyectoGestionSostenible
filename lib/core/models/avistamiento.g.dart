// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'avistamiento.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AvistamientoAdapter extends TypeAdapter<Avistamiento> {
  @override
  final int typeId = 5;

  @override
  Avistamiento read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Avistamiento(
      id: fields[0] as String,
      aveId: fields[1] as String,
      usuarioId: fields[2] as String,
      fecha: fields[3] as DateTime,
      cantidad: fields[4] as int,
      notas: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Avistamiento obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.aveId)
      ..writeByte(2)
      ..write(obj.usuarioId)
      ..writeByte(3)
      ..write(obj.fecha)
      ..writeByte(4)
      ..write(obj.cantidad)
      ..writeByte(5)
      ..write(obj.notas);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AvistamientoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
