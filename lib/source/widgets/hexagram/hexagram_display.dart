// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';

import '../../concepts/hexagrams.dart';
import '../../utils/definitions.dart';

class HexagramDisplay extends StatelessWidget
{
	const HexagramDisplay({
		super.key,
		required Hexagram hexagram,
		void Function()? Function(int)? actions,
		Color? color,
		List<Color>? colorList,
		double maxLineRatio = 7,
		double minLineRatio = 5.5,
		Size relativeLineSize = const Size(.9, .55),
		double relativeButtionSize = 1.6,
		Color? activatedColor,
		List<Color>? activatedColorList,
		ButtonType buttonType = ButtonType.textButton,
		Size? forceSize,
	}):
		_hexagram = hexagram,
		_actions = actions,
		_color = color ?? Colors.black,
		_colorList = colorList,
		_maxLineRatio = maxLineRatio,
		_minLineRatio = minLineRatio,
		_relativeLineSize = relativeLineSize,
		_activatedColor = activatedColor ?? const Color(0x23EEEEEE),
		_activatedColorList = activatedColorList,
		_relativeButtonSize = relativeButtionSize,
		_useButtion = (actions != null),
		_buttonType = buttonType,
		_forceSize = forceSize;

	final Hexagram _hexagram;
	final void Function()? Function(int)? _actions;
	final Color _color;
	final List<Color>? _colorList;
	final double _maxLineRatio;
	final double _minLineRatio;
	final Size _relativeLineSize;
	final double _relativeButtonSize;
	final Color _activatedColor;
	final List<Color>? _activatedColorList;
	final bool _useButtion;
	final ButtonType _buttonType;
	final Size? _forceSize;

	Widget getLine(bool isYang, Size size, [Color color = Colors.black])
		=> isYang 
			?  SizedBox(
				width: size.width,
				height: size.height,
				child: DecoratedBox(
					decoration: BoxDecoration(
						color: color,
					),
				),
			)
			: SizedBox(
				width: size.width,
				height: size.height,
				child: Stack(
					alignment: Alignment.center,
					children: [
						Positioned(
							left: 0,
							height: size.height,
							width: size.width / (12/5),
							child: DecoratedBox(
								decoration: BoxDecoration(
									color: color,
								),
							)
						),
						SizedBox(
							height: size.height,
							width: size.width / (12/2),
							child: DecoratedBox(
								decoration: BoxDecoration(
									color: Color(0x00000000),
								),
							)
						),
						Positioned(
							right: 0,
							height: size.height,
							width: size.width / (12/5),
							child: DecoratedBox(
								decoration: BoxDecoration(
									color: color,
								),
							)
						),
					]
				),
			);

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
				Size slotSize = Size(boxSize.width, boxSize.height / 6);
				Size lineSize = Size(
					slotSize.width * _relativeLineSize.width, 
					slotSize.height * _relativeLineSize.height,
				);
				if (lineSize.aspectRatio > _maxLineRatio)
				{
					lineSize = Size(lineSize.height * _maxLineRatio, lineSize.height);
				}
				else if (lineSize.aspectRatio < _minLineRatio)
				{
					lineSize = Size(lineSize.width, lineSize.width / _minLineRatio);
				}
				double increment = min(lineSize.width, lineSize.height) * (_relativeButtonSize - 1);
				Size buttonSize = Size(
					lineSize.width + increment, 
					lineSize.height + increment,
				);
				double lineStartingPos = (slotSize.height - lineSize.height) / 2;
				double buttonStartingPos = (slotSize.height - buttonSize.height) / 2;

				return SizedBox(
					width: boxSize.width,
					height: boxSize.height,
					child: Stack(
						alignment: Alignment.center,
						fit: StackFit.expand,
						children: [
							for (int i = 5; i >= 0; --i)
							Positioned(
								top: lineStartingPos + (5 - i) * slotSize.height,
								child: getLine(
									_hexagram.lines[i],
									lineSize,
									_colorList?[i] ?? _color
								),
							),
							if (_useButtion)
							for (int i = 5; i >= 0; --i)
							if (_actions!(i) != null)
							Positioned(
								top: buttonStartingPos + (5 - i) * slotSize.height,
								child: getButton(
									i,
									buttonSize,
									_activatedColorList?[i] ?? _activatedColor
								),
							)
						]
					),
				);
			}
		);
	}
}