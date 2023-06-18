class ApiEndpoint {
  static const String authBeams = "pusher/beams-auth";

  static const String login = "auth/login";
  static const String loginGoogle = "auth/login-google";
  static const String register = "auth/register";
  static const String loggout = "auth/logout";
  static const String checkPhone = "auth/check-phone";
  static const String forgotPassword = "auth/forgot-password";

  static const String me = "user/me";
  static const String update = "user/edit-profile";
  static const String changePassword = "user/change-password";
  static const String fetchChats = "user/fetch-chat";
  static const String createChat = "user/create-chat";

  static const String fetchBanner = "banner/fetch-banner";
  static const String fetchCategory = "cate/fetch-categories";
  static const String fetchProductByCate = "cate/fetch-product-by-category";

  static const String fetchProduct = "product/fetch-product-all";
  static const String fetchSaleProduct = "product/fetch-sale-product";
  static const String fetchNewProducts = "product/fetch-new-product";
  static const String getDetail = "product/get-detail";
  static const String fetchPopularSearch = "product/fetch-popular";
  static const String search = "product/search";

  static const String fetchReview = "review/fetch-review";
  static const String create = "review/create-review";

  static const String createOrder = "order/create";
  static const String fetchOrder = "order/fetch-order";
  static const String deleteOrder = "order/delete-order";
  static const String checkPromotion = "order/check-promotion";
  static const String updateLimitOrder = "product/update-promotion";

  static const String fetchNotification = "noti/fetch";
  static const String deleteNoti = "noti/delete";

  static const String fetchPromotion = "product/get-promotion";
}
