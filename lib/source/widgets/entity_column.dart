// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:flutter/material.dart';
import '../utils/tools.dart';

import 'entity_display.dart';
import '../concepts/relatables.dart';
import '../utils/definitions.dart';

class EntityColumn extends StatelessWidget
{
	const EntityColumn({
		super.key,
		required List<Object> entities,
		void Function()? Function(int)? actions,
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
			true: ["SourceHanSerifSC"],
			false: ["SourceHanSansSC"],
			null: ["SourceHanSansSC"],
		},
		bool withoutAgent = false,
		Size relativeEntitySize = const Size(.8, .8),
		double relativeButtionSize = 1.1,
		Color? activatedColor,
		List<Color>? activatedColorList,
		ButtonType buttonType = ButtonType.textButton,
		Size? forceSize,
		bool uniformFontSize = true,
		bool? textSizedButton,
	}):
		_entities = entities,
		_actions = actions,
		_length = entities.length,
		_colorSet = colorSet,
		_fontSet = fontSet,
		_withoutAgent = withoutAgent,
		_relativeEntitySize = relativeEntitySize,
		_activatedColor = activatedColor ?? const Color(0x30EEEEEE),
		_activatedColorList = activatedColorList,
		_relativeButtonSize = relativeButtionSize,
		_useButtion = (actions != null),
		_buttonType = buttonType,
		_forceSize = forceSize,
		_uniformFontSize = uniformFontSize,
		_textSizedButton = textSizedButton ?? uniformFontSize;

	final List<Object> _entities;
	final int _length;
	final void Function()? Function(int)? _actions;
	final Map<Agent?, Color> _colorSet;
	final Map<bool?, List<String>> _fontSet;
	final bool _withoutAgent;
	final Size _relativeEntitySize;
	final double _relativeButtonSize;
	final Color _activatedColor;
	final List<Color>? _activatedColorList;
	final bool _useButtion;
	final ButtonType _buttonType;
	final Size? _forceSize;
	final bool _uniformFontSize;
	final bool _textSizedButton;

	Widget getButton(int index, Size size, Color activatedColor)
		=> SizedBox(
			width: size.width,
			height: size.height,
			child: switch (_buttonType)
			{
				ButtonType.outlinedButton => OutlinedButton(
					onPressed: (_actions ?? (x) => null)(index),
					style: ButtonStyle(
						overlayColor: MaterialStateProperty.resolveWith(
							(states) => states.any({
								MaterialState.pressed, 
								MaterialState.hovered
							}.contains) ? activatedColor : null,
						)
					),
					child: null,
				),
				_ => TextButton(
					onPressed: (_actions ?? (x) => null)(index),
					style: ButtonStyle(
						overlayColor: MaterialStateProperty.resolveWith(
							(states) => states.any({
								MaterialState.pressed, 
								MaterialState.hovered
							}.contains) ? activatedColor : null,
						)
					),
					child: Text(""),
				),
			}
		);

	@override
	Widget build(BuildContext context)
	{
		return LayoutBuilder(
			builder: (context, constraints) {
				Size boxSize = _forceSize ?? Size(constraints.maxWidth, constraints.maxHeight);
				Size slotSize = Size(boxSize.width, boxSize.height / _length);
				Size entitySize = Size(slotSize.width * _relativeEntitySize.width, slotSize.height * _relativeEntitySize.height); 
				
				List<Size> measuredSizes = _entities.map(
					(e) => measureTextSize(
						"$e",
						EntityDisplay(
							entity: e, 
							colorSet: _colorSet,
							fontSet: _fontSet,
							withoutAgent: _withoutAgent,
							fontSize: 100,
						).getStyle(),
					),
				).toList();
				List<double> determinedFontSizes = measuredSizes.map(
					(e) => min(entitySize.width / e.width, entitySize.height / e.height) * 100,
				).toList();
				if (_uniformFontSize)
				{
					determinedFontSizes = List.filled(_length, determinedFontSizes.reduce(min));
				}
				List<Size> realSizes = [for (int i = 0; i < _length; ++i) Size(
					measuredSizes[i].width * determinedFontSizes[i] / 100,
					measuredSizes[i].height * determinedFontSizes[i] / 100,
				)];

				List<double> entityStartingPos = realSizes.map((e) => ((slotSize.height - e.height) / 2)).toList();

				double increment = min(entitySize.width, entitySize.height) * (_relativeButtonSize - 1);
				Size buttonSize = Size(
					entitySize.width + increment,
					entitySize.height + increment,
				);
				if (_textSizedButton)
				{
					Size realMaxTextSize = Size(
						realSizes.map((e) => e.width).reduce(max),
						realSizes.map((e) => e.height).reduce(max),
					);
					increment = min(realMaxTextSize.width, realMaxTextSize.height) * (_relativeButtonSize - 1);
					buttonSize = Size(realMaxTextSize.width + increment, realMaxTextSize.height + increment);
				}
				double buttonStartingPos = (slotSize.height - buttonSize.height) / 2;

				return SizedBox(
					width: boxSize.width,
					height: boxSize.height,
					child: Stack(
						alignment: Alignment.center,
						fit: StackFit.expand,
						children: [
							for (int i = _length - 1; i >= 0; --i)
							Positioned(
								top: entityStartingPos[i] + (_length - 1 - i) * slotSize.height,
								child: EntityDisplay(
									entity: _entities[i],
									colorSet: _colorSet,
									fontSet: _fontSet,
									fontSize: determinedFontSizes[i],
									withoutAgent: _withoutAgent,
								),
							),
							if (_useButtion)
							for (int i = _length; i >= 0; --i)
							if (_actions!(i) != null)
							Positioned(
								top: buttonStartingPos + (_length - 1 - i) * slotSize.height,
								child: getButton(
									i,
									buttonSize,
									_activatedColorList?[i] ?? _activatedColor
								),
							),
						],
					),
				);
			}
		);
	}
}