import 'dart:math';

import 'package:flutter/material.dart';

extension IntOperators on int
{
	int positiveMod(int x)
	{
		if (x == 0)
		{
			throw UnsupportedError("IntegerModedByZero");
		}
		else if (x > 0)
		{
			return (this % x + x) % x;
		}
		else
		{
			return -(this % (-x) - x) % (-x);
		}
	}
}

extension ToBool on Object?
{
	bool toBool()
	{
		switch (this)
		{
			case bool(): return (this as bool);
			case num(): return (this as num) != 0;
			case List(): return (this as List).isNotEmpty;
			case Set(): return (this as Set).isNotEmpty;
			case Map(): return (this as Map).isNotEmpty;
			default: return this != null;
		}
	}
}

extension ToInt on bool
{
	int toInt()	=> this ? 1 : 0;
}

extension ListToInt on List
{
	int toInt()
	{
		int res = 0;
		for (bool x in reversed.map((e) => (e as Object?).toBool()))
		{
			res <<= 1;
			res |= (x ? 1 : 0);
		}
		return res;
	}
}

extension ListFromMap<T> on Map<int, T>
{
	List<T> buildList({required T fill, int? len})
	{
		int length = len ?? 0;
		if (!isEmpty)
		{
			length = max(keys.reduce(max)+1, length);
		}
		List<T> l = List.filled(length, fill);
		for (var x in entries)
		{
			l[x.key] = x.value;
		}
		return l;
	}
}

extension ColorManipulate on Color
{
	Color darken([int percent = 10])
	{
		assert(1 <= percent && percent <= 100);
		var f = 1 - percent / 100;
		return Color.fromARGB(
			alpha,
			(red * f).round(),
			(green  * f).round(),
			(blue * f).round(),
		);
	}

	Color lighten([int percent = 10])
	{
		assert(1 <= percent && percent <= 100);
		var p = percent / 100;
		return Color.fromARGB(
			alpha,
			red + ((255 - red) * p).round(),
			green + ((255 - green) * p).round(),
			blue + ((255 - blue) * p).round(),
		);
	}
}