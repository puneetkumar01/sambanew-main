import 'package:get/get.dart';
import 'package:sambanew/bindings/ticketdetails_bindings.dart';
import 'package:sambanew/view/auth/login.dart';
import 'package:sambanew/view/event/bookings/checkout.dart';
import 'package:sambanew/view/event/event_details.dart';
import 'package:sambanew/view/event/vendor_details.dart';
import 'package:sambanew/view/splash/splash_screen.dart';
import 'package:sambanew/view/tickets/ticket_details.dart';
import '../bindings/auth_bindings.dart';
import '../bindings/event_bindings.dart';
import '../bindings/home_bindings.dart';
import '../bindings/social_auth_bindings.dart';
import '../bindings/splash_bindings.dart';
import '../bindings/ticket_bindings.dart';
import '../bindings/vendor_bindings.dart';
import '../view/auth/social_login_web.dart';
import '../view/auth/web_page.dart';
import '../view/bottombar/bottom_bar.dart';
import '../view/event/bookings/select_tickets.dart';

class AppPage {
  static var list = [
    GetPage(
        name: "/splash",
        page: () => const SplashScreen(),
        binding: SplashBinding()),
    GetPage(
        name: "/", page: () => const DashboardScreen(), binding: RootBinding()),
    GetPage(
        name: "/selectTicket/:id/:scdueleid",
        page: () => const SelectTicketPage(),
        binding: TicketBinding()),
    GetPage(
      name: "/login",
      page: () => Login(),
      fullscreenDialog: true,
      binding: AuthBindings(),
    ),
    GetPage(
        name: "/social-login",
        page: () => SocialLoginWeb(),
        binding: SocialAuthBindings()),
    GetPage(
      name: "/checkout/:scdueleid",
      page: () => const CheckOut(),
    ),
    GetPage(
      name: "/webview",
      page: () => const webView(
        url: '',
        type: '',
      ),
    ),
    GetPage(
        name: "/eventDetail/:id",
        page: () => const EventDetails(),
        binding: EventBindings()),
    GetPage(
        name: "/vendorDeatils",
        page: () => const VendorDetails(),
        binding: VendorBinding()),
    GetPage(
      name: "/ticketDetails/:id",
      page: () => const TicketDetails(),
      binding: TicketDetailsBinding(),
      transition: Transition.zoom,
      transitionDuration: const Duration(milliseconds: 300),
      fullscreenDialog: true,
    ),
  ];
}
