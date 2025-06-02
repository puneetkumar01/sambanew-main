class AppUrls {
  static const String appName = 'Ticketer';
  static const double appVersion = 1.0;
  static const String baseUrl = 'https://apifrontv2.ticketer.sg';
  static const String baseLoginUrl = 'https://apiloginv2.ticketer.sg';
  static const String baseUrlMail = 'https://apimailv2.ticketer.sg';
  static const String socialLogins = '/FrontLogin/login-auth';
  static const String loginUrl = '/FrontLogin/signin-with-password';
  static const String signupUrl = '/FrontLogin/signup';
  static const String sendLoginMail = '/api/front/SignUp/SendVerificationCode';
  static const String verifyAccount = '/api/front/SignUp/VerifyAccount';
  static const String resetPassword = '/api/front/SignUp/ResetPassword';
  static const String events = '/api/Event/GetEventList';
  static const String eventCategory = "/api/Master/FillMasters";
  static const String eventTicket = "/api/Event/GetEventTicketList";
  static const String createCart = "/api/Cart/CreateCart";
  static const String fetchCart = "/api/Cart/GetCartItemsList";
  static const String deletCart = "/api/Cart/CartDelete";
  static const String addOn = "/api/Addon/GetAddonList";
  static const String getVendorDetail = "/api/Event/GetVendorDetail";
  static const String getBookings = "/api/Customer/GetBookingHistory";
  static const String getTickets = "/api/Customer/GetBookedTickets";
  static const String getPromo = "/api/Event/GetEventPromoList";
  static const String applyPromo = "/api/Cart/ApplyPromoCode";
  static const String checkout = "/api/Cart/Checkout";
  static const String confirmPayment = "/api/Cart/VerifyPayment";
  static const String paymentGatewayCharges =
      "/api/Cart/CalculatePaymentGatewayFee";
  static const String paymentGatwayList = "/api/Cart/GetPaymentGatewayList";
  static const String likeEvent = "/api/Event/EventLike";
  static const String follow = "/api/Event/VendorFollow";
  static const String getSlidders = "/api/Master/GetFrontSlider";
  static const String getPrivacyPolicy = "/api/Master/GetPrivacyPolicy";
  static const String getPurchasePolicy = "/api/Master/GetPurchasePolicy";
  static const String getLikEvents = "/api/Event/EventLikeList";
  static const String getFollowings = "/api/Event/VendorFollowList";
  static const String deleteAccount = "/api/Customer/DeleteAccount";
  static const String schdueleDateTime =
      "/api/Event/GetEventRecurScheduleDatesList";
  static const String dynamicJson = "/api/Cart/GetDynamicCheckoutJson";
}
//abnikagarg10@gmail.com