// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usuario.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UsuarioAdapter extends TypeAdapter<Usuario> {
  @override
  final int typeId = 0;

  @override
  Usuario read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Usuario(
      id: fields[0] as String,
      nombre: fields[1] as String,
      apellido: fields[2] as String,
      email: fields[3] as String,
      telefono: fields[4] as String,
      password: fields[5] as String,
      rol: fields[6] as String,
      cedula: fields[7] as String,
      experiencia: fields[8] as String?,
      especialidades: (fields[9] as List?)?.cast<String>(),
      bio: fields[10] as String?,
      fotoPerfil: fields[11] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Usuario obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.nombre)
      ..writeByte(2)
      ..write(obj.apellido)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.telefono)
      ..writeByte(5)
      ..write(obj.password)
      ..writeByte(6)
      ..write(obj.rol)
      ..writeByte(7)
      ..write(obj.cedula)
      ..writeByte(8)
      ..write(obj.experiencia)
      ..writeByte(9)
      ..write(obj.especialidades)
      ..writeByte(10)
      ..write(obj.bio)
      ..writeByte(11)
      ..write(obj.fotoPerfil);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UsuarioAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
