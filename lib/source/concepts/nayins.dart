import '../utils.dart';
import 'relatables.dart';

enum Nayin with Relatable
{
	haizhongJin(Agent.metal),
	luzhongHuo(Agent.fire),
	dalinMu(Agent.wood),
	lupangTu(Agent.earth),
	jianfengJin(Agent.metal),
	shantouHuo(Agent.fire),
	jianxiaShui(Agent.water),
	chengtouTu(Agent.earth),
	bailaJin(Agent.metal),
	yangliuMu(Agent.wood),
	jingquanShui(Agent.water),
	wushangTu(Agent.earth),
	piliHuo(Agent.fire),
	songbaiMu(Agent.wood),
	changliuShui(Agent.water),
	shazhongJin(Agent.metal),
	shanxiaHuo(Agent.fire),
	pingdiMu(Agent.wood),
	bishangTu(Agent.earth),
	jinboJin(Agent.metal),
	fudengHuo(Agent.fire),
	tianheShui(Agent.water),
	dayiTu(Agent.earth),
	chaichuanJin(Agent.metal),
	sangzheMu(Agent.wood),
	daxiShui(Agent.water),
	shazhongTu(Agent.earth),
	tianshangHuo(Agent.fire),
	shiliuMu(Agent.wood),
	dahaiShui(Agent.water);

	@override final Agent agent;
	const Nayin(this.agent);

	@override
	String toString() => Config.readList("nayins_to_string", index);

	factory Nayin.from(int x) => values[x.positiveMod(30)];
}