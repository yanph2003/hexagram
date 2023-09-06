// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';

import '../json/hexagram_record.dart';
import 'hexagram/hexagram_display.dart';

class BriefHexagramRecordCard extends StatelessWidget
{
	const BriefHexagramRecordCard({super.key, required this.record, this.mainFont = const ["微软雅黑"]});

	final BriefHexagramRecord record;
	final List<String> mainFont;

	@override
	Widget build(BuildContext context)
	{
		return LayoutBuilder(
			builder: (context, constraints)
			{
				double fontSize = min(constraints.maxWidth / 18, constraints.maxHeight / 6.5);
				double largerFontSize = fontSize * 1.2;
				return SizedBox.expand(
					child: Center(
						child: Text.rich(
							textAlign: TextAlign.center,
							TextSpan(
								children: [
									TextSpan(
										style: TextStyle(fontFamilyFallback: mainFont),
										children: [
											TextSpan(
												text: "${record.month}月${record.day}日　",
												style: TextStyle(fontSize: largerFontSize), 
											),
											TextSpan(
												text: "${record.hexagram}(",
												style: TextStyle(fontSize: largerFontSize), 
											),
											WidgetSpan(
												child: SizedBox(
													width: largerFontSize,
													height: largerFontSize,
													child: HexagramDisplay(hexagram: record.hexagram),
												)
											),
											TextSpan(
												text: ")",
												style: TextStyle(fontSize: largerFontSize), 
											),
											if (record.changingLines.isNotEmpty)
											TextSpan(
												children: [
													TextSpan(
														text: "之",
														style: TextStyle(fontSize: largerFontSize), 
													),
													TextSpan(
														text: "${record.hexagram.change(record.changingLines)}(",
														style: TextStyle(fontSize: largerFontSize), 
													),
													WidgetSpan(
														child: SizedBox(
															width: largerFontSize,
															height: largerFontSize,
															child: HexagramDisplay(hexagram: record.hexagram),
														)
													),
													TextSpan(
														text: ")",
														style: TextStyle(fontSize: largerFontSize), 
													),
												]
											),
										]
									),
									TextSpan(
										text: "\n\n",
										style: TextStyle(fontSize: fontSize * .5),
									),
									WidgetSpan(
										child: Row(
											mainAxisAlignment: MainAxisAlignment.center,
											children: [
												Spacer(),
												Expanded(
													flex: 10,
													child: Text(
														record.problem, 
														style: TextStyle(fontSize: fontSize, fontFamilyFallback: mainFont),
														maxLines: 2,
														overflow: TextOverflow.ellipsis,
														textAlign: TextAlign.center,
													),
												),
												Spacer(),
											],
										),	
									),
								]
							)
						),
					),
				);
			}
		);
	}
}