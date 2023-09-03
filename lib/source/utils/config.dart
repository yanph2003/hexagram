final class Config 
{
	static final Map<String, dynamic> _initialPreferences = 
	{
		"relations_to_string": 
			"兄弟 子孙 妻财 官鬼 父母".split(' ').toList(),
		"relations_to_string_abbr":
			"比 食 财 官 印".split(' '),
		"precise_relations_to_string": 
			"比肩 劫财 食神 伤官 偏财 正财 偏官 正官 偏印 正印".split(' ').toList(),
		"precise_relations_to_string_abbr": 
			"比 劫 食 伤 财 才 杀 官 枭 印".split(' ').toList(),
		"agents_to_string": 
			"木 火 土 金 水".split(' ').toList(),
		"stems_to_string": 
			"甲 乙 丙 丁 戊 己 庚 辛 壬 癸".split(' ').toList(),
		"branches_to_string": 
			"子 丑 寅 卯 辰 巳 午 未 申 酉 戌 亥".split(' ').toList(),
		"trigrams_to_string": 
			"坤 震 坎 兑 艮 离 巽 乾".split(' ').toList(),
		"trigram_images_to_string": 
			"地 雷 水 泽 山 火 风 天".split(' ').toList(),
		"hexagrams_to_string":
			"坤 复 师 临 谦 明夷 升 泰 豫 震 解 归妹 小过 丰 恒 大壮 比 屯 坎 节 蹇 既济 井 需 萃 随 困 兑 咸 革 大过 夬 剥 颐 蒙 损 艮 贲 蛊 大畜 晋 噬嗑 未济 睽 旅 离 鼎 大有 观 益 涣 中孚 渐 家人 巽 小畜 否 无妄 讼 履 遁 同人 姤 乾".split(' ').toList(),
		"nayins_to_string":
			"海中金 炉中火 大林木 路旁土 剑锋金 山头火 涧下水 城头土 白腊金 杨柳木 井泉水 屋上土 霹雳火 松柏木 长流水 砂中金 山下火 平地木 壁上土 金箔金 覆灯火 天河水 大驿土 钗钏金 桑柘木 大溪水 砂中土 天上火 石榴木 大海水".split(' ').toList(),
		"deities_to_string":
			"青龙 朱雀 勾陈 螣蛇 白虎 玄武".split(' ').toList(),
		"hidden_stems": 
			"癸 己癸辛 甲丙戊 乙 戊乙癸 丙庚戊 丁己 己丁乙 庚壬戊 辛 戊辛丁 壬甲".split(' ').toList(),
	};

	static Map<String, dynamic> _currentPreferences = _initialPreferences;

	static read(String key) => _currentPreferences[key];

	static readList(String key, int index) => (_currentPreferences[key] as List)[index];

	static void reset()
	{
		_currentPreferences = _initialPreferences;
	}
}