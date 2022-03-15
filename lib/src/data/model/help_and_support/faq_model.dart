import 'package:get/get.dart';
class FAQModel {
  final String question;
  final String answer;
  RxBool visible;

  FAQModel({
   required this.question,
   required this.answer,
    required this.visible
});
}

List<FAQModel> faqList = <FAQModel>[
  FAQModel(question: "What Is VExchange?", answer: "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content.", visible: false.obs),
  FAQModel(question: "Want to exchange voucher?", answer: "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content.", visible: false.obs),
  FAQModel(question: "Need Help in creating business page?", answer: "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content.", visible: false.obs),
];