// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hexagram/source/utils/extensions.dart';
import 'package:hexagram/source/widgets/hexagram/changing_lines_display.dart';
import 'package:hexagram/source/widgets/entity_column.dart';
import 'package:hexagram/source/widgets/hexagram/hexagram_display.dart';
import '../../concepts/hexagrams.dart';
import '../../concepts/agents.dart';
import '../../concepts/stems.dart';
import '../../icons/icomoon_free.dart';

enum MainAnalysisColumnType
{
	main(15),
	deities(4),
	stems(4),
	relations(4),
	branches(4),
	generationAndResponse(4),
	changed(12);

	const MainAnalysisColumnType(this.flex);
	final int flex;

	static int get fullVerFlex
	{
		int flex = 0;
		for (var x in MainAnalysisColumnType.values)
		{
			if(x == changed) continue;
			flex += x.flex;
		}
		return flex;
	}

	static int get fullHorFlex
	{
		return fullVerFlex + 6 + changed.flex + branches.flex + relations.flex;
	}
}

class MainAnalysisDisplay extends StatelessWidget
{
	const MainAnalysisDisplay({
		super.key,
		Set<MainAnalysisColumnType> columns =
		const {
			MainAnalysisColumnType.relations,
			MainAnalysisColumnType.branches,
			MainAnalysisColumnType.generationAndResponse,
			MainAnalysisColumnType.changed,
		},
		required Hexagram hexagram,
		required Set<int> changingLines,
		Stem? dayStem,
		Map<Agent?, Color> entityColorSet = 
		const {
			Agent.wood: Colors.green,
			Agent.fire: Colors.red,
			Agent.earth: Colors.brown,
			Agent.metal: Color.fromARGB(255, 255, 179, 0),
			Agent.water: Colors.blue,
			null: Colors.black,
		},
		Map<bool?, List<String>> entityFontSet = 
		const {
			true: ["Simsun"],
			false: ["Simhei"],
			null: ["Simhei"],
		},
		List<String> generationAndResponseFontSet = const ["楷体"],
		Color activatedColor = const Color(0x30EEEEEE),
		Color hexagramColor = Colors.black,
		Color? highlightColor,
		bool onlyHighlightChangingLines = false,

		void Function()? Function(int)? deitiesActions,
		void Function()? Function(int)? stemsActions,
		void Function()? Function(int)? relationsActions,
		void Function()? Function(int)? branchesActions,
		void Function()? Function(int)? mainHexagramActions,
		void Function()? Function(int)? changingMarksActions,
		void Function()? generationAction,
		void Function()? responseAction,
		void Function()? Function(int)? changedActions,
		void Function()? Function(int)? changedBranchesActions,
		void Function()? Function(int)? changedRelationsActions,
	}):
		_columns = columns,
		_hexagram = hexagram,
		_changingLines = changingLines,
		_dayStem = dayStem,
		_entityColorSet = entityColorSet,
		_entityFontSet = entityFontSet,
		_generationAndResponseFontSet = generationAndResponseFontSet,
		_activatedColor = activatedColor,
		_hexagramColor = hexagramColor,
		_highlightColor = highlightColor,
		_highlightChangingLines = highlightColor != null,

		_deitiesActions = deitiesActions,
		_stemsActions = stemsActions,
		_relationsActions = relationsActions,
		_branchesActions = branchesActions,
		_mainHexagramActions = mainHexagramActions,
		_changingMarksActions = changingMarksActions,
		_generationAction = generationAction,
		_responseAction = responseAction,
		_changedActions = changedActions,
		_changedBranchesActions = changedBranchesActions,
		_changedRelationsActions = changedRelationsActions,
		_onlyHighlightChangingLines = onlyHighlightChangingLines;

	final Set<MainAnalysisColumnType> _columns;

	final Hexagram _hexagram;
	final Set<int> _changingLines;
	final Stem? _dayStem;

	final Map<Agent?, Color> _entityColorSet;
	final Map<bool?, List<String>> _entityFontSet;
	final List<String> _generationAndResponseFontSet;
	final Color _activatedColor;
	final Color _hexagramColor;
	final Color? _highlightColor;
	final bool _highlightChangingLines;
	final bool _onlyHighlightChangingLines;

	final void Function()? Function(int)? _deitiesActions;
	final void Function()? Function(int)? _stemsActions;
	final void Function()? Function(int)? _relationsActions;
	final void Function()? Function(int)? _branchesActions;
	final void Function()? Function(int)? _mainHexagramActions;
	final void Function()? Function(int)? _changingMarksActions;
	final void Function()? _generationAction;
	final void Function()? _responseAction;
	final void Function()? Function(int)? _changedActions;
	final void Function()? Function(int)? _changedBranchesActions;
	final void Function()? Function(int)? _changedRelationsActions;

	@override
	Widget build(BuildContext context)
	{
		return LayoutBuilder(
			builder: (context, constraints) {
				const Size pressed = Size(.8, .6);
				final double superAspectRatio = constraints.maxWidth / constraints.maxHeight;
				int selectedFlex = _changingLines.isEmpty 
					? MainAnalysisColumnType.changed.flex 
					: MainAnalysisColumnType.main.flex;
				for (var x in _columns)
				{
					if(x == MainAnalysisColumnType.changed) continue;
					selectedFlex += x.flex;
				}
				double maxRatioVer = selectedFlex / MainAnalysisColumnType.fullVerFlex;
				double minRatioVer = 0.5 * maxRatioVer;
				int expandedFlex = selectedFlex;
				if (_columns.contains(MainAnalysisColumnType.changed) && _changingLines.isNotEmpty)
				{
					expandedFlex += 6 + MainAnalysisColumnType.changed.flex;
					if (_columns.contains(MainAnalysisColumnType.relations))
					{
						expandedFlex +=  MainAnalysisColumnType.relations.flex;
					}
					if (_columns.contains(MainAnalysisColumnType.branches))
					{
						expandedFlex +=  MainAnalysisColumnType.branches.flex;
					}
				}
				double maxRatioHor = 3 * expandedFlex / MainAnalysisColumnType.fullHorFlex;
				double minRatioHor = 0.6 * maxRatioHor;

				bool useVer = superAspectRatio <= sqrt(minRatioHor * maxRatioVer)
					&& _columns.contains(MainAnalysisColumnType.changed) 
					&& _changingLines.isNotEmpty;

				List<Color>? changedColorList = _highlightChangingLines
					? [
						for (var i = 0; i < 6; ++i) (
						_changingLines.contains(i) 
							? _highlightColor! 
							: _hexagramColor
						)
					]
					: _onlyHighlightChangingLines
						? [
							for (var i = 0; i < 6; ++i) (
							_changingLines.contains(i) 
								? _hexagramColor
								: _hexagramColor.lighten(85)
							)
						]
						: null;
					
				double width = constraints.maxWidth;
				double height = constraints.maxHeight;
				if (useVer)
				{
					if (superAspectRatio < minRatioVer)
					{
						height = width / minRatioVer;
					}
					if (superAspectRatio > maxRatioVer)
					{
						width = height * maxRatioVer;
					}
					return Row(
						mainAxisAlignment: MainAxisAlignment.center,
						crossAxisAlignment: CrossAxisAlignment.start,
						children: [
							SizedBox(
								width: width,
								height: height,
								child: Column(
									children:[
										Expanded(
											flex: 100,
											child: Row(
												mainAxisAlignment: MainAxisAlignment.center,
												children: [
													if (_columns.contains(MainAnalysisColumnType.deities) && _dayStem != null)
													Expanded(
														flex: MainAnalysisColumnType.deities.flex,
														child: EntityColumn(
															entities: _hexagram.getDeities(_dayStem!),
															actions: _deitiesActions,
															colorSet: _entityColorSet,
															fontSet: _entityFontSet,
															activatedColor: _activatedColor,
															relativeEntitySize: pressed,
														),
													),
													if (_columns.contains(MainAnalysisColumnType.stems))
													Expanded(
														flex: MainAnalysisColumnType.stems.flex,
														child: EntityColumn(
															entities: _hexagram.getStems(),
															actions: _stemsActions,
															colorSet: _entityColorSet,
															fontSet: _entityFontSet,
															activatedColor: _activatedColor,
														),
													),
													if (_columns.contains(MainAnalysisColumnType.relations))
													Expanded(
														flex: MainAnalysisColumnType.relations.flex,
														child: EntityColumn(
															entities: _hexagram.getRelations(),
															actions: _relationsActions,
															colorSet: _entityColorSet,
															fontSet: _entityFontSet,
															activatedColor: _activatedColor,
															relativeEntitySize: pressed, 
														),
													),
													if (_columns.contains(MainAnalysisColumnType.branches))
													Expanded(
														flex: MainAnalysisColumnType.branches.flex,
														child: EntityColumn(
															entities: _hexagram.getBranches(),
															actions: _branchesActions,
															colorSet: _entityColorSet,
															fontSet: _entityFontSet,
															activatedColor: _activatedColor,
														),
													),
													Expanded(
														flex: MainAnalysisColumnType.changed.flex,
														child: HexagramDisplay(
															hexagram: _hexagram,
															actions: _mainHexagramActions,
															color: _hexagramColor,
															colorList: _highlightChangingLines
																? [
																	for (var i = 0; i < 6; ++i) (
																	_changingLines.contains(i) 
																		? _highlightColor! 
																		: _hexagramColor
																	)
																]
																: null,
															activatedColor: _activatedColor,
														)
													),
													if(_changingLines.isNotEmpty)
													Expanded(
														flex: MainAnalysisColumnType.main.flex - MainAnalysisColumnType.changed.flex,
														child: ChangingLinesDisplay(
															hexagram: _hexagram,
															changingLines: _changingLines,
															actions: _changingMarksActions,
															color: _highlightChangingLines
																? _highlightColor
																: _hexagramColor,
															activatedColor: _activatedColor,
														)
													),
													if (_columns.contains(MainAnalysisColumnType.generationAndResponse))
													Expanded(
														flex: MainAnalysisColumnType.generationAndResponse.flex,
														child: EntityColumn(
															entities: {
																_hexagram.generation: "世",
																_hexagram.response: "应",
															}.buildList(fill: "　", len: 6),
															actions: (int x)
															{
																if (x == _hexagram.generation)
																{
																	return _generationAction;
																}
																else if (x == _hexagram.response)
																{
																	return _responseAction;
																}
																else
																{
																	return null;
																}
															},
															colorSet: _entityColorSet,
															fontSet: {null: _generationAndResponseFontSet},
															activatedColor: _activatedColor,
														),
													),
												],
											)
										),
										if(_changingLines.isNotEmpty)
										Spacer(flex: 3),
										if(_changingLines.isNotEmpty) 
										Expanded(
											flex: 14,
											child: Row(
												mainAxisAlignment: MainAxisAlignment.center,
												children: [
													if (_columns.contains(MainAnalysisColumnType.deities) && _dayStem != null)
													Spacer(
														flex: MainAnalysisColumnType.deities.flex,
													),
													if (_columns.contains(MainAnalysisColumnType.stems))
													Spacer(
														flex: MainAnalysisColumnType.stems.flex,
													),
													if (_columns.contains(MainAnalysisColumnType.relations))
													Spacer(
														flex: MainAnalysisColumnType.relations.flex,
													),
													if (_columns.contains(MainAnalysisColumnType.branches))
													Spacer(
														flex: MainAnalysisColumnType.branches.flex,
													),
													Expanded(
														flex: MainAnalysisColumnType.changed.flex,
														child: FittedBox(
															fit: BoxFit.contain,
															child: Icon(
																IconIcomoonFree.thickArrowDown, 
																color: _hexagramColor.withOpacity(.5)
															),
														),
													),
													Spacer(
														flex: MainAnalysisColumnType.main.flex - MainAnalysisColumnType.changed.flex,
													),
													if (_columns.contains(MainAnalysisColumnType.generationAndResponse))
													Spacer(
														flex: MainAnalysisColumnType.generationAndResponse.flex,
													),
												],
											)
										),
										if(_changingLines.isNotEmpty) 
										Spacer(flex: 3),
										if(_changingLines.isNotEmpty)
										Expanded(
											flex: 100,
											child: Row(
												mainAxisAlignment: MainAxisAlignment.center,
												children: [
													if (_columns.contains(MainAnalysisColumnType.deities) && _dayStem != null)
													Spacer(
														flex: MainAnalysisColumnType.deities.flex,
													),
													if (_columns.contains(MainAnalysisColumnType.stems))
													Spacer(
														flex: MainAnalysisColumnType.stems.flex,
													),
													if (_columns.contains(MainAnalysisColumnType.relations))
													Expanded(
														flex: MainAnalysisColumnType.relations.flex,
														child: EntityColumn(
															entities: _hexagram.change(_changingLines).getRelations(
																fromPalace: _hexagram.palace,
															),
															actions: _changedRelationsActions,
															colorSet: _entityColorSet,
															fontSet: _entityFontSet,
															activatedColor: _activatedColor,
															relativeEntitySize: pressed,
														),
													),
													if (_columns.contains(MainAnalysisColumnType.branches))
													Expanded(
														flex: MainAnalysisColumnType.branches.flex,
														child: EntityColumn(
															entities: _hexagram.change(_changingLines).getBranches(),
															actions: _changedBranchesActions,
															colorSet: _entityColorSet,
															fontSet: _entityFontSet,
															activatedColor: _activatedColor,
														),
													),
													Expanded(
														flex: MainAnalysisColumnType.changed.flex,
														child: HexagramDisplay(
															hexagram: _hexagram.change(_changingLines),
															actions: _changedActions,
															color: _hexagramColor,
															colorList: changedColorList,
															activatedColor: _activatedColor,
														)
													),
													Spacer(
														flex: MainAnalysisColumnType.main.flex - MainAnalysisColumnType.changed.flex,
													),
													if (_columns.contains(MainAnalysisColumnType.generationAndResponse))
													Spacer(
														flex: MainAnalysisColumnType.generationAndResponse.flex,
													),
												],
											)
										),
									]
								),
							),
						]
					);
				}
				else
				{
					if (superAspectRatio < minRatioHor)
					{
						height = width / minRatioHor;
					}
					if (superAspectRatio > maxRatioHor)
					{
						width = height * maxRatioHor;
					}
					return Row(
						mainAxisAlignment: MainAxisAlignment.center,
						crossAxisAlignment: CrossAxisAlignment.start,
						children: [
							SizedBox(
								width: width,
								height: height,
								child: Row(
									mainAxisAlignment: MainAxisAlignment.center,
									children: [
										if (_columns.contains(MainAnalysisColumnType.deities) && _dayStem != null)
										Expanded(
											flex: MainAnalysisColumnType.deities.flex,
											child: EntityColumn(
												entities: _hexagram.getDeities(_dayStem!),
												actions: _deitiesActions,
												colorSet: _entityColorSet,
												fontSet: _entityFontSet,
												activatedColor: _activatedColor,
												relativeEntitySize: pressed,
											),
										),
										if (_columns.contains(MainAnalysisColumnType.stems))
										Expanded(
											flex: MainAnalysisColumnType.stems.flex,
											child: EntityColumn(
												entities: _hexagram.getStems(),
												actions: _stemsActions,
												colorSet: _entityColorSet,
												fontSet: _entityFontSet,
												activatedColor: _activatedColor,
											),
										),
										if (_columns.contains(MainAnalysisColumnType.relations))
										Expanded(
											flex: MainAnalysisColumnType.relations.flex,
											child: EntityColumn(
												entities: _hexagram.getRelations(),
												actions: _relationsActions,
												colorSet: _entityColorSet,
												fontSet: _entityFontSet,
												activatedColor: _activatedColor,
												relativeEntitySize: pressed,
											),
										),
										if (_columns.contains(MainAnalysisColumnType.branches))
										Expanded(
											flex: MainAnalysisColumnType.branches.flex,
											child: EntityColumn(
												entities: _hexagram.getBranches(),
												actions: _branchesActions,
												colorSet: _entityColorSet,
												fontSet: _entityFontSet,
												activatedColor: _activatedColor,
											),
										),
										Expanded(
											flex: MainAnalysisColumnType.changed.flex,
											child: HexagramDisplay(
												hexagram: _hexagram,
												actions: _mainHexagramActions,
												color: _hexagramColor,
												colorList: _highlightChangingLines
													? [
														for (var i = 0; i < 6; ++i) (
														_changingLines.contains(i) 
															? _highlightColor! 
															: _hexagramColor
														)
													]
													: null,
												activatedColor: _activatedColor,
											)
										),
										if(_changingLines.isNotEmpty)
										Expanded(
											flex: MainAnalysisColumnType.main.flex - MainAnalysisColumnType.changed.flex,
											child: ChangingLinesDisplay(
												hexagram: _hexagram,
												changingLines: _changingLines,
												actions: _changingMarksActions,
												color: _highlightChangingLines
													? _highlightColor
													: _hexagramColor,
												activatedColor: _activatedColor,
											)
										),
										if (_columns.contains(MainAnalysisColumnType.generationAndResponse))
										Expanded(
											flex: MainAnalysisColumnType.generationAndResponse.flex,
											child: EntityColumn(
												entities: {
													_hexagram.generation: "世",
													_hexagram.response: "应",
												}.buildList(fill: "　", len: 6),
												actions: (int x)
												{
													if (x == _hexagram.generation)
													{
														return _generationAction;
													}
													else if (x == _hexagram.response)
													{
														return _responseAction;
													}
													else
													{
														return null;
													}
												},
												colorSet: _entityColorSet,
												fontSet: {null: _generationAndResponseFontSet},
												activatedColor: _activatedColor,
											),
										),
										if (_changingLines.isNotEmpty && _columns.contains(MainAnalysisColumnType.changed)) 
										Spacer(flex: 1),
										if (_changingLines.isNotEmpty && _columns.contains(MainAnalysisColumnType.changed))
										Expanded(
											flex: 3,
											child: FittedBox(
												fit: BoxFit.contain,
												child: Icon(
													IconIcomoonFree.thickArrowRight,
													color: _hexagramColor.withOpacity(.5),
												),
											),
										),
										if (_changingLines.isNotEmpty && _columns.contains(MainAnalysisColumnType.changed))
										Spacer(flex: 2),
										if (_changingLines.isNotEmpty && _columns.contains(MainAnalysisColumnType.changed))
										Expanded(
											flex: MainAnalysisColumnType.changed.flex,
											child: HexagramDisplay(
												hexagram: _hexagram.change(_changingLines),
												actions: _changedActions,
												color: _hexagramColor,
												colorList: changedColorList,
												activatedColor: _activatedColor,
											)
										),
										if (_columns.contains(MainAnalysisColumnType.branches) && _changingLines.isNotEmpty  && _columns.contains(MainAnalysisColumnType.changed))
										Expanded(
											flex: MainAnalysisColumnType.branches.flex,
											child: EntityColumn(
												entities: _hexagram.change(_changingLines).getBranches(),
												actions: _changedBranchesActions,
												colorSet: _entityColorSet,
												fontSet: _entityFontSet,
												activatedColor: _activatedColor,
											),
										),
										if (_columns.contains(MainAnalysisColumnType.relations) && _changingLines.isNotEmpty && _columns.contains(MainAnalysisColumnType.changed))
										Expanded(
											flex: MainAnalysisColumnType.relations.flex,
											child: EntityColumn(
												entities: _hexagram.change(_changingLines).getRelations(
													fromPalace: _hexagram.palace,
												),
												actions: _changedRelationsActions,
												colorSet: _entityColorSet,
												fontSet: _entityFontSet,
												activatedColor: _activatedColor,
												relativeEntitySize: pressed,
											),
										),
									],
								),
							)
						],
					);
				}
			}
		);
	}
}