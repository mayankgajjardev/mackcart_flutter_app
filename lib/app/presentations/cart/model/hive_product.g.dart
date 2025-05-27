// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_product.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveProductAdapter extends TypeAdapter<HiveProduct> {
  @override
  final int typeId = 0;

  @override
  HiveProduct read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveProduct(
      id: fields[0] as int?,
      title: fields[1] as String?,
      description: fields[2] as String?,
      category: fields[3] as String?,
      price: fields[4] as double?,
      discountPercentage: fields[5] as double?,
      rating: fields[6] as double?,
      stock: fields[7] as int?,
      tags: (fields[8] as List?)?.cast<String>(),
      brand: fields[9] as String?,
      sku: fields[10] as String?,
      weight: fields[11] as int?,
      warrantyInformation: fields[12] as String?,
      shippingInformation: fields[13] as String?,
      availabilityStatus: fields[14] as String?,
      returnPolicy: fields[15] as String?,
      minimumOrderQuantity: fields[16] as int?,
      images: (fields[17] as List?)?.cast<String>(),
      thumbnail: fields[18] as String?,
      qty: fields[19] as int,
    );
  }

  @override
  void write(BinaryWriter writer, HiveProduct obj) {
    writer
      ..writeByte(20)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.category)
      ..writeByte(4)
      ..write(obj.price)
      ..writeByte(5)
      ..write(obj.discountPercentage)
      ..writeByte(6)
      ..write(obj.rating)
      ..writeByte(7)
      ..write(obj.stock)
      ..writeByte(8)
      ..write(obj.tags)
      ..writeByte(9)
      ..write(obj.brand)
      ..writeByte(10)
      ..write(obj.sku)
      ..writeByte(11)
      ..write(obj.weight)
      ..writeByte(12)
      ..write(obj.warrantyInformation)
      ..writeByte(13)
      ..write(obj.shippingInformation)
      ..writeByte(14)
      ..write(obj.availabilityStatus)
      ..writeByte(15)
      ..write(obj.returnPolicy)
      ..writeByte(16)
      ..write(obj.minimumOrderQuantity)
      ..writeByte(17)
      ..write(obj.images)
      ..writeByte(18)
      ..write(obj.thumbnail)
      ..writeByte(19)
      ..write(obj.qty);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveProductAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
