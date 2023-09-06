import '../json.dart';
import 'package:json_annotation/json_annotation.dart';

part 'catalog.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class HexagramCatalog
{
	HexagramCatalog({
		required this.catalog,
	});

	@JsonKey(required: true) 
	final Map<String, BriefHexagramRecord> catalog;

	factory HexagramCatalog.fromJson(Map<String, dynamic> json) => _$HexagramCatalogFromJson(json);
	Map<String, dynamic> toJson() => _$HexagramCatalogToJson(this);
}