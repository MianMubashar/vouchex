import 'package:get/get.dart';
import 'package:vouchex/src/ui/modules/help_support/faq.dart';

class FAQs{
  bool status;
  List<FAQModel>? faqs;
  FAQs({required this.status,required this.faqs});

  factory FAQs.fromJson(Map<String, dynamic> data){
    return FAQs(
        status: data['status'],
        faqs: data['faqs'] != null ? List<FAQModel>.from(data['faqs'].map((x)=>FAQModel.fromJson(x))):null
    );
  }
}
class FAQModel {
  int id;
  String question;
  String answer;
  String isActive;
  String? createdAt;
  String? updatedAt;
  RxBool visible;

  FAQModel({
    required this.id,
   required this.question,
   required this.answer,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.visible


});

  factory FAQModel.fromJson(Map<String, dynamic> data){
    return FAQModel(
        id: data['id'],
        question: data['question'],
        answer: data['answer'],
        isActive : data['isActive'],
      createdAt: data['created_at'],
      updatedAt: data['updated_at'],
      visible: false.obs
    );
  }
}

// List<FAQModel> faqList = <FAQModel>[
//   FAQModel(question: "What Is VExchange?", answer: "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content."),
//   FAQModel(question: "Want to exchange voucher?", answer: "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content."),
//   FAQModel(question: "Need Help in creating business page?", answer: "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content."),
// ];