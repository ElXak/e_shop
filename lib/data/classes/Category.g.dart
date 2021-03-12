// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) {
  return Category(
    id: json['ID'] as String,
    name: json['NAME'] as String,
    title: json['UF_BROWSER_TITLE'] as String,
    depthLevel: json['DEPTH_LEVEL'] as String,
    sectionPageUrl: json['SECTION_PAGE_URL'] as String,
    code: json['CODE'] as String,
    externalId: json['EXTERNAL_ID'] as String,
    iBlockTypeId: json['IBLOCK_TYPE_ID'] as String,
    iBlockId: json['IBLOCK_ID'] as String,
    iBlockCode: json['IBLOCK_CODE'] as String,
    iBlockExternalId: json['IBLOCK_EXTERNAL_ID'] as String,
    globalActive: json['GLOBAL_ACTIVE'] as String,
  );
}

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'ID': instance.id,
      'NAME': instance.name,
      'UF_BROWSER_TITLE': instance.title,
      'DEPTH_LEVEL': instance.depthLevel,
      'SECTION_PAGE_URL': instance.sectionPageUrl,
      'CODE': instance.code,
      'EXTERNAL_ID': instance.externalId,
      'IBLOCK_TYPE_ID': instance.iBlockTypeId,
      'IBLOCK_ID': instance.iBlockId,
      'IBLOCK_CODE': instance.iBlockCode,
      'IBLOCK_EXTERNAL_ID': instance.iBlockExternalId,
      'GLOBAL_ACTIVE': instance.globalActive,
    };
