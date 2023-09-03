import '../utils.dart';
import 'relations.dart';

enum Agent
{
	wood, fire, earth, metal, water;

	Relation relate(Agent x) => Relation.values[(x.index - index).positiveMod(5)];

	@override
	String toString() => Config.readList("agents_to_string", index);

	factory Agent.fromChar(String x)
	{
		if ("木火土金水".split('').toList().contains(x))
		{
			if(x == '木') return wood;
			if(x == '火') return fire;
			if(x == '土') return earth;
			if(x == '金') return metal;
			if(x == '水') return water;
		}
		throw UnsupportedError("UnknownAgent");
	}

	factory Agent.fromString(String x)
	{
		var toStr = Config.read("agents_to_string") as List;
		for (var i = 0; i < 5; ++i)
		{
			if (toStr[i] == x)
			{
				return values[i];
			}
		}
		throw UnsupportedError("UnknownStem");
	}
}


