// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';

import '../../concepts/hexagrams.dart';
import '../../utils/definitions.dart';
import '../../iconfonts.dart';

class ChangingLinesDisplay extends StatelessWidget
{
	const ChangingLinesDisplay({
		super.key,
		required Hexagram hexagram,
		Set<int> changingLines = const {},
		void Function()? Function(int)? actions,
		Color? color,
		List<Color>? colorList,
		double relativeMarkSize = .75,
		double relativeButtionSize = 1.2,
		Color? activatedColor,
		List<Color>? activatedColorList,
		ButtonType buttonType = ButtonType.textButton,
		Size? forceSize,
	}):
		_hexagram = hexagram,
		_changingLines = changingLines,
		_actions = actions,
		_color = color ?? Colors.black,
		_colorList = colorList,
		_relativeMarkSize = relativeMarkSize,
		_activatedColor = activatedColor ?? const Color(0x30EEEEEE),
		_activatedColorList = activatedColorList,
		_relativeButtonSize = relativeButtionSize,
		_useButtion = (actions != null),
		_buttonType = buttonType,
		_forceSize = forceSize;

	final Hexagram _hexagram;
	final Set<int> _changingLines;
	final void Function()? Function(int)? _actions;
	final Color _color;
	final List<Color>? _colorList;
	final double _relativeMarkSize;
	final double _relativeButtonSize;
	final Color _activatedColor;
	final List<Color>? _activatedColorList;
	final bool _useButtion;
	final ButtonType _buttonType;
	final Size? _forceSize;

	Widget getMark(bool isChanging, bool isYang, double size, [Color color = Colors.black])
	{
		if (!isChanging) return SizedBox(height: size, width: size);
		return SizedBox(
			width: size,
			height: size,
			child: FittedBox(
				fit: BoxFit.contain,
				child: Icon(
					isYang ? IconChangingLines.yang : IconChangingLines.yin,
					color: color,
				)
			),
		);
	}

	Widget getButton(int index, double size, Color activatedColor)
		=> SizedBox(
			width: size,
			height: size,
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
			builder: ((context, constraints) {
				Size boxSize = _forceSize ?? Size(constraints.maxWidth, constraints.maxHeight);
				Size slotSize = Size(boxSize.width, boxSize.height / 6);
				double markSize = min(slotSize.width, slotSize.height) * _relativeMarkSize;
				double buttonSize = markSize * _relativeButtonSize;
				double markStartingPos = (slotSize.height - markSize) / 2;
				double buttionStartingPos = (slotSize.height - buttonSize) / 2;

				return SizedBox(
					width: boxSize.width,
					height: boxSize.height,
					child: Stack(
						alignment: Alignment.center,
						fit: StackFit.expand,
						children: [
							for (int i = 5; i >= 0; --i)
							Positioned(
								top: markStartingPos + (5 - i) * slotSize.height,
								child: getMark(
									_changingLines.contains(i),
									_hexagram.lines[i],
									markSize,
									_colorList?[i] ?? _color
								),
							),
							if (_useButtion)
							for (int i = 5; i >= 0; --i)
							if (_actions!(i) != null)
							Positioned(
								top: buttionStartingPos + (5 - i) * slotSize.height,
								child: getButton(
									i,
									buttonSize,
									_activatedColorList?[i] ?? _activatedColor
								),
							)
						]
					),
				);
			})
		);
	}
}