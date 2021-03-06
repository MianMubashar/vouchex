import 'package:get/get.dart';
import 'package:vouchex/src/bindings/bindings.dart';
import 'package:vouchex/src/controllers/controllers.dart';
import 'package:vouchex/src/ui/modules/modules.dart';
import 'package:vouchex/src/ui/modules/my_vouchers/modules.dart';

import '../ui/modules/voucher/vouchers_list.dart';


List<GetPage<dynamic>> routes = [
  GetPage(
    name: '/',
    page: () => OnBoardingScreen(),
    binding: MainBindings()
  ),
  GetPage(
    name: '/MobileNumber',
    page: () => MobileNumber(),
    binding: PhoneBinding()
  ),
  GetPage(
    name: '/Login',
    page: () => LoginScreen(),
    binding: LoginBinding()
  ),
  GetPage(
    name: '/OtpScreen',
    page: () => OtpScreen(),
    binding: OtpBinding()
  ),
  GetPage(
    name: '/BottomBar',
    page: () => BottomBar(),
    binding: BottomBarBinding()
  ),
  GetPage(
    name: '/VoucherDetails',
    page: () => VoucherDetails(),
  ),
  GetPage(
    name: '/Profile',
    page: () => UserProfileScreen()
  ),
  GetPage(
    name: '/History',
    page: () => HistoryScreen(),
    binding: HistoryTabViewBinding()
  ),
  GetPage(
    name: '/Notification',
    page: () => NotificationsScreen(),
    binding: NotificationsBinding()
  ),
  GetPage(
    name: '/MyVouchers',
    page: () => MyVouchersScreen(),
    binding: MyVouchersTabViewBinding()
  ),
  GetPage(
      name: '/myVoucherList',
      page:()=> VoucherList()
  ),
  GetPage(
    name: '/CreateNewVoucher',
    page: () => CreateNewVoucher(),
    binding: CreateNewVoucherBinding()
  ),
  GetPage(
    name: '/SearchResults',
    page: () => SearchResult(),
    binding: SearchResultBinding()
  ),
  GetPage(
    name: '/HelpSupport',
    page: () => HelpAndSupport()
  ),
  GetPage(
      name: '/FAQ',
      page: () => FAQ(),
    binding: FAQBinding()
  ),
  GetPage(
    name: '/Terms',
    page: () => TermsAndCondition(),
    binding: TermsConditionBinding()
  ),
  GetPage(
    name: '/ContactUs',
    page: () => ContactUs(),
    binding: ContactUsBinding()
  ),
  GetPage(
    name: '/About',
    page: () => About(),
    binding: AboutusBinding()
  ),
  GetPage(
    name: '/VxVouchers',
    page: () => VouchexVouchers(),
    binding: VouchexBinding()
  ),
  GetPage(
    name: '/CreateBusiness',
    page: () => CreateBusinessPage(),
    binding: CreateBusinessBinding()
  ),
  GetPage(
    name: '/BusinessDetails',
    page: () => BusinessDetails()
  ),
  GetPage(
    name : '/MyBusinessDetails',
    page: () => MyBusinessDetails(),
    binding: MyBusinessDetailsBinding()
  ),
  GetPage(
    name: '/EditBusiness',
    page: () => EditBusiness(),
    binding: EditBusinessBinding()
  ),
  GetPage(
    name: '/SentPendingRequest',
    page: () => SentPendingRequests(),
    binding: SentPendingRequestBinding()
  ),
  GetPage(
    name: '/Location',
    page: () => PickLocationFromMap(),
    binding: LocationBinding()
  ),
];