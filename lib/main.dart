// ignore_for_file: unused_import, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'dart:ffi';

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
		return RecordListRoute();
	}
}

class FileList extends StatefulWidget
{
	const FileList({super.key, required this.catalogTitle});

	final String catalogTitle;

	@override
	State<FileList> createState() => _FileListState();
}

class _FileListState extends State<FileList>
{
	List<String> items = [];
	late File file;

	Future<File> openCatalog() async
	{
		return File(
			"${(await getApplicationDocumentsDirectory()).path}/${widget.catalogTitle}"
		);
	}

	void init() async
	{
		file = await openCatalog();
		items = await file.readAsLines();
		setState(() {});
	}

	@override
	void initState()
	{
		init();
		super.initState();
	}

	@override
	Widget build(context)
	{
		return Scaffold(
			appBar: AppBar(
				title: Text("Files"),
				actions: [
					IconButton(
						onPressed: () async
						{
							String? newName = await showDialog<String>(
								barrierDismissible: false,
								context: context,
								builder: (context)
								{
									return AlertDialog(
										content: TextField(
											controller: TextEditingController(),
											decoration: InputDecoration(
												label: Text("New Name"),
											),
											onSubmitted: (value){
												Navigator.pop(context, value);
											},
										)
									);
								}
							);
							if (newName != null)
							{
								setState(() {
									items.add(newName);
									print(items);
								});
							}
						}, 
						icon: Icon(Icons.add),
					),
					IconButton(
						onPressed: () async
						{
							await file.writeAsString(items.join("\n"));
							while (!context.mounted){}
							if (context.mounted)
							{
								ScaffoldMessenger.of(context)
									..removeCurrentSnackBar()
									..showSnackBar(SnackBar(content: Text("保存成功")));
							}
						}, 
						icon: Icon(Icons.save)
					),
				],
			),
			body: ListView.separated(
				itemCount: items.length,
				separatorBuilder: (context, index) => Divider(color: Colors.grey.shade300),
				itemBuilder: (context, index)
				{
					Widget content = Center(
							child: Text("#$index: ${items[index]}", style: TextStyle(fontSize: 20)),
						);
					return SizedBox(width: double.infinity, height: 100,
						child: Slidable(
						endActionPane: ActionPane(
							motion: BehindMotion(),
							children: [
								SlidableAction(
									backgroundColor: Colors.red,
									foregroundColor: Colors.white,
									label: "delete",
									icon: Icons.delete,
									onPressed: (context)
									{
										setState(() {
											items.removeAt(index);
										});
									},
								)
							],
						),
						child: content,
					));
				},
			),
		);
	}
}