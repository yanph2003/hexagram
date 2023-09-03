// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

import '../widgets.dart';
import '../concepts.dart';
import '../utils.dart';

// List<Stem?> _emptyStemList = [null, null, null, null];
// List<Branch?> _emptyBranchList = [null, null, null, null];
// List<int?> _emptyDateTimeList = [null, null, null, null, null, null];
// Set<int> _emptyChangingLineSet = {};

class HexagramAnalysisRoute extends StatefulWidget
{
	@override
	State<HexagramAnalysisRoute> createState() => _HexagramAnalysisRouteState();

	const HexagramAnalysisRoute({
		super.key,

		this.edit = true,
		this.comment = false,

		this.hexagram = Hexagram.qianWeiTian,
		this.changingLines = const {},
		this.stems = const [null, null, null, null],
		this.branches = const [null, null, null, null],
		this.problem = "",
		this.dateTime = const [null, null, null, null, null, null],

		this.colorSet = const {
			Agent.wood: Colors.green,
			Agent.fire: Colors.red,
			Agent.earth: Colors.brown,
			Agent.metal: Color.fromARGB(255, 255, 179, 0),
			Agent.water: Colors.blue,
			null: Colors.black,
		},
		this.fontSet = const {
			true: ["Simsun"],
			false: ["Simhei"],
			null: ["Simhei"],
		},
		this.themeColor = Colors.black,
		this.antiThemeColor = Colors.white,
		this.activatedColor = const Color(0x30EEEEEE),
		this.highlightColor,
		this.mainFont = const ["微软雅黑"],
		this.nameFont = const ["楷体"],

		this.analysisColumns = const {
			MainAnalysisColumnType.relations,
			MainAnalysisColumnType.branches,
			MainAnalysisColumnType.generationAndResponse,
			MainAnalysisColumnType.changed,
		},
		this.analysisOnlyHighlightChagingLines = true,
		this.infoUseFullPillars = false,
		this.infoUseStems = false,
		this.infoUseRelations = true,
		this.editorIconType = TrigramSelectorIcon.image,
		this.editorRoundButton = false,
		this.editorUseManifested = false,
	});

	final bool edit;
	final bool comment;

	final Hexagram hexagram;
	final Set<int> changingLines;
	final List<Stem?> stems;
	final List<Branch?> branches;
	final String problem;
	final List<int?> dateTime;

	final Map<Agent?, Color> colorSet;
	final Map<bool?, List<String>> fontSet;
	final Color themeColor;
	final Color activatedColor;
	final Color antiThemeColor;
	final Color? highlightColor;
	final List<String> mainFont;
	final List<String> nameFont;

	final Set<MainAnalysisColumnType> analysisColumns;
	final bool analysisOnlyHighlightChagingLines;
	final bool infoUseFullPillars;
	final bool infoUseStems;
	final bool infoUseRelations;
	final TrigramSelectorIcon editorIconType;
	final bool editorRoundButton;
	final bool editorUseManifested;
}

class _HexagramAnalysisRouteState extends State<HexagramAnalysisRoute>
{
	late bool edit;
	late bool comment;

	late Hexagram hexagram;
	late Set<int> changingLines;
	late List<Stem?> stems;
	late List<Branch?> branches;
	late String problem;
	late List<int?> dateTime;

	late TextEditingController problemController;
	late List<TextEditingController> dateTimeController;

	late FocusNode problemFocusNode;
	late List<FocusNode> dateTimeFocusNodes;

	@override
	void initState()
	{
		edit = widget.edit;
		comment = widget.comment;

		hexagram = widget.hexagram;
		changingLines = {...widget.changingLines};
		stems = [...widget.stems];
		branches = [...widget.branches];
		problem = widget.problem;
		dateTime = [...widget.dateTime];

		problemController = TextEditingController(text: problem);
		dateTimeController = dateTime.map(
			(e) => TextEditingController(text: e == null ? null : "$e"),
		).toList();

		problemFocusNode = FocusNode();
		dateTimeFocusNodes = [for (int i = 0; i < 6; ++i) FocusNode()];

		super.initState();
	}

	Widget getCard({Widget? child})
	{
		return SizedBox.expand(
			child: Container(
				padding: EdgeInsets.all(3),
				decoration: BoxDecoration(
					color: Theme.of(context).primaryColor.lighten(99),
					borderRadius: BorderRadius.circular(3),
					boxShadow: [
						BoxShadow(
							color: Color(0x09000000),
							offset: Offset(2, 2),
							blurRadius: 3
						)
					]
				),
				child: child,
			),
		);
	}

	void Function() fromDateTime(BuildContext context)
	{
		return () async
		{
			if (dateTime[0] != null && dateTime[1] != null && dateTime[2] != null)
			{
				int year = dateTime[0]!;
				int month = dateTime[1]!;
				int day = dateTime[2]!;
				if ([31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31][month-1] < day)
				{
					ScaffoldMessenger.of(context)
						..removeCurrentSnackBar()
						..showSnackBar(SnackBar(content: Text("$month月没有$day日……", style: TextStyle(fontFamilyFallback: widget.mainFont), textAlign: TextAlign.center), duration: Duration(milliseconds: 1500)));
					return ;
				}
				if (year < 0) ++year;
				bool isNotLeap = (year % 4 != 0);
				isNotLeap |= (year % 100 == 0) && (year % 400 != 0);
				if (year <= 0) --year;
				if (month == 2 && day == 29 && isNotLeap)
				{
					ScaffoldMessenger.of(context)
						..removeCurrentSnackBar()
						..showSnackBar(SnackBar(content: Text("${year > 0 ? '' : '公元前'}${year.abs()}年2月没有29日……", style: TextStyle(fontFamilyFallback: widget.mainFont), textAlign: TextAlign.center), duration: Duration(milliseconds: 1500)));
					return ;
				}
				int? hour = dateTime[3];
				int? minute = (hour == null ? null : dateTime[4]);
				int? second = (minute == null ? null : dateTime[5]);
				DateTime date = DateTime(year, month, day);
				List<DateTime> dateSpan = (hour == null ? [date.add(Duration(days: -1)), date] : [date, date]);
				List<int> hourSpan = (hour == null ? [23, 22] : [hour, hour]);
				List<int> minuteSpan = (minute == null ? [0, 59] : [minute, minute]);
				List<int> secondSpan = (second == null ? [0, 59] : [second, second]);

				EightChar begin = Lunar.fromSolar(Solar.fromYmdHms(dateSpan[0].year, dateSpan[0].month, dateSpan[0].day, hourSpan[0], minuteSpan[0], secondSpan[0])).getEightChar()..setSect(1);
				EightChar end = Lunar.fromSolar(Solar.fromYmdHms(dateSpan[1].year, dateSpan[1].month, dateSpan[1].day, hourSpan[1], minuteSpan[1], secondSpan[1])).getEightChar()..setSect(1);
				
				EightChar determinedEc = begin;

				if (begin.getYear() != end.getYear() || begin.getMonth() != end.getMonth())
				{
					String? result = await showDialog<String>(
						context: context, 
						builder: (BuildContext context)
						{
							return AlertDialog(
								title: Text("时间跨越节气", style: TextStyle(fontFamilyFallback: widget.mainFont)),
								content: Text("点击空白处返回，或选择需要的一项：", style: TextStyle(fontFamilyFallback: widget.mainFont)),
								contentPadding: EdgeInsets.fromLTRB(24, 20, 24, 0),
								actionsPadding: EdgeInsets.only(top:10, bottom: 20),
								actionsAlignment: MainAxisAlignment.center,
								actions: [
									Column(
										children: [
											TextButton(
												onPressed: (){Navigator.pop(context, "begin");}, 
												child: Text("${begin.getYear()}　${begin.getMonth()}　${begin.getDay()}${hour == null ? '' : '　${begin.getTime()}'}", style: TextStyle(fontFamilyFallback: widget.mainFont))
											),
											TextButton(
												onPressed: (){Navigator.pop(context, "end");}, 
												child: Text("${end.getYear()}　${end.getMonth()}　${end.getDay()}${hour == null ? '' : '　${end.getTime()}'}", style: TextStyle(fontFamilyFallback: widget.mainFont))
											),
										]
									)
								],
							);
						},
					);
					
					if (result == "begin")
					{
						determinedEc = begin;
					}
					else if (result == "end")
					{
						determinedEc = end;
					}
					else
					{
						return ;
					}
				}

				setState(() {
					stems[0] = Stem.fromChar(determinedEc.getYearGan());
					stems[1] = Stem.fromChar(determinedEc.getMonthGan());
					stems[2] = Stem.fromChar(determinedEc.getDayGan());

					branches[0] = Branch.fromChar(determinedEc.getYearZhi());
					branches[1] = Branch.fromChar(determinedEc.getMonthZhi());
					branches[2] = Branch.fromChar(determinedEc.getDayZhi());

					if (hour == null)
					{
						stems[3] = null;
						branches[3] = null;
					}
					else
					{
						stems[3] = Stem.fromChar(determinedEc.getTimeGan());
						branches[3] = Branch.fromChar(determinedEc.getTimeZhi());
					}
				});
			} 
			else
			{
				ScaffoldMessenger.of(context)
					..removeCurrentSnackBar()
					..showSnackBar(SnackBar(content: Text("提供的日期信息不足以确定干支……", style: TextStyle(fontFamilyFallback: widget.mainFont), textAlign: TextAlign.center), duration: Duration(milliseconds: 1500)));
			}
		};
	}

	void Function() Function(int) getPillarAction([bool stem = false])
	{
		if (stem)
		{
			return (int index) => () async
			{
				String? result = await showDialog<String>(
					context: context, 
					builder: (BuildContext context)
					{
						return AlertDialog(
							content: ConstrainedBox(
								constraints: BoxConstraints(maxWidth: 300, minWidth: 300),
								child: StemSelector(
									activatedColor: widget.activatedColor,
									backgroundColor: widget.themeColor,
									iconColor: widget.antiThemeColor,
									iconFont: widget.mainFont,
									selected: stems[index],
									selectedColor: widget.themeColor.lighten(60),
									circleButton: widget.editorRoundButton,
									actions: (stem)
									{
										return (){
											Navigator.pop(context, stem.toChar());
										};
									},
								),
							),
							contentPadding: EdgeInsets.fromLTRB(24, 20, 24, 0),
							// actionsPadding: EdgeInsets.only(top:10, bottom: 20),
							// actionsAlignment: MainAxisAlignment.center,
							actions: [
								TextButton(
									onPressed: (){Navigator.pop(context, "empty");}, 
									child: Text("置空", style: TextStyle(fontFamilyFallback: widget.mainFont))
								),
								TextButton(
									onPressed: (){Navigator.pop(context);}, 
									child: Text("取消", style: TextStyle(fontFamilyFallback: widget.mainFont))
								),
							],
						);
					},
				);
				if (result == null) return ;
				setState(() {
					dateTime = [null, null, null, null, null, null];
					for (var x in dateTimeController) 
					{
						x.text = "";
					}
					if (result == "empty")
					{
						stems[index] = null;
					}
					else
					{
						stems[index] = Stem.fromChar(result);
						if (branches[index] != null)
						{
							if (branches[index]!.isYang != stems[index]!.isYang)
							{
								branches[index] = null;
							}
						}
					}
				});
			};
		}
		else
		{
			return (int index) => () async
			{
				String? result = await showDialog<String>(
					context: context, 
					builder: (BuildContext context)
					{
						return AlertDialog(
							content: ConstrainedBox(
								constraints: BoxConstraints(maxWidth: 300, minWidth: 300),
								child: BranchSelector(
									activatedColor: widget.activatedColor,
									backgroundColor: widget.themeColor,
									iconColor: widget.antiThemeColor,
									iconFont: widget.mainFont,
									selected: branches[index],
									selectedColor: widget.themeColor.lighten(60),
									circleButton: widget.editorRoundButton,
									actions: (branch)
									{
										return (){
											Navigator.pop(context, branch.toChar());
										};
									},
								),
							),
							contentPadding: EdgeInsets.fromLTRB(24, 20, 24, 0),
							// actionsPadding: EdgeInsets.only(top:10, bottom: 20),
							// actionsAlignment: MainAxisAlignment.center,
							actions: [
								TextButton(
									onPressed: (){Navigator.pop(context, "empty");}, 
									child: Text("置空", style: TextStyle(fontFamilyFallback: widget.mainFont))
								),
								TextButton(
									onPressed: (){Navigator.pop(context);}, 
									child: Text("取消", style: TextStyle(fontFamilyFallback: widget.mainFont))
								),
							],
						);
					},
				);
				if (result == null) return ;
				setState(() {
					dateTime = [null, null, null, null, null, null];
					for (var x in dateTimeController) 
					{
						x.text = "";
					}
					if (result == "empty")
					{
						branches[index] = null;
					}
					else
					{
						branches[index] = Branch.fromChar(result);
						if (stems[index] != null)
						{
							if (branches[index]!.isYang != stems[index]!.isYang)
							{
								stems[index] = null;
							}
						}
					}
				});
			};
		}
	}
	
	@override
	Widget build(BuildContext context)
	{
		if (branches.length < 3 || branches[1] == null || branches[2] == null)
		{
			edit = true;
		}
		if (widget.infoUseFullPillars)
		{
			if (branches.length < 4 || branches[0] == null || branches[3] == null)
			{
				edit = true;
			}
		}
		if (widget.infoUseStems)
		{
			if (stems.length < 3 || stems[1] == null || stems[2] == null)
			{
				edit = true;
			}
			if (widget.infoUseFullPillars)
			{
				if (stems.length < 4 || stems[0] == null || stems[3] == null)
				{
					edit = true;
				}
			}
		}
		return LayoutBuilder(
			builder: (context, constraints)
			{
				problemFocusNode.unfocus();
				for (var x in dateTimeFocusNodes)
				{
					x.unfocus();
				}
				double superRatio = constraints.maxWidth / constraints.maxHeight;
				if (edit)
				{
					return GestureDetector(
						onTapDown: (_)
						{
							problemFocusNode.unfocus();
							for (var x in dateTimeFocusNodes)
							{
								x.unfocus();
							}
						},
						child: Scaffold(
							resizeToAvoidBottomInset: false,
							appBar: AppBar(
								title: Text("编辑", style: TextStyle(fontFamilyFallback: widget.mainFont)),
								actions: [
									IconButton(
										icon: Icon(Icons.save, color: widget.antiThemeColor),
										onPressed: ()
										{
											setState(() {
												edit = false;
												if (branches.length < 3 || branches[1] == null || branches[2] == null)
												{
													edit = true;
												}
												if (widget.infoUseFullPillars)
												{
													if (branches.length < 4 || branches[0] == null || branches[3] == null)
													{
														edit = true;
													}
												}
												if (widget.infoUseStems)
												{
													if (stems.length < 3 || stems[1] == null || stems[2] == null)
													{
														edit = true;
													}
													if (widget.infoUseFullPillars)
													{
														if (stems.length < 4 || stems[0] == null || stems[3] == null)
														{
															edit = true;
														}
													}
												}
												if (edit)
												{
													ScaffoldMessenger.of(context)
														..removeCurrentSnackBar()
														..showSnackBar(SnackBar(content: Text("缺少足够的干支信息，无法保存", style: TextStyle(fontFamilyFallback: widget.mainFont), textAlign: TextAlign.center), duration: Duration(milliseconds: 1500)));
												}
											});
										},
									)
								],
							),
							body: Column(
								crossAxisAlignment: CrossAxisAlignment.center,
								children: [
									Expanded(
										flex: 180,
										child: Padding( 
											padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
											child: getCard(
												child: MainInfoDisplay(
													useEdit: true,
													useFullPillars: widget.infoUseFullPillars,
													useStems: widget.infoUseStems,
													useRelations: widget.infoUseRelations,

													branches: branches,
													stems: stems,
													hexagram: hexagram,
													changingLines: changingLines,
													problem: problem,
													problemController: TextEditingController(
														text: problem,
													),
													problemEditAction: (value)
													{
														problem = value;
														problemController.text = value;
													},
													dateTimeController: dateTimeController,
													dateTimeEditActions: [
														for (int i = 0; i < 6; ++i)
														(value)
														{
															if (value == "" || value == "-")
															{
																dateTime[i] = null;
															}
															else
															{
																dateTime[i] = int.parse(value);
															}
														},
													],
													nowAction: ()
													{
														setState(() {
															final dt = DateTime.now();
															dateTime = [
																dt.year,
																dt.month,
																dt.day,
																dt.hour,
																dt.minute,
																dt.second,
															];
															for (int i = 0; i < 6; ++i)
															{
																dateTimeController[i].text = (dateTime[i] == null ? "" : "${dateTime[i]}");
															}
															EightChar ec = Lunar.fromDate(dt).getEightChar()..setSect(1);
															stems = [
																Stem.fromChar(ec.getYearGan()),
																Stem.fromChar(ec.getMonthGan()),
																Stem.fromChar(ec.getDayGan()),
																Stem.fromChar(ec.getTimeGan()),
															];
															branches = [
																Branch.fromChar(ec.getYearZhi()),
																Branch.fromChar(ec.getMonthZhi()),
																Branch.fromChar(ec.getDayZhi()),
																Branch.fromChar(ec.getTimeZhi()),
															];
														});
													},
													clearDateTimeAction: ()
													{
														setState(() {
															dateTime = List.filled(6, null);
															stems = List.filled(4, null);
															branches = List.filled(4, null);
															for (int i = 0; i < 6; ++i)
															{
																dateTimeController[i].text = "";
															}
														});
													},
													fromDateTimeAction: fromDateTime(context),
													
													stemsActions: getPillarAction(true),
													branchesActions: getPillarAction(false),
													problemFocusNode: problemFocusNode,
													dateTimeFocusNodes: dateTimeFocusNodes,

													colorSet: widget.colorSet,
													fontSet: widget.fontSet,
													themeColor: widget.themeColor,
													antiThemeColor: widget.antiThemeColor,
													activatedColor: widget.activatedColor,
													mainFont: widget.mainFont,
													nameFont: widget.nameFont,
												)
											)
										),
									),
									Expanded(
										flex: 200,
										child: Padding(
											padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
											child: getCard(
												child: MainEditorDisplay(
													hexagram: hexagram,
													changingLines: changingLines,
													activatedColor: widget.activatedColor,
													themeColor: widget.themeColor,
													selectorIconColor: widget.antiThemeColor,
													selectedColor: widget.themeColor.lighten(60),
													selectorIconFont: widget.nameFont,
													selectorIconType: widget.editorIconType,
													selectorCircleButton: widget.editorRoundButton,
													selectorUseManifested: widget.editorUseManifested,
													upperSelectorActions: (Trigram tri)
													{
														return ()
														{
															setState(() {
																hexagram = Hexagram.fromTrigrams(tri, hexagram.inner);
															});
														};
													},
													lowerSelectorActions: (Trigram tri)
													{
														return ()
														{
															setState(() {
																hexagram = Hexagram.fromTrigrams(hexagram.outer, tri);
															});
														};
													},
													linesActions: (int index)
													{
														return ()
														{
															setState(() {
																hexagram = hexagram.change({index});
															});
														};
													},
													changingMarksActions: (int index)
													{
														return ()
														{
															setState(() {
																if (changingLines.contains(index))
																{
																	changingLines.remove(index);
																}
																else
																{
																	changingLines.add(index);
																}
															});
														};
													},
												)
											)
										),
									)
								],
							),
						),
					);
				}
				// else if (comment)
				// {

				// }
				else
				{
					return GestureDetector(
						onTapDown: (_)
						{
							problemFocusNode.unfocus();
						},
						child: Scaffold(
							appBar: AppBar(
								title: Text("${branches[1]}月${branches[2]}日 $hexagram${changingLines.isEmpty ? '' : '之${hexagram.change(changingLines)}'}", style: TextStyle(fontFamilyFallback: widget.mainFont)),
								actions: [
									if (!comment)
									IconButton(
										icon: Icon(Icons.edit_note, color: widget.antiThemeColor),
										onPressed: ()
										{
											setState(() {
												comment = true;
											});
										},
									),
									if (comment)
									IconButton(
										icon: Icon(Icons.notes, color: widget.antiThemeColor),
										onPressed: ()
										{
											setState(() {
												comment = false;
											});
										},
									),
									IconButton(
										icon: Icon(Icons.edit, color: widget.antiThemeColor),
										onPressed: ()
										{
											setState(() {
												edit = true;
											});
										},
									)
								],
							),
							body: Column(
								crossAxisAlignment: CrossAxisAlignment.center,
								children: [
									Expanded(
										flex: 96 + (superRatio > 1 ? (superRatio - 1) ~/ 0.03 : 0),
										child: Padding( 
											padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
											child: getCard(
												child: MainInfoDisplay(
													useEdit: false,
													useFullPillars: widget.infoUseFullPillars,
													useStems: widget.infoUseStems,
													useRelations: widget.infoUseRelations,

													branches: branches,
													stems: stems,
													hexagram: hexagram,
													changingLines: changingLines,
													problem: problem,
													problemController: problemController,
													problemFocusNode: problemFocusNode,

													colorSet: widget.colorSet,
													fontSet: widget.fontSet,
													themeColor: widget.themeColor,
													antiThemeColor: widget.antiThemeColor,
													activatedColor: widget.activatedColor,
													mainFont: widget.mainFont,
													nameFont: widget.nameFont,
												)
											)
										),
									),
									Expanded(
										flex: 200,
										child: Padding(
											padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
											child: getCard(
												child: MainAnalysisDisplay(
													hexagram: hexagram, 
													changingLines: changingLines,
													dayStem: stems[2],
													columns: widget.analysisColumns,

													entityColorSet: widget.colorSet,
													entityFontSet: widget.fontSet,
													generationAndResponseFontSet: widget.nameFont,
													hexagramColor: widget.themeColor,
													highlightColor: widget.highlightColor,
													activatedColor: widget.activatedColor,
													onlyHighlightChangingLines: widget.analysisOnlyHighlightChagingLines,
												)
											)
										),
									)
								],
							),
						),
					);
				}
			}
		);
		
	}
}