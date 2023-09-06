// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hexagram_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BriefHexagramRecord _$BriefHexagramRecordFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const [
      'month',
      'day',
      'problem',
      'hexagram',
      'changing_lines'
    ],
  );
  return BriefHexagramRecord(
    month: $enumDecode(_$BranchEnumMap, json['month']),
    day: $enumDecode(_$BranchEnumMap, json['day']),
    problem: json['problem'] as String,
    hexagram: $enumDecode(_$HexagramEnumMap, json['hexagram']),
    changingLines:
        (json['changing_lines'] as List<dynamic>).map((e) => e as int).toSet(),
  );
}

Map<String, dynamic> _$BriefHexagramRecordToJson(
        BriefHexagramRecord instance) =>
    <String, dynamic>{
      'month': _$BranchEnumMap[instance.month]!,
      'day': _$BranchEnumMap[instance.day]!,
      'problem': instance.problem,
      'hexagram': _$HexagramEnumMap[instance.hexagram]!,
      'changing_lines': instance.changingLines.toList(),
    };

const _$BranchEnumMap = {
  Branch.zi: 'zi',
  Branch.chou: 'chou',
  Branch.yin: 'yin',
  Branch.mao: 'mao',
  Branch.chen: 'chen',
  Branch.si: 'si',
  Branch.wu: 'wu',
  Branch.wei: 'wei',
  Branch.shen: 'shen',
  Branch.you: 'you',
  Branch.xu: 'xu',
  Branch.hai: 'hai',
};

const _$HexagramEnumMap = {
  Hexagram.kunWeiDi: 'kunWeiDi',
  Hexagram.diLeiFu: 'diLeiFu',
  Hexagram.diShuiShi: 'diShuiShi',
  Hexagram.diZeLin: 'diZeLin',
  Hexagram.diShanQian: 'diShanQian',
  Hexagram.diHuoMingyi: 'diHuoMingyi',
  Hexagram.diFengSheng: 'diFengSheng',
  Hexagram.diTianTai: 'diTianTai',
  Hexagram.leiDiYu: 'leiDiYu',
  Hexagram.zhenWeiLei: 'zhenWeiLei',
  Hexagram.leiShuiJie: 'leiShuiJie',
  Hexagram.leiZeGuimei: 'leiZeGuimei',
  Hexagram.leiShanXiaoguo: 'leiShanXiaoguo',
  Hexagram.leiHuoFeng: 'leiHuoFeng',
  Hexagram.leiFengHeng: 'leiFengHeng',
  Hexagram.leiTianDazhuang: 'leiTianDazhuang',
  Hexagram.shuiDiBi: 'shuiDiBi',
  Hexagram.shuiLeiZhun: 'shuiLeiZhun',
  Hexagram.kanWeiShui: 'kanWeiShui',
  Hexagram.shuiZeJie: 'shuiZeJie',
  Hexagram.shuiShanJian: 'shuiShanJian',
  Hexagram.shuiHuoJiji: 'shuiHuoJiji',
  Hexagram.shuiFengJing: 'shuiFengJing',
  Hexagram.shuiTianXu: 'shuiTianXu',
  Hexagram.zeDiCui: 'zeDiCui',
  Hexagram.zeLeiSui: 'zeLeiSui',
  Hexagram.zeShuiKun: 'zeShuiKun',
  Hexagram.duiWeiZe: 'duiWeiZe',
  Hexagram.zeShanXian: 'zeShanXian',
  Hexagram.zeHuoGe: 'zeHuoGe',
  Hexagram.zeFengDaguo: 'zeFengDaguo',
  Hexagram.zeTianGuai: 'zeTianGuai',
  Hexagram.shanDiBo: 'shanDiBo',
  Hexagram.shanLeiYi: 'shanLeiYi',
  Hexagram.shanShuiMeng: 'shanShuiMeng',
  Hexagram.shanZeSun: 'shanZeSun',
  Hexagram.genWeiShan: 'genWeiShan',
  Hexagram.shanHuoBi: 'shanHuoBi',
  Hexagram.shanFengGu: 'shanFengGu',
  Hexagram.shanTianDaxu: 'shanTianDaxu',
  Hexagram.huoDiJin: 'huoDiJin',
  Hexagram.huoLeiShike: 'huoLeiShike',
  Hexagram.huoShuiWeiji: 'huoShuiWeiji',
  Hexagram.huoZeKui: 'huoZeKui',
  Hexagram.huoShanLyu: 'huoShanLyu',
  Hexagram.liWeiHuo: 'liWeiHuo',
  Hexagram.huoFengDing: 'huoFengDing',
  Hexagram.huoTianDayou: 'huoTianDayou',
  Hexagram.fengDiGuan: 'fengDiGuan',
  Hexagram.fengLeiYi: 'fengLeiYi',
  Hexagram.fengShuiHuan: 'fengShuiHuan',
  Hexagram.fengZeZhongfu: 'fengZeZhongfu',
  Hexagram.fengShanJian: 'fengShanJian',
  Hexagram.fengHuoJiaren: 'fengHuoJiaren',
  Hexagram.xunWeiFeng: 'xunWeiFeng',
  Hexagram.fengTianXiaoxu: 'fengTianXiaoxu',
  Hexagram.tianDiPi: 'tianDiPi',
  Hexagram.tianLeiWuwang: 'tianLeiWuwang',
  Hexagram.tianShuiSong: 'tianShuiSong',
  Hexagram.tianZeLyu: 'tianZeLyu',
  Hexagram.tianShanDun: 'tianShanDun',
  Hexagram.tianHuoTongren: 'tianHuoTongren',
  Hexagram.tianFengGou: 'tianFengGou',
  Hexagram.qianWeiTian: 'qianWeiTian',
};

HexagramRecordConfig _$HexagramRecordConfigFromJson(
        Map<String, dynamic> json) =>
    HexagramRecordConfig(
      useFullPillars: json['use_full_pillars'] as bool? ?? false,
      useStems: json['use_stems'] as bool? ?? false,
    );

Map<String, dynamic> _$HexagramRecordConfigToJson(
        HexagramRecordConfig instance) =>
    <String, dynamic>{
      'use_full_pillars': instance.useFullPillars,
      'use_stems': instance.useStems,
    };

HexagramRecord _$HexagramRecordFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const [
      'problem',
      'hexagram',
      'changing_lines',
      'stems',
      'branches'
    ],
  );
  return HexagramRecord(
    problem: json['problem'] as String,
    hexagram: $enumDecode(_$HexagramEnumMap, json['hexagram']),
    changingLines:
        (json['changing_lines'] as List<dynamic>).map((e) => e as int).toSet(),
    stems: (json['stems'] as List<dynamic>)
        .map((e) => $enumDecodeNullable(_$StemEnumMap, e))
        .toList(),
    branches: (json['branches'] as List<dynamic>)
        .map((e) => $enumDecodeNullable(_$BranchEnumMap, e))
        .toList(),
    comments: json['comments'],
    dateTime:
        (json['date_time'] as List<dynamic>?)?.map((e) => e as int?).toList(),
    config: json['config'] == null
        ? null
        : HexagramRecordConfig.fromJson(json['config'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$HexagramRecordToJson(HexagramRecord instance) =>
    <String, dynamic>{
      'problem': instance.problem,
      'hexagram': _$HexagramEnumMap[instance.hexagram]!,
      'changing_lines': instance.changingLines.toList(),
      'stems': instance.stems.map((e) => _$StemEnumMap[e]).toList(),
      'branches': instance.branches.map((e) => _$BranchEnumMap[e]).toList(),
      'date_time': instance.dateTime,
      'comments': instance.comments,
      'config': instance.config?.toJson(),
    };

const _$StemEnumMap = {
  Stem.jia: 'jia',
  Stem.yi: 'yi',
  Stem.bing: 'bing',
  Stem.ding: 'ding',
  Stem.wu: 'wu',
  Stem.ji: 'ji',
  Stem.geng: 'geng',
  Stem.xin: 'xin',
  Stem.ren: 'ren',
  Stem.gui: 'gui',
};
