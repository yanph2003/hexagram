// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import '../json.dart';
import '../utils.dart';

import '../widgets/hexagram_record_card.dart';
import 'hexagram_analysis_route.dart';

class RecordListRoute extends StatefulWidget
{
	const RecordListRoute({
		super.key,
		this.mainFont = const ["微软雅黑"],
	});

	final List<String> mainFont;

	@override
	State<RecordListRoute> createState() => _RecordListRouteState();
}

class _RecordListRouteState extends State<RecordListRoute>
{
	List<({String uid, BriefHexagramRecord record})> records = [];
	Map<String, BriefHexagramRecord> catalog = {};
	late File catalogFile;
	String path = "";

	void Function() Function(HexagramRecord) getSaveAction(String uid)
	{
		return (HexagramRecord record)
		{
			return () async
			{
				File recordFile = await File("$path/hexagram/hexagram/records/$uid.txt").create(recursive: true);
				await recordFile.writeAsString(jsonEncode(record.toJson()));
				catalog[uid] = BriefHexagramRecord(
					month: record.branches[1]!,
					day: record.branches[2]!,
					problem: record.problem,
					hexagram: record.hexagram, 
					changingLines: record.changingLines
				);
				saveCatalog("保存成功");
				setState(() {});
			};
		};
	}
	
	void saveCatalog(String prompt) async
	{
		await catalogFile.writeAsString(jsonEncode(HexagramCatalog(catalog: catalog).toJson()));
		while (!context.mounted){}
		if (context.mounted)
		{
			ScaffoldMessenger.of(context)
				..removeCurrentSnackBar()
				..showSnackBar(SnackBar(content: Text(
					prompt, 
					textAlign: TextAlign.center,
					style: TextStyle(fontFamilyFallback: widget.mainFont),
				)));
		}
	}

	void initCatalog() async
	{
		path = (await getApplicationDocumentsDirectory()).path;
		catalogFile = await File(
			"$path/hexagram/hexagram/catalog.txt"
		).create(recursive: true);
		catalog = HexagramCatalog.fromJson(jsonDecode(await catalogFile.readAsString())).catalog;
		setState(() {});
	}

	@override
	void initState()
	{
		initCatalog();
		super.initState();
	}

	void buildRecords()
	{
		records = catalog.entries.map((e) => (uid: e.key, record: e.value)).toList();
	}

	void redirect(String uid, {bool edit = false}) async
	{
		File recordFile = await File("$path/hexagram/hexagram/records/$uid.txt").create(recursive: true);
		HexagramRecord record = HexagramRecord.fromJson(jsonDecode(await recordFile.readAsString()));
		while(!context.mounted){}
		if(context.mounted)
		{
			Navigator.push(context, MaterialPageRoute(
				builder: (context)
				{
					return HexagramAnalysisRoute(
						edit: edit,
						saveAction: getSaveAction(uid),
						hexagram: record.hexagram,
						changingLines: record.changingLines,
						stems: record.stems,
						branches: record.branches,
						problem: record.problem,
						dateTime: record.dateTime ?? List.filled(6, null),
						infoUseFullPillars: record.config?.useFullPillars ?? false,
						infoUseStems: record.config?.useStems ?? false,
					);
				}
			));
		}
	}

	String newUid()
	{
		return DateTime.now().toIso8601String().replaceAll(RegExp(r'[^0-9]'), "");
	}

	@override
	Widget build(BuildContext context)
	{	
		buildRecords();
		return Scaffold(
			appBar: AppBar(
				title: Text(
					"占卦记录", 
					style: TextStyle(fontFamilyFallback: widget.mainFont),
					textAlign: TextAlign.center,
				),
				actions: [
					// TODO: maybe there are some useful functions to add
				],
			),
			floatingActionButton: FloatingActionButton(
				onPressed: ()
				{
					Navigator.push(context, MaterialPageRoute(
						builder: (context)
						{
							return HexagramAnalysisRoute(
								edit: true,
								saveAction: getSaveAction(newUid()),
							);
						}
					));
				},
				child: Icon(Icons.add),
			),
			body: LayoutBuilder(
				builder: (context, constraints)
				{
					double width = min(1000, constraints.maxWidth);
					return Center(child:SizedBox(
						height: double.infinity,
						width: width,
						child: ListView.separated(
							itemCount: records.length,
							separatorBuilder: (context, index)
							{
								return Divider(color: Colors.grey, height: 0);
							},
							itemBuilder: (context, index)
							{
								return SizedBox(
									width: double.infinity,
									height: 100,
									child: Slidable(
										startActionPane: ActionPane(
											extentRatio: .3,
											motion: BehindMotion(),
											children: [
												SlidableAction(
													backgroundColor: Colors.green,
													foregroundColor: Colors.white,
													label: "编辑",
													icon: Icons.edit,
													onPressed: (context)
													{
														redirect(records[index].uid, edit: true);
													},
												)
											],
										),
										endActionPane: ActionPane(
											extentRatio: .3,
											motion: BehindMotion(),
											children: [
												SlidableAction(
													backgroundColor: Colors.red,
													foregroundColor: Colors.white,
													label: "删除",
													icon: Icons.delete,
													onPressed: (context) async
													{
														catalog.remove(records[index].uid);
														File toRemove = File("$path/hexagram/hexagram/records/${records[index].uid}.txt");
														if (toRemove.existsSync())
														{
															await toRemove.delete();
														}
														saveCatalog("删除成功");
														setState((){});
													},
												)
											],
										),
										child: GestureDetector(
											onTap: ()
											{
												redirect(records[index].uid);
											},
											child: Container(
												decoration: BoxDecoration(
													color: Color(0x00000000),
												),
												child: BriefHexagramRecordCard(
													record: records[index].record,
													mainFont: widget.mainFont,
												),
											),
										),
									),
								);
							},
						)
					));
				},
			),
		);
	}
}