import '../utils.dart';
import 'relatables.dart';
import 'stems.dart';

enum Branch with Relatable, Precise
{
	zi(Agent.water, true),
	chou(Agent.earth, false),
	yin(Agent.wood, true),
	mao(Agent.wood, false),
	chen(Agent.earth, true),
	si(Agent.fire, false),
	wu(Agent.fire, true),
	wei(Agent.earth, false),
	shen(Agent.metal, true),
	you(Agent.metal, false),
	xu(Agent.earth, true),
	hai(Agent.water, false);

	@override final Agent agent;
	@override final bool isYang;
	const Branch(this.agent, this.isYang);

	@override
	String toString() => Config.readList("branches_to_string", index);
	String toChar() => "子丑寅卯辰巳午未申酉戌亥".split('').toList()[index];

	factory Branch.fromChar(String x)
	{
		if ("子丑寅卯辰巳午未申酉戌亥".split('').toList().contains(x))
		{
			if(x == '子') return zi;
			if(x == '丑') return chou;
			if(x == '寅') return yin;
			if(x == '卯') return mao;
			if(x == '辰') return chen;
			if(x == '巳') return si;
			if(x == '午') return wu;
			if(x == '未') return wei;
			if(x == '申') return shen;
			if(x == '酉') return you;
			if(x == '戌') return xu;
			if(x == '亥') return hai;
		}
		throw UnsupportedError("UnknownBranch");
	}

	factory Branch.fromString(String x)
	{
		var toStr = Config.read("branches_to_string") as List;
		for (var i = 0; i < 12; ++i)
		{
			if (toStr[i] == x)
			{
				return Branch.from(i);
			}
		}
		throw UnsupportedError("UnknownStem");
	}

	factory Branch.from(int x) => values[x.positiveMod(12)];

	Branch operator +(int x) => values[(index + x).positiveMod(12)];
	operator -(x)
	{
		switch (x)
		{
			case int(): return this + (-x);
			case Branch(): return (index - x.index).positiveMod(12);
		}
		throw UnsupportedError("InvalidUseOfMinus");
	}

	List<Stem> get hidden
		=> (Config.readList("hidden_stems", index) as String)
			.split('')
			.map((e) => Stem.fromChar(e)).toList();
	Stem get main => hidden[0];
	Stem? get mid => hidden.length < 2 ? null : hidden[1];
	Stem? get sub => hidden.length < 3 ? null : hidden[2];
}