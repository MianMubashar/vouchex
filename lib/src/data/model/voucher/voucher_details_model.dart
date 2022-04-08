import 'package:vouchex/src/data/model/models.dart';

class VoucherDetailsModel{
  final String qrImage;
  final String businessName;
  final String expiryDate;
  final String terms;
  final List<AllVoucherServices> services;
  final String marketValue;
  final String tokenCode;

  VoucherDetailsModel({
   required this.qrImage,
   required this.businessName,
   required this.expiryDate,
   required this.terms,
   required this.services,
   required this.marketValue,
   required this.tokenCode
});
}

List<VoucherDetailsModel> voucherDetailsList = <VoucherDetailsModel>[
  // VoucherDetailsModel(
  //     qrImage: "assets/images/qr_code.png",
  //     businessName: "Adidas",
  //     expiryDate: "Thu, 25 jun,2020",
  //     terms: "Adidas want to exchange voucher with design services. we need mockups design for our brand.Adidas want to exchange voucher with design services. we need mockups design for our brand.",
  //     services: ["Mockups Design ", "App Design "],
  //     marketValue: "Adidas want to exchange voucher with design services. "
  //         "we need mockups design for our brand.Adidas want to exchange voucher with design services. we need mockups design for our brand.",
  //     tokenCode: "#333333"),
];