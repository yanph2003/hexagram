// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class Debug
{
	static String prompt(String str)
	{
		print(str);
		return str;
	}
}

Size measureTextSize(String text, [TextStyle? style])
{
	final TextPainter textPainter = TextPainter(
		text: TextSpan(text: text, style: style), 
		maxLines: 1, 
		textDirection: TextDirection.ltr
	)..layout(minWidth: 0, maxWidth: double.infinity);
	return textPainter.size;
}

Size measureTextSpanSize(TextSpan span)
{
	final TextPainter textPainter = TextPainter(
		text: span, 
		maxLines: 1, 
		textDirection: TextDirection.ltr
	)..layout(minWidth: 0, maxWidth: double.infinity);
	return textPainter.size;
}

Color darken(Color c, [int percent = 10])
{
	assert(1 <= percent && percent <= 100);
	var f = 1 - percent / 100;
	return Color.fromARGB(
		c.alpha,
		(c.red * f).round(),
		(c.green  * f).round(),
		(c.blue * f).round(),
	);
}

Color lighten(Color c, [int percent = 10])
{
	assert(1 <= percent && percent <= 100);
	var p = percent / 100;
	return Color.fromARGB(
		c.alpha,
		c.red + ((255 - c.red) * p).round(),
		c.green + ((255 - c.green) * p).round(),
		c.blue + ((255 - c.blue) * p).round(),
	);
}
