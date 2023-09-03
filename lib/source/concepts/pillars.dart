import '../utils/extensions.dart';
import 'stems.dart';
import 'branches.dart';
import 'nayins.dart';
import 'relatables.dart';

class Pillar with Relatable, Precise
{
	final Stem stem;
	final Branch branch;
	Pillar(this.stem, this.branch)
	{
		if (stem.isYang != branch.isYang)
		{
			throw UnsupportedError("MixedYinyangPillar");
		}
	}

	Nayin get nayin => Nayin.from(index >> 1);

	@override Agent get agent => nayin.agent;
	@override bool get isYang => stem.isYang;
	
	@override
	String toString() => stem.toString() + branch.toString();

	Pillar.from(int index): 
		stem = Stem.from(index.positiveMod(10)), 
		branch = Branch.from(index.positiveMod(12));
	
	int get index => ((stem - (branch - Branch.zi)) - Stem.jia) * 6 + (branch - Branch.zi);
	
	Pillar operator +(int x) => Pillar(stem + x, branch + x);
	operator -(x)
	{
		switch (x)
		{
			case int(): return this + (-x);
			case Pillar(): return (index - x.index).positiveMod(60);
		}
		throw UnsupportedError("InvalidUseOfMinus");
	}
}
