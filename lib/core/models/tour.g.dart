// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tour.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TourAdapter extends TypeAdapter<Tour> {
  @override
  final int typeId = 1;

  @override
  Tour read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Tour(
      id: fields[0] as String,
      nombre: fields[1] as String,
      descripcion: fields[2] as String,
      fecha: fields[3] as DateTime,
      guiaId: fields[4] as String,
      participantesIds: (fields[5] as List).cast<String>(),
      latitud: fields[6] as double?,
      longitud: fields[7] as double?,
      direccion: fields[8] as String?,
      whatsappGrupoUrl: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Tour obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.nombre)
      ..writeByte(2)
      ..write(obj.descripcion)
      ..writeByte(3)
      ..write(obj.fecha)
      ..writeByte(4)
      ..write(obj.guiaId)
      ..writeByte(5)
      ..write(obj.participantesIds)
      ..writeByte(6)
      ..write(obj.latitud)
      ..writeByte(7)
      ..write(obj.longitud)
      ..writeByte(8)
      ..write(obj.direccion)
      ..writeByte(9)
      ..write(obj.whatsappGrupoUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TourAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
