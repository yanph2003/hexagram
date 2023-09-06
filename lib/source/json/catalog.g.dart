// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catalog.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HexagramCatalog _$HexagramCatalogFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['catalog'],
  );
  return HexagramCatalog(
    catalog: (json['catalog'] as Map<String, dynamic>).map(
      (k, e) =>
          MapEntry(k, BriefHexagramRecord.fromJson(e as Map<String, dynamic>)),
    ),
  );
}

Map<String, dynamic> _$HexagramCatalogToJson(HexagramCatalog instance) =>
    <String, dynamic>{
      'catalog': instance.catalog.map((k, e) => MapEntry(k, e.toJson())),
    };
