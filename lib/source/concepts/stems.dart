import '../utils.dart';
import 'relatables.dart';

enum Stem with Relatable, Precise
{
	jia(Agent.wood, true),
	yi(Agent.wood, false),
	bing(Agent.fire, true),
	ding(Agent.fire, false),
	wu(Agent.earth, true),
	ji(Agent.earth, false),
	geng(Agent.metal, true),
	xin(Agent.metal, false),
	ren(Agent.water, true),
	gui(Agent.water, false);

	@override final Agent agent;
	@override final bool isYang;
	const Stem(this.agent, this.isYang);

	@override
	String toString() => Config.readList("stems_to_string", index);
	String toChar() => "甲乙丙丁戊己庚辛壬癸".split('').toList()[index];

	factory Stem.fromChar(String x)
	{
		if ("甲乙丙丁戊己庚辛壬癸".split('').toList().contains(x))
		{
			if(x == '甲') return jia;
			if(x == '乙') return yi;
			if(x == '丙') return bing;
			if(x == '丁') return ding;
			if(x == '戊') return wu;
			if(x == '己') return ji;
			if(x == '庚') return geng;
			if(x == '辛') return xin;
			if(x == '壬') return ren;
			if(x == '癸') return gui;
		}
		throw UnsupportedError("UnknownStem");
	}

	factory Stem.fromString(String x)
	{
		var toStr = Config.read("stems_to_string") as List;
		for (var i = 0; i < 10; ++i)
		{
			if (toStr[i] == x)
			{
				return Stem.from(i);
			}
		}
		throw UnsupportedError("UnknownStem");
	}

	factory Stem.from(int x) => values[x.positiveMod(10)];

	Stem operator +(int x) => values[(index + x).positiveMod(10)];
	operator -(x)
	{
		switch (x)
		{
			case int(): return this + (-x);
			case Stem(): return (index - x.index).positiveMod(10);
		}
		throw UnsupportedError("InvalidUseOfMinus");
	}
}