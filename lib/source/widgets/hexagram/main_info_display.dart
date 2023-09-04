// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:flutter/material.dart';
import '../../utils/extensions.dart';
import '../../widgets/entity_display.dart';
import '../../concepts.dart';
import '../../utils/tools.dart';
import '../../utils/definitions.dart';

class MainInfoDisplay extends StatelessWidget
{
	const MainInfoDisplay({
		super.key,

		double maxRatio = 3,
		double minRatio = 0,
		double maxEditorRatio = 2.5,
		double minEditorRatio = 0,

		bool useEdit = false,
		bool useFullPillars = false,
		bool useStems = false,
		bool useRelations = true,

		List<Branch?> branches = const [null, null, null, null],
		List<Stem?> stems =  const [null, null, null, null],
		
		String problem = "",

		void Function()? dateTimeAction,
		void Function()? Function(int) stemsActions = nullFunction,
		void Function()? Function(int) branchesActions = nullFunction,

		required Hexagram hexagram, 
		Set<int> changingLines = const {},


		Color activatedColor = const Color(0x30EEEEEE),
		Map<Agent?, Color> colorSet = 
		const {
			Agent.wood: Colors.green,
			Agent.fire: Colors.red,
			Agent.earth: Colors.brown,
			Agent.metal: Color.fromARGB(255, 255, 217, 0),
			Agent.water: Colors.blue,
			null: Colors.black,
		},
		Map<bool?, List<String>> fontSet = 
		const {
			true: ["Simsun"],
			false: ["Simhei"],
			null: ["Simhei"],
		},
		Color themeColor = Colors.black,
		Color antiThemeColor = Colors.white,
		List<String> mainFont = const ["微软雅黑"],
		List<String> nameFont = const ["楷体"],
	
		TextEditingController? problemController,
		void Function(String)? problemEditAction,

		List<TextEditingController?> dateTimeController = const [null, null, null, null, null, null],
		List<void Function(String)?> dateTimeEditActions = const [null, null, null, null, null, null],

		FocusNode? problemFocusNode,
		List<FocusNode?> dateTimeFocusNodes = const [null, null, null, null, null, null],

		void Function()? fromDateTimeAction,
		void Function()? nowAction, 
		void Function()? clearDateTimeAction,

		void Function()? dateTimeCommentAction,
	}):
		_maxRatio = maxRatio,
		_minRatio = minRatio,
		_maxEditorRatio = maxEditorRatio,
		_minEditorRatio = minEditorRatio,
		_useEdit = useEdit,
		_useFullPillars = useFullPillars,
		_useStems = useStems,
		_useRelations = useRelations,
		_branches = branches,
		_stems = stems,
		_problem = problem,
		_stemsActions = stemsActions,
		_branchesActions = branchesActions,
		_hexagram = hexagram,
		_changingLines = changingLines,
		_colorSet = colorSet,
		_fontSet = fontSet,
		_problemController = problemController,
		_problemEditAction = problemEditAction,
		_mainFont = mainFont,
		_nameFont = nameFont,
		_dateTimeController = dateTimeController,
		_dateTimeEditActions = dateTimeEditActions,
		_fromDateTimeAction = fromDateTimeAction,
		_nowAction = nowAction,
		_clearDateTimeAction = clearDateTimeAction,
		_activatedColor = activatedColor,
		_dateTimeCommentAction = dateTimeCommentAction,
		_themeColor = themeColor,
		_antiThemeColor = antiThemeColor,
		_problemFocusNode = problemFocusNode,
		_dateTimeFocusNodes = dateTimeFocusNodes;

	final double _maxRatio;
	final double _minRatio;
	final double _maxEditorRatio;
	final double _minEditorRatio;

	final bool _useEdit;
	final bool _useFullPillars;
	final bool _useStems;
	final bool _useRelations;

	final List<Branch?> _branches;
	final List<Stem?> _stems;
	final String _problem;
	
	final void Function()? Function(int) _stemsActions;
	final void Function()? Function(int) _branchesActions;

	final Hexagram _hexagram;
	final Set<int> _changingLines;

	final Color _activatedColor;
	final Color _antiThemeColor;
	final Color _themeColor;
	final Map<Agent?, Color> _colorSet;
	final Map<bool?, List<String>> _fontSet;

	final TextEditingController? _problemController;
	final void Function(String)? _problemEditAction;
	
	final List<TextEditingController?> _dateTimeController;
	final List<void Function(String)?> _dateTimeEditActions;

	final void Function()? _fromDateTimeAction;
	final void Function()? _nowAction;
	final void Function()? _clearDateTimeAction;

	final void Function()? _dateTimeCommentAction;

	final FocusNode? _problemFocusNode;
	final List<FocusNode?> _dateTimeFocusNodes;

	final List<String> _mainFont;
	final List<String> _nameFont;

	TextSpan getHexagramInfo(double fontSize)
	{
		return TextSpan(
			children: [
				TextSpan(
					text: "${_hexagram.palace}",
					style: TextStyle(
						color: _themeColor,
						fontFamilyFallback: _nameFont,
						fontSize: fontSize,
					)
				),
				TextSpan(
					text: "　",
					style: TextStyle(
						color: _themeColor,
						fontFamilyFallback: _nameFont,
						fontSize: fontSize * .05,
					)
				),
				TextSpan(
					text: "宫",
					style: TextStyle(
						color: _themeColor,
						fontFamilyFallback: _nameFont,
						fontSize: fontSize * .6,
					)
				),
				TextSpan(
					text: "　",
					style: TextStyle(
						color: _themeColor,
						fontFamilyFallback: _nameFont,
						fontSize: fontSize * .05,
					)
				),
				TextSpan(
					text: _hexagram.position,
					style: TextStyle(
						color: _themeColor,
						fontFamilyFallback: _nameFont,
						fontSize: fontSize,
					)
				),
				TextSpan(
					text: "　",
					style: TextStyle(
						color: _themeColor,
						fontFamilyFallback: _nameFont,
						fontSize: fontSize * .05,
					)
				),
				TextSpan(
					text: "卦",
					style: TextStyle(
						color: _themeColor,
						fontFamilyFallback: _nameFont,
						fontSize: fontSize * .6,
					)
				),
				TextSpan(
					text: "　　",
					style: TextStyle(
						color: _themeColor,
						fontFamilyFallback: _nameFont,
						fontSize: fontSize * .2,
					)
				),
				TextSpan(
					text: "$_hexagram",
					style: TextStyle(
						color: _themeColor,
						fontFamilyFallback: _nameFont,
						fontSize: fontSize,
					)
				),
				if (_changingLines.isNotEmpty)
				TextSpan(
					text: "　",
					style: TextStyle(
						color: _themeColor,
						fontFamilyFallback: _nameFont,
						fontSize: fontSize * .05,
					)
				),
				if (_changingLines.isNotEmpty)
				TextSpan(
					text: "之",
					style: TextStyle(
						color: _themeColor,
						fontFamilyFallback: _nameFont,
						fontSize: fontSize * .6,
					)
				),
				if (_changingLines.isNotEmpty)
				TextSpan(
					text: "　",
					style: TextStyle(
						color: _themeColor,
						fontFamilyFallback: _nameFont,
						fontSize: fontSize * .05,
					)
				),
				if (_changingLines.isNotEmpty)
				TextSpan(
					text: "${_hexagram.change(_changingLines)}",
					style: TextStyle(
						color: _themeColor,
						fontFamilyFallback: _nameFont,
						fontSize: fontSize,
					)
				),
			],
		);
	}
	
	TextSpan getPillar(int index, double fontSize, {bool useSameSize = false, bool forceUseStems = false})
	{
		return 	TextSpan(
			children: [
				if (_useStems || forceUseStems)
				EntityDisplay(
					entity: _stems[index] ?? "　",
					colorSet: _colorSet,
					fontSet: _fontSet,
					fontSize: fontSize * (useSameSize ? 1 : .75),
				).getTextSpan(),
				EntityDisplay(
					entity: _branches[index] ?? "　",
					colorSet: _colorSet,
					fontSet: _fontSet,
					fontSize: fontSize,
				).getTextSpan(),
				TextSpan(
					text: ["年", "月", "日", "时"][index],
					style: TextStyle(
						color: _themeColor,
						fontFamilyFallback: _mainFont,
						fontSize: fontSize * .6,
					)
				),
			],
		);
	}

	TextSpan getDateTimeInfo(double fontSize, {bool useSameSize = false, bool forceUseStems = false, bool forceFullPillars = false})
	{
		return TextSpan(
			children: [
				if (_useFullPillars || forceFullPillars)
				TextSpan(text: "　", style: TextStyle(fontSize: fontSize * .15)),
				if (_useFullPillars || forceFullPillars)
				getPillar(0, fontSize, useSameSize: useSameSize, forceUseStems: forceUseStems),
				if (_useFullPillars || forceFullPillars)
				TextSpan(text: "　", style: TextStyle(fontSize: fontSize * .15)),

				TextSpan(text: "　", style: TextStyle(fontSize: fontSize * .15)),
				getPillar(1, fontSize, useSameSize: useSameSize, forceUseStems: forceUseStems),
				TextSpan(text: "　　", style: TextStyle(fontSize: fontSize * .15)),
				getPillar(2, fontSize, useSameSize: useSameSize, forceUseStems: forceUseStems),
				TextSpan(text: "　", style: TextStyle(fontSize: fontSize * .15)),

				if (_useFullPillars || forceFullPillars)
				TextSpan(text: "　", style: TextStyle(fontSize: fontSize * .15)),
				if (_useFullPillars || forceFullPillars)
				getPillar(3, fontSize, useSameSize: useSameSize, forceUseStems: forceUseStems),
				if (_useFullPillars || forceFullPillars)
				TextSpan(text: "　", style: TextStyle(fontSize: fontSize * .15)),
			]
		);
	}

	Widget getInfo()
	{
		return LayoutBuilder(
			builder: (context, constraints)
			{
				Size slotSize = Size(constraints.maxWidth, constraints.maxHeight / 2);
				if (_useRelations) slotSize = Size(constraints.maxWidth, constraints.maxHeight / 2.6);
				Size measuredHex = measureTextSpanSize(getHexagramInfo(100));
				double scalerHex = min(
					slotSize.width / measuredHex.width,
					slotSize.height / measuredHex.height,
				);
				Size measuredDT = measureTextSpanSize(getDateTimeInfo(100));
				double scalerDT = min(
					slotSize.width / measuredDT.width,
					slotSize.height / measuredDT.height,
				);
				double determinedFontSize = 100 * min(scalerDT, scalerHex) * .9;
				Size realDateTimeSize = measureTextSpanSize(getDateTimeInfo(determinedFontSize));
				
				return SizedBox.expand(
					child: Stack(
						alignment: Alignment.center,
						children: [
							Positioned(
								top: 0,
								child: SizedBox(
									width: slotSize.width,
									height: slotSize.height,
									child: Center(
										child: Text.rich(getHexagramInfo(determinedFontSize)),
									),
								),
							),
							Positioned(
								top: slotSize.height,
								child: SizedBox(
									width: slotSize.width,
									height: slotSize.height,
									child: Center(
										child: Text.rich(getDateTimeInfo(determinedFontSize)),
									),
								),
							),
							Positioned(
								top: 1.9 * slotSize.height,
								child: SizedBox(
									width: realDateTimeSize.width,
									height: slotSize.height * .6,
									child: Row(
										children: [
											if (_useFullPillars)
											Expanded(child: Text(
												"${_hexagram.palace.relate(_branches[0]!)}",
												style: TextStyle(
													color: _themeColor,
													fontSize: determinedFontSize * .5,
													fontFamilyFallback: _mainFont,
												),
												textAlign: TextAlign.center,
											)),
											Expanded(child: Text(
												"${_hexagram.palace.relate(_branches[1]!)}",
												style: TextStyle(
													color: _themeColor,
													fontSize: determinedFontSize * .5,
													fontFamilyFallback: _mainFont,
												),
												textAlign: TextAlign.center,
											)),
											Expanded(child: Text(
												"${_hexagram.palace.relate(_branches[2]!)}",
												style: TextStyle(
													color: _themeColor,
													fontSize: determinedFontSize * .5,
													fontFamilyFallback: _mainFont,
												),
												textAlign: TextAlign.center,
											)),
											if (_useFullPillars)
											Expanded(child: Text(
												"${_hexagram.palace.relate(_branches[3]!)}",
												style: TextStyle(
													color: _themeColor,
													fontSize: determinedFontSize * .5,
													fontFamilyFallback: _mainFont,
												),
												textAlign: TextAlign.center,
											)),
										],
									),
								),
							),
							Positioned(
								top: slotSize.height + (slotSize.height - realDateTimeSize.height * 1.05) / 2,
								child: SizedBox(
									width: realDateTimeSize.width * 1.05,
									height: realDateTimeSize.height * 1.05,
									child: TextButton(
										style: ButtonStyle(
											overlayColor: MaterialStateProperty.resolveWith(
												(states) => states.any({
													MaterialState.pressed, 
													MaterialState.hovered
												}.contains) ? _activatedColor : null,
											)
										),
										onPressed: _dateTimeCommentAction, 
										child: Text(""),
									),
								),
							),
						],
					),
				);
			}
		);
	}

	@Deprecated("Old Design.")
	Widget getProblem()
	{
		return LayoutBuilder(
			builder: (context, constraints)
			{
				Size boxSize = Size(constraints.maxWidth, constraints.maxHeight);
				Size measuredSize = measureTextSize(
					"字",
					TextStyle(
						fontFamilyFallback: _mainFont,
						fontSize: 100,
					)
				);
				double scaler = boxSize.width / (measuredSize.width * 16) * .95;
			
				int maxLines = boxSize.height ~/ (measuredSize.height * scaler / .95) - 1;
				if (maxLines < 1)
				{
					scaler = boxSize.height / (measuredSize.height * 2) * .95;
					maxLines = 1;
				}

				return Column(
					crossAxisAlignment: CrossAxisAlignment.start,
					mainAxisAlignment: MainAxisAlignment.center,
					children: [
						Row(
							crossAxisAlignment: CrossAxisAlignment.start,
							children: [
								Text(
									"问：",
									textAlign: TextAlign.start,
									style: TextStyle(
										fontFamilyFallback: _mainFont,
										color: _themeColor,
										fontSize: 100 * scaler,
									),
								),
								Expanded(
									child: Text(
										_problem,
										textAlign: TextAlign.start,
										overflow: TextOverflow.ellipsis,
										maxLines: maxLines,
										style: TextStyle(
											fontFamilyFallback: _mainFont,
											color: _themeColor,
											fontSize: 100 * scaler,
										),
									)
								)
							],
						),
						Text(
							"得：",
							textAlign: TextAlign.start,
							style: TextStyle(
								fontFamilyFallback: _mainFont,
								color: _themeColor,
								fontSize: 100 * scaler,
							),
						),	
					],
				);
			},
		);
	}

	Widget getProblemEditor([bool readOnly = false])
	{
		return LayoutBuilder(
			builder: (context, constraints)
			{
				Size boxSize = Size(constraints.maxWidth, constraints.maxHeight);
				Size measuredSize = measureTextSize(
					"字",
					TextStyle(
						fontFamilyFallback: _mainFont,
						fontSize: 100,
					)
				);
				double scaler = boxSize.width / (measuredSize.width * 17) * .95;
			
				int maxLines = boxSize.height ~/ (measuredSize.height * scaler / .95) - 1;
				if (maxLines < 1)
				{
					scaler = boxSize.height / (measuredSize.height * 3) * .95;
					maxLines = 1;
				}

				return Column(
					crossAxisAlignment: CrossAxisAlignment.center,
					mainAxisAlignment: MainAxisAlignment.center,
					children: 
					[
						TextField(
							autofocus: false,
							autocorrect: false,
							controller: _problemController,
							onChanged: _problemEditAction,
							focusNode: _problemFocusNode,
							textAlign: TextAlign.start,
							maxLines: maxLines,
							style: TextStyle(
								fontFamilyFallback: _mainFont,
								color: _themeColor,
								fontSize: 100 * scaler,
							),
							decoration: InputDecoration(
					        	border: OutlineInputBorder(),
					        	labelText: '待占事项',
								labelStyle: TextStyle(
									fontFamilyFallback: _mainFont,
								),
								isDense: true,
								contentPadding: EdgeInsets.symmetric(
									horizontal: 100 * scaler * .45, 
									vertical: 100 * scaler * .5, 
								),
					        ),
							readOnly: readOnly,
						)
					],
				);
			},
		);
	}

	TextSpan getDateTimeEditor(double fontSize, [bool test = false])
	{
		TextSpan getSpanFrom(bool stem, int index)
		{
			return EntityDisplay(
				entity: (stem ? _stems : _branches)[index] ?? (test ? "字" : "　"),
				colorSet: _colorSet,
				fontSet: _fontSet,
				fontSize: fontSize,
			).getTextSpan();
		}
		TextSpan separator(double scaler, [String text = "　"])
			=> TextSpan(text: text, style: TextStyle(
				fontSize: fontSize * scaler, 
				fontFamilyFallback: _mainFont,
				color: _themeColor,
			));

		return TextSpan(
			children: [
				for (int i = 0; i < 4; ++i)
				TextSpan(
					children: [
						separator(i == 0 ? .05 : .2),
						getSpanFrom(true, i),
						separator(.12),
						getSpanFrom(false, i),
						separator(i == 3 ? .05 : .2),
					]
				)
			]
		);
	}

	Widget getInfoEditor()
	{
		return LayoutBuilder(
			builder: (context, constraints)
			{
				Size slotSize = Size(constraints.maxWidth, constraints.maxHeight / 4.6);
				Size measuredHex = measureTextSpanSize(getHexagramInfo(100));
				double scalerHex = min(
					slotSize.width / measuredHex.width,
					slotSize.height / measuredHex.height,
				);
				Size measuredDT = measureTextSpanSize(getDateTimeEditor(100, true));
				double scalerDT = min(
					slotSize.width / measuredDT.width,
					slotSize.height / measuredDT.height,
				);
				Size realDateTimeSize = measureTextSpanSize(getDateTimeEditor(100 * scalerDT * .9, true));

				Positioned drawButton(double left, void Function()? action, [bool fill = false])
				{
					return Positioned(
						left: realDateTimeSize.width / 9.78 * left,
						child: SizedBox(
							width: realDateTimeSize.width / 9.78 * 1.04,
							height: realDateTimeSize.height * 1.05,
							child: TextButton(
								onPressed: action,
								style: ButtonStyle(
									overlayColor: MaterialStateProperty.resolveWith(
										(states) => states.any({
											MaterialState.pressed, 
											MaterialState.hovered
										}.contains) ? _activatedColor : null,
									),
									backgroundColor: MaterialStateProperty.resolveWith(
										(states) => fill ? _themeColor : _themeColor.withOpacity(.01),
									),
								),
								child: Text(""),
							)
						),
					);
				}

				List<List<String>> regExpAllow = [
					[r"^(([0-9]{0,4})|(-[0-9]{0,3})|(-[0-3][0-9]{3})|(-4[0-6][0-9]{2})|(-470[0-9])|(-471[0-3]))$"],
					[r"^((0?[1-9]?)|(1[0-2]))$",],
					[r"^((0?[1-9]?)|([1-2][0-9])|(3[0-1]))$",],
					[r"^((0?[0-9]?)|(1[0-9])|(2[0-3]))$",],
					[r"^((0?[0-9]?)|([1-5][0-9]))$",],
					[r"^((0?[0-9]?)|([1-5][0-9]))$",],
				];

				List<List<String>> regExpDeny = [
					[r"^(-?0+)$"],
					[r"^(0+)$"],
					[r"^(0+)$"],
					[],
					[],
					[],
				];
				
				TextField getDateTimeInput(int index)
				{
					_dateTimeFocusNodes[index]?.addListener(
						() {
							if (_dateTimeFocusNodes[index]!.hasFocus && _dateTimeController[index] != null)
							{
								_dateTimeController[index]!.selection = TextSelection(baseOffset: 0, extentOffset: _dateTimeController[index]!.text.length);
							}
						}
					);
					return TextField(
						autofocus: false,
						autocorrect: false,
						keyboardType: TextInputType.number,
						controller: _dateTimeController[index],
						onChanged: _dateTimeEditActions[index],
						focusNode: _dateTimeFocusNodes[index],
						textAlign: TextAlign.center,
						style: TextStyle(
							fontFamilyFallback: _mainFont,
							color: _themeColor,
							fontSize: 100 * scalerDT * .52,
						),
						decoration: InputDecoration(
				        	border: OutlineInputBorder(),
				        	labelText: ['年', '月', '日', '时', '分', '秒'][index],
							labelStyle: TextStyle(
								fontFamilyFallback: _mainFont,
							),
							isDense: true,
							contentPadding: EdgeInsets.symmetric(
								horizontal: 100 * scalerDT * .2, 
								vertical: 100 * scalerDT * .4, 
							),
				        ),
						inputFormatters: [
							RegExpFormat(regExpAllow[index], regExpDeny[index]),
						],
					);
				}
				
				return SizedBox.expand(
					child: Stack(
						alignment: Alignment.center,
						children: [
							Positioned(
								top: 0,
								child: SizedBox(
									width: slotSize.width,
									height: slotSize.height,
									child: Center(
										child: Text.rich(getHexagramInfo(100 * scalerHex * .9)),
									),
								),
							),
							Positioned(
								top: slotSize.height,
								child: SizedBox(
									width: slotSize.width,
									height: slotSize.height,
									child: Center(
										child: Text.rich(getDateTimeEditor(100 * scalerDT * .9)),
									),
								),
							),
							Positioned(
								top: slotSize.height + (slotSize.height - realDateTimeSize.height * 1.05) / 2,
								child: SizedBox(
									width: realDateTimeSize.width,
									height: realDateTimeSize.height * 1.05,
									child: Stack(
										alignment: Alignment.center,
										children: [
											drawButton(0.03, _stemsActions(0)),
											drawButton(1.15, _branchesActions(0)),
											drawButton(2.55, _stemsActions(1)),
											drawButton(3.67, _branchesActions(1)),
											drawButton(5.07, _stemsActions(2)),
											drawButton(6.19, _branchesActions(2)),
											drawButton(7.59, _stemsActions(3)),
											drawButton(8.71, _branchesActions(3)),
										],
									),
								),
							),
							Positioned(
								top: 2.25 * slotSize.height + slotSize.height * .05 / 2,
								child: SizedBox(
									width: min(realDateTimeSize.width * 1.2, slotSize.width * .9),
									height: slotSize.height * .95,
									child: Row(
										crossAxisAlignment: CrossAxisAlignment.center,
										children: [
											Expanded(
												flex: 36,
												child: getDateTimeInput(0),
											),
											Expanded(
												flex: 7,
												child: FittedBox(
													fit: BoxFit.contain,
													child: Text(" / ")
												),
											),
											Expanded(
												flex: 20,
												child: getDateTimeInput(1),
											),
											Expanded(
												flex: 7,
												child: FittedBox(
													fit: BoxFit.contain,
													child: Text(" / ")
												),
											),
											Expanded(
												flex: 20,
												child: getDateTimeInput(2),
											),
											Spacer(
												flex: 7,													
											),
											Expanded(
												flex: 20,
												child: getDateTimeInput(3),
											),
											Expanded(
												flex: 7,
												child: FittedBox(
													fit: BoxFit.contain,
													child: Text(" : ")
												),
											),
											Expanded(
												flex: 20,
												child: getDateTimeInput(4),
											),
											Expanded(
												flex: 7,
												child: FittedBox(
													fit: BoxFit.contain,
													child: Text(" : ")
												),
											),
											Expanded(
												flex: 20,
												child: getDateTimeInput(5),
											),
										],
									),
								),
							),
							Positioned(
								top: 3.45 * slotSize.height + slotSize.height * .1 / 2,
								child: SizedBox(
									width: min(realDateTimeSize.width * 1.2, slotSize.width * .9),
									height: slotSize.height * .9,
									child: Row(
										crossAxisAlignment: CrossAxisAlignment.center,
										children: [
											Spacer(flex: 1),
											Expanded(
												flex: 80,
												child: ConstrainedBox(
													constraints: BoxConstraints(minHeight: slotSize.height * .9),
													child: FilledButton(
														onPressed: _nowAction,
														style: ButtonStyle(
															// overlayColor: MaterialStateProperty.resolveWith(
															// 	(states) => states.any({
															// 		MaterialState.pressed, 
															// 		MaterialState.hovered
															// 	}.contains) ? _activatedColor : null,
															// ),
															backgroundColor: MaterialStateProperty.resolveWith(
																(states) => Theme.of(context).primaryColor.lighten(10),
															),
															padding: MaterialStateProperty.resolveWith(
																(states) => EdgeInsets.zero,
															),
															shape: MaterialStateProperty.resolveWith(
																(states) => RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(3))),
															)
														),
														child: Text(
															"当前时间",
															style: TextStyle(
																fontFamilyFallback: _mainFont,
																color: _antiThemeColor,
																fontSize: 100 * scalerDT * .58,
															),
														),
													),
												),
											),
											Spacer(flex: 10),
											Expanded(
												flex: 140,
												child: ConstrainedBox(
													constraints: BoxConstraints(minHeight: slotSize.height * .9),
													child: FilledButton(
														onPressed: _fromDateTimeAction,
														style: ButtonStyle(
															// overlayColor: MaterialStateProperty.resolveWith(
															// 	(states) => states.any({
															// 		MaterialState.pressed, 
															// 		MaterialState.hovered
															// 	}.contains) ? _activatedColor : null,
															// ),
															backgroundColor: MaterialStateProperty.resolveWith(
																(states) => Theme.of(context).primaryColor.lighten(10),
															),
															padding: MaterialStateProperty.resolveWith(
																(states) => EdgeInsets.zero,
															),
															shape: MaterialStateProperty.resolveWith(
																(states) => RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(3))),
															)
														),
														child: Text(
															"从时间设定干支",
															style: TextStyle(
																fontFamilyFallback: _mainFont,
																color: _antiThemeColor,
																fontSize: 100 * scalerDT * .58,
															),
														),
													),
												)
											),
											Spacer(flex: 10),
											Expanded(
												flex: 40,
												child: ConstrainedBox(
													constraints: BoxConstraints(minHeight: slotSize.height * .9),
													child: FilledButton(
														onPressed: _clearDateTimeAction,
														style: ButtonStyle(
															// overlayColor: MaterialStateProperty.resolveWith(
															// 	(states) => states.any({
															// 		MaterialState.pressed, 
															// 		MaterialState.hovered
															// 	}.contains) ? _activatedColor : null,
															// ),
															backgroundColor: MaterialStateProperty.resolveWith(
																(states) => Theme.of(context).primaryColor.lighten(10),
															),
															padding: MaterialStateProperty.resolveWith(
																(states) => EdgeInsets.zero,
															),
															shape: MaterialStateProperty.resolveWith(
																(states) => RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(3))),
															)
														),
														child: Text(
															"清除",
															style: TextStyle(
																fontFamilyFallback: _mainFont,
																color: _antiThemeColor,
																fontSize: 100 * scalerDT * .58,
															),
														),
													),
												),
											),
											Spacer(flex: 1),
										],
									),
								),
							),
						],
					),
				);
			}
		);
	}

	@override
	Widget build(BuildContext context)
	{
		bool useEdit = _useEdit;
		if (_branches.length < 3 || _branches[1] == null || _branches[2] == null)
		{
			useEdit = true;
		}
		if (_useFullPillars)
		{
			if (_branches.length < 4 || _branches[0] == null || _branches[3] == null)
			{
				useEdit = true;
			}
		}
		if (_useStems)
		{
			if (_stems.length < 3 || _stems[1] == null || _stems[2] == null)
			{
				useEdit = true;
			}
			if (_useFullPillars)
			{
				if (_stems.length < 4 || _stems[0] == null || _stems[3] == null)
				{
					useEdit = true;
				}
			}
		}

		return LayoutBuilder(
			builder: (context, constraints)
			{
				double width = constraints.maxWidth;
				double height = constraints.maxHeight;
				if (useEdit)
				{
					if (width / height > _maxEditorRatio) width = height * _maxEditorRatio;
					if (width / height < _minEditorRatio) height = width / _minEditorRatio;
					return Center(
						child: SizedBox(
							width: width,
							height: height,
							child: Column(
								children: [
									Expanded(
										flex: 200 + (width / height > 1.5 ? 0 : (1.5 - width / height) ~/ .008),
										child: getProblemEditor(),
									),
									Expanded(
										flex: 500,
										child: getInfoEditor(),
									),
								],
							),
						),
					);
				}
				else
				{
					if (width / height > _maxRatio) width = height * _maxRatio;
					if (width / height < _minRatio) height = width / _minRatio;
					return Center(
						child: SizedBox(
							width: width,
							height: height,
							child: Column(
								children: [
									Expanded(
										flex: 180 + (width / height > 1.8 ? 0 : (1.8 - width / height) ~/ .005),
										child: getProblemEditor(true),
									),
									Expanded(
										flex: 200 + (_useRelations ? 60 : 0),
										child: getInfo()
									),
								],
							),
						),
					);
				}
			}
		);
	}
}