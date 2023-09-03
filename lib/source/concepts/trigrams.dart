import '../utils.dart';
import 'relatables.dart';

enum Trigram with Relatable, Precise
{
	kun(Agent.earth, false),
	zhen(Agent.wood, true),
	kan(Agent.water, true),
	dui(Agent.metal, false),
	gen(Agent.earth, true),
	li(Agent.fire, false),
	xun(Agent.wood, false),
	qian(Agent.metal, true);
	

	@override final Agent agent;
	@override final bool isYang;
	const Trigram(this.agent, this.isYang);

	@override
	String toString() => Config.readList("trigrams_to_string", index);
	String get image => Config.readList("trigram_images_to_string", index);
	String get char => switch (this)
	{
		qian => "\u2630",
		dui => "\u2631",
		li => "\u2632",
		zhen => "\u2633",
		xun => "\u2634",
		kan => "\u2635",
		gen => "\u2636",
		kun => "\u2637",
	};

	List<bool> get lines => [(index & 1).toBool(), (index & 2).toBool(), (index & 4).toBool()];
	Trigram get complementary => Trigram.from(index ^ 7);

	factory Trigram.from(int y) => values[y.positiveMod(8)];
	factory Trigram.fromLines(List<bool> y) => values[y.toInt().positiveMod(8)];
	factory Trigram.fromHexagramNoAsInner(int y) => values[y.positiveMod(8)];
	factory Trigram.fromHexagramNoAsOuter(int y) => values[y.positiveMod(64)>>3];
}