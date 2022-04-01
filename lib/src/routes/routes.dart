import 'package:get/get.dart';
import 'package:vouchex/src/bindings/bindings.dart';
import 'package:vouchex/src/ui/modules/modules.dart';


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
    binding: VoucherDataBinding()
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
    page: () => NotificationsScreen()
  ),
  GetPage(
    name: '/MyVouchers',
    page: () => MyVouchersScreen(),
    binding: MyVouchersTabViewBinding()
  ),
  GetPage(
    name: '/CreateNewVoucher',
    page: () => CreateNewVoucher(),
    binding: CreateNewVoucherBinding()
  ),
  GetPage(
    name: '/SearchResults',
    page: () => SearchResult()
  ),
  GetPage(
    name: '/HelpSupport',
    page: () => HelpAndSupport()
  ),
  GetPage(
      name: '/FAQ',
      page: () => FAQ()
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
  )
];