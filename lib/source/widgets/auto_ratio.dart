// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';

enum RatioPreference
{
	maxWidth, maxHeight, balanced;
}

class AutoRatio extends StatelessWidget
{
	const AutoRatio({
		super.key, 
		required double maxRatio, 
		double? minRatio, 
		RatioPreference ratioPref = RatioPreference.maxWidth,
		Alignment align = Alignment.center,
		required Widget child,
	}):
		_minRatio = minRatio ?? maxRatio, 
		_maxRatio = maxRatio, 
		_ratioPref = ratioPref,
		_align = align,
		_child = child;
	final double _minRatio;
	final double _maxRatio;
	final RatioPreference _ratioPref;
	final Alignment _align;
	final Widget _child;

	@override
	Widget build(BuildContext context)
		=> LayoutBuilder(
			builder: (BuildContext context, BoxConstraints constraints)
			{
				double superMaxRatio = constraints.maxWidth / constraints.minHeight;
				double superMinRatio = constraints.minWidth / constraints.maxHeight;
				double ratio = 0;
				if (superMinRatio >= _maxRatio)
				{
					ratio = _maxRatio;
				}
				else if (superMaxRatio <= _minRatio)
				{
					ratio = _minRatio;
				}
				else
				{
					double tmpMax = min(_maxRatio, superMaxRatio);
					double tmpMin = max(_minRatio, superMinRatio);
					ratio = switch (_ratioPref)
					{
						RatioPreference.maxWidth => tmpMax,
						RatioPreference.maxHeight => tmpMin,
						RatioPreference.balanced => sqrt(tmpMax * tmpMin),
					};
				}
				return FittedBox(
					fit: BoxFit.contain,
					alignment: _align,
					child: SizedBox(
						width: ratio * 200,
						height: 200,
						child: _child,
					)
				);
			}
		);
}