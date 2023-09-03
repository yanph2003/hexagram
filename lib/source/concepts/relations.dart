import '../utils.dart';

enum Relation
{
	identical, promoting, regulating, counteracting, weakening;
	
	@override
	String toString() => Config.readList("relations_to_string", index);
	String toAbbr() => Config.readList("relations_to_string_abbr", index);

	Relation relate(Relation x) => values[(x.index - index).positiveMod(5)];
	Relation whoIs(Relation x) => values[(index + x.index).positiveMod(5)];
}

enum PreciseRelation
{
	identicalSame(Relation.identical, false),
	identicalDifferent(Relation.identical, true),
	promotingSame(Relation.promoting, false),
	promotingDifferent(Relation.promoting, true),
	regulatingSame(Relation.regulating, false),
	regulatingDifferent(Relation.regulating, true),
	counteractingSame(Relation.counteracting, false),
	counteractingDifferent(Relation.counteracting, true),
	weakeningSame(Relation.weakening, false),
	weakeningDifferent(Relation.weakening, true);

	final Relation relation;
	final bool isDifferent;

	const PreciseRelation(this.relation, this.isDifferent);
	factory PreciseRelation.from(relation, isDifferent) 
		=> values[relation.index * 2 + (isDifferent ? 1 : 0)];

	PreciseRelation relate(PreciseRelation x)
		=> PreciseRelation.from(relation.relate(x.relation), isDifferent ^ x.isDifferent);
	PreciseRelation whoIs(PreciseRelation x)
		=> PreciseRelation.from(relation.whoIs(x.relation), isDifferent ^ x.isDifferent);
		
	@override
	String toString() => Config.readList("precise_relations_to_string", index);
	String toAbbr() => Config.readList("precise_relations_to_string_abbr", index);
}
