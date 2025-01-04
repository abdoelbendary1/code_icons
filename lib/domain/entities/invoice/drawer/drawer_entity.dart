import 'package:code_icons/data/model/response/collections/currency/currency.dart';
import 'package:code_icons/domain/entities/Currency/currency.dart';

class DrawerEntity {
  int? id;
  int? accountId;
  String? nameAr;
  dynamic nameEn;
  int? currencyId;
  CurrencyDataModel? currency;
  double? rate;
  double? openBalance;
  dynamic freeze;
  int? userId;
  dynamic lastUpdateUserId;
  String? insertDate;
  dynamic lastUpdateDate;

  DrawerEntity(
      {this.id,
      this.accountId,
      this.nameAr,
      this.nameEn,
      this.currencyId,
      this.currency,
      this.rate,
      this.openBalance,
      this.freeze,
      this.userId,
      this.lastUpdateUserId,
      this.insertDate,
      this.lastUpdateDate});
}
