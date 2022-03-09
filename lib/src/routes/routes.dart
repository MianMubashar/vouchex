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
  )
];