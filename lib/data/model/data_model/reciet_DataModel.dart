class RecietCollectionDataModel {
  int? id;
  int? paperNum;
  int? paymentReceipt;
  int? totalPapers;
  RecietCollectionDataModel({
    this.id,
    this.paperNum = 0,
    this.totalPapers = 0,
    this.paymentReceipt = 0,
  });
  Map<String, dynamic> toJson() => {
        'id': id,
        'paperNum': paperNum,
        'paymentReceipt ': paymentReceipt,
        'totalPapers': totalPapers,
      };

  factory RecietCollectionDataModel.fromJson(Map<String, dynamic> json) =>
      RecietCollectionDataModel(
        id: json['id'],
        paperNum: json['paperNum'],
        paymentReceipt: json['paymentReceipt '],
        totalPapers: json['totalPapers'],
      );
}
