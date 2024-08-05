import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class RecietCollectionDataModel {
  @HiveField(0)
  int? id;

  @HiveField(1)
  int? paperNum;

  @HiveField(2)
  int? totalPapers;
  @HiveField(3)
  bool? valid;

  RecietCollectionDataModel({
    this.id,
    this.paperNum,
    this.totalPapers,
    this.valid,
  });

  factory RecietCollectionDataModel.fromJson(Map<dynamic, dynamic> json) =>
      RecietCollectionDataModel(
        id: json["id"],
        paperNum: json["paperNum"],
        totalPapers: json["totalPapers"],
        valid: json["valid"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "paperNum": paperNum,
        "totalPapers": totalPapers,
        "valid": valid,
      };
}
