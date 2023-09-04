// ignore_for_file: unused_import, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:flutter/material.dart';

import 'source/utils.dart';
import 'source/concepts.dart';
import 'source/widgets.dart';
import 'source/routes.dart';

void main()
{
	runApp(const MainApp());
}

class MainApp extends StatelessWidget {
	const MainApp({super.key});
	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			theme: ThemeData(
				primarySwatch: Colors.blue,
				fontFamilyFallback: ["等线"]
			),
			title: "HEXAGRAM",
			initialRoute: "home",
			routes: {
				"home": (context) => HomePage(title: "HEXAGRAM"),
			},
		);
	}
}

class HomePage extends StatelessWidget
{
	final String title;
	const HomePage({super.key, required this.title});
	final Hexagram hex = Hexagram.leiShanXiaoguo;
	final changing = const <int>{0, 1, 2};

	@override
	Widget build(BuildContext context)
	{
		return HexagramAnalysisRoute();
		// return Scaffold(
		// 	body: ConstrainedBox(
		// 		constraints: BoxConstraints(
		// 			maxHeight: double.infinity,
		// 			maxWidth: double.infinity
		// 		),
		// 		child: MainInfoDisplay(
		// 			useEdit: true,
		// 			problem: "什么时候俄乌冲突可以停止？",
		// 			hexagram: hex,
		// 			changingLines: changing,
		// 			stems: [null, Stem.ding, Stem.bing, Stem.xin],
		// 			branches: [Branch.zi, Branch.chou, Branch.yin, Branch.mao],
		// 			stemsActions: (x) => (){},
		// 			branchesActions: (x) => (){},
		// 			nowAction: (){},
		// 			fromDateTimeAction: (){},
		// 			useFullPillars: true,
		// 			// useStems: true,
		// 			dateTimeCommentAction: (){},
		// 			problemController: TextEditingController(text: "什么时候俄乌冲突可以停止？"),
		// 		),
		// 	)
		// );
		
			// MainAnalysisDisplay(
			// 	columns: {
			// 		// MainAnalysisColumnType.deities,
			// 		// MainAnalysisColumnType.stems,
			// 		MainAnalysisColumnType.relations,
			// 		MainAnalysisColumnType.branches,
			// 		MainAnalysisColumnType.generationAndResponse,
			// 		MainAnalysisColumnType.changed,
			// 	},
			// 	hexagram: hex,
			// 	changingLines: changing,
			// 	dayStem: Stem.bing,
				
			// 	highlightColor: Colors.black.withOpacity(.5),
				
			// 	activatedColor: Colors.red.shade300.withAlpha(0x30),
			// 	deitiesActions: (x) => (){print("deity $x");},
			// 	stemsActions: (x) => (){print("stem $x");},
			// 	relationsActions: (x) => (){print("rel $x");},
			// 	branchesActions: (x) => (){print("br $x");},
			// 	mainHexagramActions: (x) => (){print("line $x");},
			// 	changingMarksActions: (x) => changing.contains(x) ? (){print("mark $x");} : null,
			// 	responseAction: (){print("res");},
			// 	generationAction: (){print("gen");},
			// 	changedActions:(x) => (){print("change $x");},
			// 	changedRelationsActions: (x) => (){print("cRel $x");},
			// 	changedBranchesActions: (x) => (){print("cBr $x");},
			// )
		// );
	}
}

class TestWidget extends StatefulWidget
{
	const TestWidget({super.key, required this.hex});

	final Hexagram hex;

	@override
	State<TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget>
{
	late Hexagram hex;
	Set<int> change = {};

	@override
	void initState()
	{
		hex = widget.hex;
		super.initState();
	}

	void Function() actionUp(Trigram tri)
	{
		return (){
			setState(
				()
				{
					hex = Hexagram.fromTrigrams(tri, hex.inner);
				}
			);
		};
	}

	void Function() actionDown(Trigram tri)
	{
		return (){
			setState(
				()
				{
					hex = Hexagram.fromTrigrams(hex.outer, tri);
				}
			);
		};
	}

	void Function() actionLines(int index)
	{
		return (){
			setState(() {
				hex = hex.change({index});
			});
		};
	}

	void Function() actionMarks(int index)
	{
		return (){
			setState(() {
				if (change.contains(index))
				{
					change.remove(index);
				}
				else
				{
					change.add(index);
				}
			});
		};
	}

	@override
	Widget build(BuildContext context)
	{
		return MainEditorDisplay(
			hexagram: hex,
			changingLines: change,
			upperSelectorActions: actionUp,
			lowerSelectorActions: actionDown,
			linesActions: actionLines,
			changingMarksActions: actionMarks,
		);
	}
}