// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import '../concepts/branches.dart';
import '../utils/tools.dart';

class BranchSelector extends StatelessWidget
{
	const BranchSelector({
		super.key,

		Color activatedColor = const Color(0x30EEEEEE),
		Color backgroundColor = const Color(0xFF000000),
		Color iconColor = const Color(0xFFFFFFFF),
		List<String> iconFont = const ["Simhei"],
		Branch? selected,
		Color selectedColor = const Color(0xFF7F7F7F),
		void Function()? Function(Branch)? actions,
		double relativeButtonSize = .85,
		double relativeIconSize = .85,
		bool circleButton = false,
	}):
		_activatedColor = activatedColor,
		_backgroundColor = backgroundColor,
		_relativeButtonSize = relativeButtonSize,
		_relativeIconSize = relativeIconSize,
		_iconColor = iconColor,
		_iconFont = iconFont,
		_selected = selected,
		_selectedColor = selectedColor,
		_circleButtion = circleButton,
		_actions = actions;

	final Color _activatedColor;
	final Color _backgroundColor;
	final Color _iconColor;
	final List<String> _iconFont;
	final double _relativeIconSize;
	final double _relativeButtonSize;
	final Branch? _selected;
	final Color _selectedColor;
	final bool _circleButtion;
	final void Function()? Function(Branch)? _actions;

	double getFontSize(String text, TextStyle style, Size size)
	{
		Size measured = measureTextSize(text, style.copyWith(fontSize: 100));
		double scaler = min(size.width / measured.width, size.height / measured.height);
		return 100 * scaler;
	}

	Widget getButton(Branch? branch, Size size)
	{
		if (branch == null)
		{
			return SizedBox(
				width: size.width,
				height: size.height
			);
		}
		TextStyle style = TextStyle(color: _iconColor, fontFamilyFallback: _iconFont);
		return SizedBox(
			width: size.width,
			height: size.height,
			child: TextButton(
				onPressed: branch == _selected ? null : (_actions ?? (x) => null)(branch),
				style: ButtonStyle(
					overlayColor: MaterialStateProperty.resolveWith(
						(states) => states.any({
							MaterialState.pressed, 
							MaterialState.hovered
						}.contains) ? _activatedColor : null,
					),
					backgroundColor: MaterialStateProperty.resolveWith(
						(states) => branch == _selected ? _selectedColor : _backgroundColor,
					),
					shape: MaterialStateProperty.resolveWith(
						(states) => _circleButtion ? CircleBorder() : null,
					)
				),
				child: FittedBox(
					fit: BoxFit.contain,
					child: Text("$branch", style: style.copyWith(
						fontSize: getFontSize("$branch", style, size * _relativeIconSize)
					))
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
				double boxSize = min(constraints.maxWidth / 4, constraints.maxHeight / 3);
				double buttonSize = boxSize * _relativeButtonSize;
				final List<List<Branch?>> arrangement = [
					[Branch.zi, Branch.chou, Branch.yin, Branch.mao],
					[Branch.chen, Branch.si, Branch.wu, Branch.wei],
					[Branch.shen, Branch.you, Branch.xu, Branch.hai],
				];
				
				return ConstrainedBox(
					constraints: BoxConstraints(
						maxHeight: boxSize * 3,
						maxWidth: boxSize * 4,
					),
					child: Stack(
						alignment: Alignment.center,
						children: [
							for (int i = 0; i < 3; ++i)
							for (int j = 0; j < 4; ++j)
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