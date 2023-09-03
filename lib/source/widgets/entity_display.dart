// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../concepts/relatables.dart';

class ObjectDisplay extends StatelessWidget
{
	const ObjectDisplay({
		super.key, 
		required obj, 
		Color color = Colors.black,
		List<String> fontSet = const ["Simhei"],
		double fontSize = 20,
	}): _obj = obj, _color = color, _fontSet = fontSet, _fontSize = fontSize;

	final Object _obj;
	final Color _color;
	final List<String> _fontSet;
	final double _fontSize;

	TextStyle getStyle()
		=> TextStyle(
			color: _color,
			fontFamilyFallback: _fontSet,
			fontSize: _fontSize,
		);

	@override
	Widget build(BuildContext context)
		=> Text(
			"$_obj",
			style: getStyle(),
		);

	TextSpan getTextSpan()
	{
		return TextSpan(
			text: "$_obj",
			style: getStyle(),
		);
	}
}

class RelatableDisplay extends StatelessWidget
{
	const RelatableDisplay({
		super.key, 
		required relatable, 
		Map<Agent?, Color> colorSet = 
		const {
			Agent.wood: Colors.green,
			Agent.fire: Colors.red,
			Agent.earth: Colors.brown,
			Agent.metal: Color.fromARGB(255, 255, 179, 0),
			Agent.water: Colors.blue,
		},
		Map<bool?, List<String>> fontSet = 
		const {
			true: ["Simsun"],
			false: ["Simhei"],
			null: ["Simhei"],
		},
		double fontSize = 20,
	}): 
		_relatable = relatable, 
		_colorSet = colorSet, 
		_fontSet = fontSet, 
		_fontSize = fontSize;

	final Relatable _relatable;
	final Map<Agent?, Color> _colorSet;
	final Map<bool?, List<String>> _fontSet;
	final double _fontSize;

	TextStyle getStyle()
		=> TextStyle(
			color: _colorSet[_relatable.agent],
			fontFamilyFallback: _relatable is Precise 
				? _fontSet[(_relatable as Precise).isYang]
				: _fontSet[null],
			fontSize: _fontSize,
		);
		
	@override
	Widget build(BuildContext context)
		=> Text(
			"$_relatable",
			style: getStyle(),
		);

	TextSpan getTextSpan()
	{
		return TextSpan(
			text: "$_relatable",
			style: getStyle(),
		);
	}
}

class EntityDisplay extends StatelessWidget
{
	const EntityDisplay({
		super.key, 
		required entity, 
		Map<Agent?, Color> colorSet = 
		const {
			Agent.wood: Colors.green,
			Agent.fire: Colors.red,
			Agent.earth: Colors.brown,
			Agent.metal: Color.fromARGB(255, 255, 179, 0),
			Agent.water: Colors.blue,
			null: Colors.black,
		},
		Map<bool?, List<String>> fontSet = 
		const {
			true: ["Simsun"],
			false: ["Simhei"],
			null: ["Simhei"],
		},
		double fontSize = 20,
		bool withoutAgent = false,
	}): 
		_entity = entity, 
		_colorSet = colorSet, 
		_fontSet = fontSet, 
		_fontSize = fontSize,
		_withoutAgent = withoutAgent;

	final Object _entity;
	final Map<Agent?, Color> _colorSet;
	final Map<bool?, List<String>> _fontSet;
	final double _fontSize;
	final bool _withoutAgent;

	TextStyle getStyle()
		=> _entity is Relatable && !_withoutAgent
		? RelatableDisplay(
			relatable: _entity,
			colorSet: _colorSet,
			fontSet: _fontSet,
			fontSize: _fontSize,
		).getStyle()
		: ObjectDisplay(
			obj: _entity,
			color: _colorSet[null]!,
			fontSet: _fontSet[null]!,
			fontSize: _fontSize,
		).getStyle();

	@override
	Widget build(BuildContext context)
		=> _entity is Relatable && !_withoutAgent
		? RelatableDisplay(
			relatable: _entity,
			colorSet: _colorSet,
			fontSet: _fontSet,
			fontSize: _fontSize,
		)
		: ObjectDisplay(
			obj: _entity,
			color: _colorSet[null]!,
			fontSet: _fontSet[null]!,
			fontSize: _fontSize,
		);

	TextSpan getTextSpan()
	{
		return _entity is Relatable && !_withoutAgent
			? RelatableDisplay(
				relatable: _entity,
				colorSet: _colorSet,
				fontSet: _fontSet,
				fontSize: _fontSize,
			).getTextSpan()
			: ObjectDisplay(
				obj: _entity,
				color: _colorSet[null]!,
				fontSet: _fontSet[null]!,
				fontSize: _fontSize,
			).getTextSpan();
	}
}