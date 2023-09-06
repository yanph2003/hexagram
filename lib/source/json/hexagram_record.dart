// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import '../concepts.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hexagram_record.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class BriefHexagramRecord
{
	BriefHexagramRecord({
		required this.month,
		required this.day,
		required this.problem,
		required this.hexagram,
		required this.changingLines,
	});

	@JsonKey(required: true) final Branch month;
	@JsonKey(required: true) final Branch day;
	@JsonKey(required: true) final String problem;
	@JsonKey(required: true) final Hexagram hexagram;
	@JsonKey(required: true) final Set<int> changingLines;

	factory BriefHexagramRecord.fromJson(Map<String, dynamic> json) => _$BriefHexagramRecordFromJson(json);
	Map<String, dynamic> toJson() => _$BriefHexagramRecordToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class HexagramRecordConfig
{
	@JsonKey(defaultValue: false) final bool useFullPillars;
	@JsonKey(defaultValue: false) final bool useStems;

	HexagramRecordConfig({required this.useFullPillars, required this.useStems});

	factory HexagramRecordConfig.fromJson(Map<String, dynamic> json) => _$HexagramRecordConfigFromJson(json);
	Map<String, dynamic> toJson() => _$HexagramRecordConfigToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class HexagramRecord
{
	@JsonKey(required: true) final String problem;
	@JsonKey(required: true) final Hexagram hexagram;
	@JsonKey(required: true) final Set<int> changingLines;
	@JsonKey(required: true) final List<Stem?> stems;
	@JsonKey(required: true) final List<Branch?> branches;

	List<int?>? dateTime;
	Object? comments; // TODO: comment system unfinished

	HexagramRecordConfig? config;

	HexagramRecord({
		required this.problem,
		required this.hexagram,
		required this.changingLines,
		required this.stems,
		required this.branches,
		this.comments,
		this.dateTime,
		this.config,
	});

	factory HexagramRecord.fromJson(Map<String, dynamic> json) => _$HexagramRecordFromJson(json);
	Map<String, dynamic> toJson() => _$HexagramRecordToJson(this);
}
