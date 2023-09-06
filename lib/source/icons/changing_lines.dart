import 'package:flutter/material.dart';

class IconChangingLines
{
	static const String fontFamily = "ChangingLines";
	static const IconData yang = IconData(
		0xE900, 
		fontFamily: fontFamily, 
		matchTextDirection: true
	);
	static const IconData yin = IconData(
		0xE901,  
		fontFamily: fontFamily, 
		matchTextDirection: true
	);
	static const IconData blank = IconData(
		0x0, 
		fontFamily: fontFamily,
		matchTextDirection: true
	);
}