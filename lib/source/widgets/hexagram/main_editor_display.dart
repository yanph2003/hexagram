// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import '../../utils/definitions.dart';
import '../../concepts/hexagrams.dart';
import '../trigram_selector.dart';
import '../hexagram/hexagram_display.dart';
import '../hexagram/changing_lines_display.dart';
import '../../concepts/trigrams.dart';



class MainEditorDisplay extends StatelessWidget
{
	const MainEditorDisplay({
		super.key,

		required Hexagram hexagram,
		Set<int> changingLines = const {},

		Color activatedColor = const Color(0x30EEEEEE),
		Color themeColor = const Color(0xFF000000),
		Color selectorIconColor = const Color(0xFFFFFFFF),
		List<String> selectorIconFont = const ["楷体"],
		Color selectedColor = const Color(0xFF7F7F7F),
		TrigramSelectorIcon selectorIconType = TrigramSelectorIcon.name,
		void Function()? Function(Trigram)? upperSelectorActions,
		void Function()? Function(Trigram)? lowerSelectorActions,
		bool selectorUseManifested = false,
		Widget? upperCenterWidget,
		Widget? lowerCenterWidget,
		bool selectorCircleButton = false,

		void Function()? Function(int)? linesActions,
		void Function()? Function(int)? changingMarksActions,

		double maxRatio = 1.2,
		double minRatio = .9,
	}):
		_hexagram = hexagram,
		_changingLines = changingLines,
		_activatedColor = activatedColor,
		_themeColor = themeColor,
		_selectorIconColor = selectorIconColor,
		_selectorIconFont = selectorIconFont,
		_selectedColor = selectedColor,
		_selectorIconType = selectorIconType,
		_upperSelectorActions = upperSelectorActions,
		_lowerSelectorActions = lowerSelectorActions,
		_selectorUseManifested = selectorUseManifested,
		_upperCenterWidget = upperCenterWidget,
		_lowerCenterWidget = lowerCenterWidget,
		_selectorCircleButton = selectorCircleButton,
		_linesActions = linesActions,
		_changingMarksActions = changingMarksActions,
		_maxRatio = maxRatio,
		_minRatio = minRatio;

	final Hexagram _hexagram;
	final Set<int> _changingLines;

	final Color _activatedColor;
	final Color _themeColor;
	final Color _selectorIconColor;
	final List<String> _selectorIconFont;
	final Color _selectedColor;
	final TrigramSelectorIcon _selectorIconType;
	final void Function()? Function(Trigram)? _upperSelectorActions;
	final void Function()? Function(Trigram)? _lowerSelectorActions;
	final bool _selectorUseManifested;
	final Widget? _upperCenterWidget;
	final Widget? _lowerCenterWidget;
	final bool _selectorCircleButton;

	final void Function()? Function(int)? _linesActions;
	final void Function()? Function(int)? _changingMarksActions;

	final double _maxRatio;
	final double _minRatio;


	@override
	Widget build(BuildContext context)
	{
		return LayoutBuilder(
			builder: (context, constraints)
			{
				double width = constraints.maxWidth;
				double height = constraints.maxHeight;
				if (width / height > _maxRatio) width = height * _maxRatio;
				if (width / height < _minRatio) height = width / _minRatio;
				return Row(
					mainAxisAlignment: MainAxisAlignment.center,
					crossAxisAlignment: CrossAxisAlignment.center,
					children: [
						SizedBox(
							width: width,
							height: height,
							child: Column(
								mainAxisAlignment: MainAxisAlignment.center,
								crossAxisAlignment: CrossAxisAlignment.center,
								children: [
									Expanded(
										flex: 100,
										child: Row(
											mainAxisAlignment: MainAxisAlignment.center,
											crossAxisAlignment: CrossAxisAlignment.center,
											children: [
												Expanded(
													flex: 13,
													child: Column(
														mainAxisAlignment: MainAxisAlignment.center,
														crossAxisAlignment: CrossAxisAlignment.center,
														children: [
															Expanded(
																child: Padding(
																	padding: EdgeInsets.all(3),
																	child: Center(
																		child: TrigramSelector(
																			activatedColor: _activatedColor,
																			backgroundColor: _themeColor,
																			iconColor: _selectorIconColor,
																			iconFont: _selectorIconFont,
																			selected: _hexagram.outer,
																			selectedColor: _selectedColor,
																			iconType: _selectorIconType,
																			useManifested: _selectorUseManifested,
																			circleButton: _selectorCircleButton,
																			actions: _upperSelectorActions,
																			centerWidget: _upperCenterWidget
																				?? Center(
																					child: Text(
																						"外卦",
																						style: TextStyle(
																							fontFamilyFallback: 
																								_selectorIconFont,
																						),
																					),
																				),
																		),
																	),
																)
															),
															Expanded(
																child: Padding(
																	padding: EdgeInsets.all(3),
																	child: Center(
																		child: TrigramSelector(
																			activatedColor: _activatedColor,
																			backgroundColor: _themeColor,
																			iconColor: _selectorIconColor,
																			iconFont: _selectorIconFont,
																			selected: _hexagram.inner,
																			selectedColor: _selectedColor,
																			iconType: _selectorIconType,
																			useManifested: _selectorUseManifested,
																			circleButton: _selectorCircleButton,
																			actions: _lowerSelectorActions,
																			centerWidget: _lowerCenterWidget
																				?? Center(
																					child: Text(
																						"内卦",
																						style: TextStyle(
																							fontFamilyFallback: 
																								_selectorIconFont,
																						),
																					),
																				),
																		),
																	),
																),
															),
														],
													),
												),
												Expanded(
													flex: 12,
													child: HexagramDisplay(
														hexagram: _hexagram,
														actions: _linesActions,
														color: _themeColor,
														activatedColor: _activatedColor,
														buttonType: ButtonType.outlinedButton,
													)
												),
												Expanded(
													flex: 3,
													child: ChangingLinesDisplay(
														hexagram: _hexagram,
														changingLines: _changingLines,
														actions: _changingMarksActions,
														color: _themeColor,
														activatedColor: _activatedColor,
														buttonType: ButtonType.outlinedButton,
													)
												)
											],
										),
									),
								],
							),
						)
					],
				);
			},
		);
	}
}