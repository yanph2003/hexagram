// ignore_for_file: avoid_print, unused_import

import 'package:lunar/lunar.dart';

void main()
{
	Lunar ln = Lunar.fromDate(DateTime.now()); //Lunar.fromSolar(Solar.fromYmdHms(2023, 9, 2, 23, 1, 0));
	print((ln.getEightChar()..setSect(1)));
}