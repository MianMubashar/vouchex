import 'package:vouchex/src/data/model/models.dart';

class VoucherDetailsModel{
  final String qrImage;
  final String businessName;
  final String expiryDate;
  final String terms;
  final List<AllVoucherServices> services;
  final String marketValue;
  final String tokenCode;
  final int isFree;

  VoucherDetailsModel({
   required this.qrImage,
   required this.businessName,
   required this.expiryDate,
   required this.terms,
   required this.services,
   required this.marketValue,
   required this.tokenCode,
    required this.isFree,
});
}

List<VoucherDetailsModel> voucherDetailsList = <VoucherDetailsModel>[];