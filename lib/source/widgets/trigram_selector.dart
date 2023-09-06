// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import '../concepts/trigrams.dart';
import '../utils/tools.dart';

enum TrigramSelectorIcon
{
	name, image, char,
}

class TrigramSelector extends StatelessWidget
{
	const TrigramSelector({
		super.key,

		Color activatedColor = const Color(0x30EEEEEE),
		Color backgroundColor = const Color(0xFF000000),
		Color iconColor = const Color(0xFFFFFFFF),
		List<String> iconFont = const ["SourceHanSansSC"],
		Trigram? selected,
		Color selectedColor = const Color(0xFF7F7F7F),
		TrigramSelectorIcon iconType = TrigramSelectorIcon.name,
		void Function()? Function(Trigram)? actions,
		bool useManifested = false,
		double relativeButtonSize = .85,
		double relativeIconSize = .85,
		Widget? centerWidget,
		bool circleButton = false,
	}):
		_activatedColor = activatedColor,
		_backgroundColor = backgroundColor,
		_iconType = iconType,
		_actions = actions,
		_useManifested = useManifested,
		_relativeButtonSize = relativeButtonSize,
		_relativeIconSize = relativeIconSize,
		_centerWidget = centerWidget,
		_iconColor = iconColor,
		_iconFont = iconFont,
		_selected = selected,
		_selectedColor = selectedColor,
		_circleButtion = circleButton;

	final Color _activatedColor;
	final Color _backgroundColor;
	final Color _iconColor;
	final List<String> _iconFont;
	final TrigramSelectorIcon _iconType;
	final void Function()? Function(Trigram)? _actions;
	final bool _useManifested;
	final double _relativeIconSize;
	final double _relativeButtonSize;
	final Widget? _centerWidget;
	final Trigram? _selected;
	final Color _selectedColor;
	final bool _circleButtion;

	double getFontSize(String text, TextStyle style, Size size)
	{
		Size measured = measureTextSize(text, style.copyWith(fontSize: 100));
		double scaler = min(size.width / measured.width, size.height / measured.height);
		return 100 * scaler;
	}

	Widget getButton(Trigram? tri, Size size)
	{
		if (tri == null)
		{
			return SizedBox(
				width: size.width,
				height: size.height,
				child: FittedBox(
					fit: BoxFit.contain,
					child: _centerWidget,
				),
			);
		}
		TextStyle style = TextStyle(color: _iconColor, fontFamilyFallback: _iconFont);
		return SizedBox(
			width: size.width,
			height: size.height,
			child: TextButton(
				onPressed: tri == _selected ? null : (_actions ?? (x) => null)(tri),
				style: ButtonStyle(
					overlayColor: MaterialStateProperty.resolveWith(
						(states) => states.any({
							MaterialState.pressed, 
							MaterialState.hovered
						}.contains) ? _activatedColor : null,
					),
					backgroundColor: MaterialStateProperty.resolveWith(
						(states) => tri == _selected ? _selectedColor : _backgroundColor,
					),
					shape: MaterialStateProperty.resolveWith(
						(states) => _circleButtion ? CircleBorder() : null,
					)
				),
				child: FittedBox(
					fit: BoxFit.contain,
					child: switch (_iconType)
					{
						TrigramSelectorIcon.name => Text("$tri", style: style.copyWith(
							fontSize: getFontSize("$tri", style, size * _relativeIconSize)
						)),
						TrigramSelectorIcon.image => Text(tri.image, style: style.copyWith(
							fontSize: getFontSize(tri.image, style, size * _relativeIconSize)
						)),
						TrigramSelectorIcon.char => Text(tri.char, style: style.copyWith(
							fontSize: getFontSize(tri.char, style, size * _relativeIconSize)
						)),
					},
				),
			),
		);
	}

	@override
	Widget build(BuildContext context)
	{
		return LayoutBuilder(
			builder: (context, constraints)
			{
				double boxSize = min(constraints.maxWidth, constraints.maxHeight) / 3;
				double buttonSize = boxSize * _relativeButtonSize;
				final List<List<Trigram?>> arrangement; 
				if (_useManifested)
				{
					arrangement = [
						[Trigram.xun, Trigram.li, Trigram.kun],
						[Trigram.zhen, null, Trigram.dui],
						[Trigram.gen, Trigram.kan, Trigram.qian],
					];
				}
				else
				{
					arrangement = [
						[Trigram.dui, Trigram.qian, Trigram.xun],
						[Trigram.li, null, Trigram.kan],
						[Trigram.zhen, Trigram.kun, Trigram.gen],
					];
				}

				return ConstrainedBox(
					constraints: BoxConstraints(
						maxHeight: min(constraints.maxWidth, constraints.maxHeight),
						maxWidth: min(constraints.maxWidth, constraints.maxHeight),
					),
					child: Stack(
						alignment: Alignment.center,
						children: [
							for (int i = 0; i < 3; ++i)
							for (int j = 0; j < 3; ++j)
							Positioned(
								top: (boxSize - buttonSize) / 2 + i * boxSize,
								left: (boxSize - buttonSize) / 2 + j * boxSize,
								child: getButton(arrangement[i][j], Size(buttonSize, buttonSize)),
							)
						],
					),
				);
				
			}
		);
	}
}