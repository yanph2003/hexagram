import '../utils.dart';
import 'trigrams.dart';
import 'branches.dart';
import 'stems.dart';
import 'relations.dart';
import 'deities.dart';

enum Hexagram
{
	kunWeiDi,
	diLeiFu,
	diShuiShi,
	diZeLin,
	diShanQian,
	diHuoMingyi,
	diFengSheng,
	diTianTai,
	leiDiYu,
	zhenWeiLei,
	leiShuiJie,
	leiZeGuimei,
	leiShanXiaoguo,
	leiHuoFeng,
	leiFengHeng,
	leiTianDazhuang,
	shuiDiBi,
	shuiLeiZhun,
	kanWeiShui,
	shuiZeJie,
	shuiShanJian,
	shuiHuoJiji,
	shuiFengJing,
	shuiTianXu,
	zeDiCui,
	zeLeiSui,
	zeShuiKun,
	duiWeiZe,
	zeShanXian,
	zeHuoGe,
	zeFengDaguo,
	zeTianGuai,
	shanDiBo,
	shanLeiYi,
	shanShuiMeng,
	shanZeSun,
	genWeiShan,
	shanHuoBi,
	shanFengGu,
	shanTianDaxu,
	huoDiJin,
	huoLeiShike,
	huoShuiWeiji,
	huoZeKui,
	huoShanLyu,
	liWeiHuo,
	huoFengDing,
	huoTianDayou,
	fengDiGuan,
	fengLeiYi,
	fengShuiHuan,
	fengZeZhongfu,
	fengShanJian,
	fengHuoJiaren,
	xunWeiFeng,
	fengTianXiaoxu,
	tianDiPi,
	tianLeiWuwang,
	tianShuiSong,
	tianZeLyu,
	tianShanDun,
	tianHuoTongren,
	tianFengGou,
	qianWeiTian;

	Trigram get inner => Trigram.fromHexagramNoAsInner(index);
	Trigram get outer => Trigram.fromHexagramNoAsOuter(index);
	List<bool> get lines => inner.lines + outer.lines;

	@override
	String toString() => Config.readList("hexagrams_to_string", index);
	String get fullName => (inner == outer)
		? "$inner为${inner.image}"
		: "${outer.image}${inner.image}$this";

	factory Hexagram.from(int y) => values[y.positiveMod(64)];
	factory Hexagram.fromTrigrams(Trigram upper, Trigram lower)
		=> Hexagram.from(lower.index + (upper.index << 3));
	factory Hexagram.fromLines(List<bool> y) => Hexagram.from(y.toInt().positiveMod(64));
	
	Hexagram get reversed => Hexagram.fromLines(lines.reversed.toList());
	Hexagram get complementary => Hexagram.from(index ^ 63);
	Hexagram get mutual => Hexagram.fromLines(lines.sublist(1, 4) + lines.sublist(2, 5));
	Hexagram change(Set<int> changed)
	{
		var res = index;
		for (var x in changed)
		{
			res ^= (1 << x);
		}
		return Hexagram.from(res);
	}

	Trigram get palace => (List.filled(4, outer) + List.filled(3, inner.complementary) + [inner])[[0,1,7,2,5,6,4,3][inner.index ^ outer.index]];
	int get generation => [6, 1, 3, 2, 5, 4, 4, 3][inner.index ^ outer.index] - 1;
	int get response => (generation + 3).positiveMod(6);
	String get position => ["本宫", "一世", "归魂", "二世", "五世", "游魂", "四世", "三世"][inner.index ^ outer.index];

	List<Branch> getBranches()
	{
		List<Branch> startingPoints = [8, 1, 3, 6, 5, 4, 2, 1].map((e) => Branch.from(e-1)).toList();
		Branch innerStart = startingPoints[inner.index];
		Branch outerStart = startingPoints[outer.index];
		return
		[
			innerStart, 
			innerStart + 2 * (inner.isYang ? 1 : -1),
			innerStart + 4 * (inner.isYang ? 1 : -1),
			outerStart + 6 * (outer.isYang ? 1 : -1), 
			outerStart + 8 * (outer.isYang ? 1 : -1),
			outerStart + 10 * (outer.isYang ? 1 : -1),
		];
	}

	List<Relation> getRelations({Trigram? fromPalace})
		=> getBranches().map((e) => (fromPalace ?? palace).relate(e)).toList();

	List<Stem> getStems()
		=> List.filled(3, [2, 7, 5, 4, 3, 6, 8, 1].map((e) => Stem.from(e-1)).toList()[inner.index])
		+ List.filled(3, [10, 7, 5, 4, 3, 6, 8, 9].map((e) => Stem.from(e-1)).toList()[outer.index]);

	List<Deity> getDeities(Stem dayStem)
		=> Deity.cyclic(
			switch (dayStem)
			{
				Stem.jia || Stem.yi => 0,
				Stem.bing || Stem.ding => 1,
				Stem.wu => 2,
				Stem.ji => 3,
				Stem.geng || Stem.xin =>  4,
				Stem.ren || Stem.gui => 5,
			}
		);
}
