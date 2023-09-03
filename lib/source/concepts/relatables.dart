import 'agents.dart';
import 'relations.dart';

export 'agents.dart';

mixin Relatable
{
	Agent get agent;
	Relation relate(Relatable x) => agent.relate(x.agent);
}

mixin Precise on Relatable
{
	bool get isYang;
	PreciseRelation preciseRelate(Precise x) => PreciseRelation.from(relate(x), isYang ^ x.isYang);
}