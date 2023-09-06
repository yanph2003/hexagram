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
