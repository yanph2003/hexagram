import 'package:flutter/services.dart';

void Function()? nullFunction(int x) => null;

enum ButtonType
{
	textButton, outlinedButton, filledButton
}

enum ButtonShape
{
	circle, square,
}

class RegExpFormat extends TextInputFormatter
{
	RegExpFormat([this.regExpAllow = const [], this.regExpDeny = const []]);
	final List<String> regExpAllow;
	final List<String> regExpDeny;

	@override
	TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue)
	{
		bool flag = true;
		for (final x in regExpAllow)
		{
			flag &= RegExp(x).allMatches(newValue.text).isNotEmpty;
		}
		for (final y in regExpDeny)
		{
			flag &= RegExp(y).allMatches(newValue.text).isEmpty;
		}
		if (flag)
		{
			return TextEditingValue(
				text: newValue.text,
				selection: newValue.selection,
				composing: TextRange.empty
		    );
		}
		else
		{
			return TextEditingValue(
				text: oldValue.text,
				selection: oldValue.selection,
				composing: TextRange.empty
		    );
		}
	}
}