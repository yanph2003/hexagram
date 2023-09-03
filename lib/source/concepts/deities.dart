import '../utils.dart';
import 'relatables.dart';

enum Deity with Relatable
{
	qinglong(Agent.wood),
	zhuque(Agent.fire),
	gouchen(Agent.earth),
	tengshe(Agent.earth),
	baihu(Agent.metal),
	xuanwu(Agent.water);

	@override final Agent agent;
	const Deity(this.agent);

	@override
	String toString() => Config.readList("deities_to_string", index);

	static List<Deity> cyclic(int offset)
		=> values.sublist(offset.positiveMod(6)) + values.sublist(0, offset.positiveMod(6));
}