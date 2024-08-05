import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class RecietCollectionDataModel {
  @HiveField(0)
  int? id;

  @HiveField(1)
  int? paperNum;

  @HiveField(2)
  int? totalPapers;

  RecietCollectionDataModel({this.id, this.paperNum, this.totalPapers});

  factory RecietCollectionDataModel.fromJson(Map<String, dynamic> json) =>
      RecietCollectionDataModel(
        id: json["id"],
        paperNum: json["paperNum"],
        totalPapers: json["totalPapers"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "paperNum": paperNum,
        "totalPapers": totalPapers,
      };
}
