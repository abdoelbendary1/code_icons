class RecietCollectionDataModel {
  int? id;
  int? paperNum;
  int? totalPapers;
  RecietCollectionDataModel({
    this.id,
    this.paperNum = 0,
    this.totalPapers = 0,
  });
  Map<String, dynamic> toJson() => {
        'id': id,
        'paperNum': paperNum,
        'totalPapers': totalPapers,
      };

  factory RecietCollectionDataModel.fromJson(Map<String, dynamic> json) =>
      RecietCollectionDataModel(
        id: json['id'],
        paperNum: json['paperNum'],
        totalPapers: json['totalPapers'],
      );
}
