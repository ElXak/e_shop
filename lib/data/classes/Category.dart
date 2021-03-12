import 'package:json_annotation/json_annotation.dart';

part 'Category.g.dart';

// Run below command to generate Category.g.dart file
// flutter packages pub run build_runner build
// flutter pub run build_runner build --delete-conflicting-outputs

@JsonSerializable()
class Category {
  Category({
    this.id,
    this.name,
    this.title,
    this.depthLevel,
    this.sectionPageUrl,
    this.code,
    this.externalId,
    this.iBlockTypeId,
    this.iBlockId,
    this.iBlockCode,
    this.iBlockExternalId,
    this.globalActive,
  });

  @JsonKey(name: 'ID')
  final String id;

  @JsonKey(name: 'NAME')
  final String name;

  @JsonKey(name: 'UF_BROWSER_TITLE')
  final String title;

  @JsonKey(name: 'DEPTH_LEVEL')
  final String depthLevel;

  @JsonKey(name: 'SECTION_PAGE_URL')
  final String sectionPageUrl;

  @JsonKey(name: 'CODE', nullable: true)
  final String code;

  @JsonKey(name: 'EXTERNAL_ID', nullable: true)
  final String externalId;

  @JsonKey(name: 'IBLOCK_TYPE_ID', nullable: true)
  final String iBlockTypeId;

  @JsonKey(name: 'IBLOCK_ID', nullable: true)
  final String iBlockId;

  @JsonKey(name: 'IBLOCK_CODE', nullable: true)
  final String iBlockCode;

  @JsonKey(name: 'IBLOCK_EXTERNAL_ID', nullable: true)
  final String iBlockExternalId;

  @JsonKey(name: 'GLOBAL_ACTIVE', nullable: true)
  final String globalActive;

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);

  @override
  String toString() {
    return name.toString();
  }
}
