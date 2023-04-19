// ignore_for_file: constant_identifier_names

import 'package:flutter_fashion/app/presentation/category/category_page.dart';
import 'package:flutter_fashion/app/presentation/create_review/create_review_page.dart';
import 'package:flutter_fashion/app/presentation/filter/filter_page.dart';
import 'package:flutter_fashion/app/presentation/home/export.dart';
import 'package:flutter_fashion/app/presentation/location_management/location_management_page.dart';
import 'package:flutter_fashion/app/presentation/notification_detail/notification_detail_page.dart';
import 'package:flutter_fashion/app/presentation/order/order_page.dart';
import 'package:flutter_fashion/app/presentation/otp/otp_page.dart';
import 'package:flutter_fashion/app/presentation/payment/payment_page.dart';
import 'package:flutter_fashion/app/presentation/personal_information/personal_information.dart';
import 'package:flutter_fashion/app/presentation/product_detail/product_detail_page.dart';
import 'package:flutter_fashion/app/presentation/promotion/promotion_page.dart';
import 'package:flutter_fashion/app/presentation/register/register_page.dart';
import 'package:flutter_fashion/app/presentation/room_chat/room_chat_page.dart';
import 'package:flutter_fashion/app/presentation/search/search_page.dart';
import 'package:flutter_fashion/app/presentation/setting/setting_page.dart';
import 'package:flutter_fashion/app/presentation/sign_up/sign_up_page.dart';
import 'package:flutter_fashion/common/components/bottom_navigation_bar.dart';
import 'package:flutter_fashion/app/presentation/notification/notification_page.dart';
import 'package:flutter_fashion/app/presentation/profile/profile_page.dart';
import 'package:flutter_fashion/common/transition/fade.dart';
import 'package:flutter_fashion/common/transition/right_to_left.dart';
import 'package:flutter_fashion/core/storage/key.dart';
import 'package:flutter_fashion/routes/export.dart';
import '../app/presentation/cart/cart_page.dart';
import 'dart:developer';

import '../app/presentation/favorites/favorite_page.dart';
import '../app/presentation/forgot_password/forgot_password_page.dart';
import '../app/presentation/order_detail/order_detail_page.dart';
import '../app/presentation/review_success/review_success_page.dart';

abstract class Routes {
  Routes._();
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static final GlobalKey<NavigatorState> shellNavigatorKey =
      GlobalKey<NavigatorState>();

  static const INTRODUCTION = _Paths.INTRODUCTION;
  static const HOME = _Paths.HOME;
  static const PROFILE = _Paths.PROFILE;
  static const LOGIN = _Paths.LOGIN;
  static const SIGNUP = _Paths.SIGNUP;
  static const FORGOT_PASSWORD = _Paths.FORGOT_PASSWORD;
  static const REGISTER = _Paths.REGISTER;
  static const NOTIFICATION = _Paths.NOTIFICATION;
  static const SEARCH = _Paths.SEARCH;
  static const CATEGORY = _Paths.CATEGORY;
  static const CART = _Paths.CART;
  static const ADDRESS_MANAGEMENT = _Paths.ADDRESS_MANAGEMENT;
  static const PRODUCT_DETAIL = _Paths.PRODUCT_DETAIL;

  //page second
  static const SETTING = _Paths.SETTING;
  static const PERSONAL = _Paths.PERSONAL;
  static const REPORT = _Paths.REPORT;
  static const FAVORITE = _Paths.FAVORITE;
  static const MY_ORDER = _Paths.ORDER;
  static const MESSENGER = _Paths.MESSENGER;
  static const FILTER = _Paths.FILTER;
  static const PAYMENT = _Paths.PAYMENT;
  static const PROMOTION = _Paths.PROMOTION;
  static const ORDER_DETAIL = _Paths.ORDER_DETAIL;
  static const RATING_PRODUCT = _Paths.RATING_PRODUCT;
  static const NOTIFICATION_DETAIL = _Paths.NOTIFICATION_DETAIL;
  static const REVIEW_SUCCESS = _Paths.REVIEW_SUCCESS;

  //

  static const OTP = _Paths.OTP;
}

abstract class _Paths {
  _Paths._();
  static const INTRODUCTION = '/introduction';
  static const HOME = '/home';
  static const LOGIN = '/login';
  static const SIGNUP = '/sign-up';
  static const FORGOT_PASSWORD = 'forgot-password';
  static const NOTIFICATION = '/notification';
  static const PROFILE = '/profile';
  static const SEARCH = 'search';
  static const CATEGORY = 'category';
  static const CART = '/cart';
  static const PRODUCT_DETAIL = 'product_detail';
  static const ADDRESS_MANAGEMENT = 'address_management';
  static const PROMOTION = '/promotion';

  //second
  static const ORDER_DETAIL = 'order_detail';
  static const SETTING = 'setting';
  static const PERSONAL = '/personal';
  static const REPORT = '/report';
  static const FAVORITE = 'favorite';
  static const MESSENGER = 'messenger';
  static const ORDER = 'order';
  static const OTP = 'otp';
  static const REGISTER = 'resgister';
  static const FILTER = 'filter';
  static const PAYMENT = '/payment';
  static const RATING_PRODUCT = 'rating_product';
  static const NOTIFICATION_DETAIL = 'notification_detail';
  static const REVIEW_SUCCESS = 'review-success';
}

abstract class Names {
  Names._();
  // static const INTRODUCTION = '/introduction';
  // static const HOME = '/home';
  // static const LOGIN = '/login';
  // static const NOTIFICATION = '/notification';
  static const SEARCH = 'search';
  static const CATEGORY = 'category';
  static const PERSONAL = 'personal';
  static const PAYMENT = 'payment';
  static const PRODUCT_DETAIL = 'product_detail';
  //page second
  // static const SETTING = '/setting';
  static const SIGNUP = 'sign-up';
  static const FORGOT_PASSWORD = 'forgot-password';
  static const OTP = 'otp';
  static const REGISTER = 'register';
  static const FILTER = 'filter';
  static const PROMOTION = 'promotion';
  static const SETTING = 'setting';
  static const ORDER = 'order';
  static const ORDER_DETAIL = 'order_detail';
  static const FAVORITE = 'favorite';
  static const MESSENGER = 'messenger';
  static const ADDRESS_MANAGEMENT = 'address_management';
  static const RATING_PRODUCT = 'rating_product';
  static const NOTIFICATION_DETAIL = 'notification_detail';
  static const REVIEW_SUCCESS = 'review-success';
}

class AppRoutes {
  static String initLocation = Routes.INTRODUCTION;

  static final router = GoRouter(
    initialLocation: initLocation,
    navigatorKey: Routes.navigatorKey,
    debugLogDiagnostics: true,
    // observers: [GoRouterObserver()],
    redirect: (context, state) {
      log("Redirect: ${state.location}", name: "Redirect");

      if (state.subloc == Routes.INTRODUCTION) {
        String? isAuthenticated = HydratedBloc.storage.read(KeyStorage.token);

        log("Your Token: $isAuthenticated", name: "Local storage");

        if (isAuthenticated != null) {
          return Routes.HOME;
        }
        return null;
      }

      return null;
    },
    routes: [
      GoRoute(
        parentNavigatorKey: Routes.navigatorKey,
        path: Routes.INTRODUCTION,
        builder: (context, state) => const IntroductionPage(),
      ),
      GoRoute(
        path: Routes.LOGIN,
        parentNavigatorKey: Routes.navigatorKey,
        builder: (context, state) => LoginPage(
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: Routes.SIGNUP,
        parentNavigatorKey: Routes.navigatorKey,
        builder: (context, state) => SignUpPage(
          key: state.pageKey,
          payload: state.extra as String,
        ),
        routes: [
          GoRoute(
            name: Names.OTP,
            path: Routes.OTP,
            parentNavigatorKey: Routes.navigatorKey,
            pageBuilder: (context, state) => SlideTransitionPage(
              key: state.pageKey,
              child: OtpPage(
                phoneNumber: state.queryParams["phone"]!,
                verificationId: state.queryParams["verificationId"]!,
                payload: state.queryParams['payload'] ?? "",
              ),
            ),
          ),
          GoRoute(
            name: Names.FORGOT_PASSWORD,
            path: Routes.FORGOT_PASSWORD,
            parentNavigatorKey: Routes.navigatorKey,
            pageBuilder: (context, state) => SlideTransitionPage(
              key: state.pageKey,
              child: ForgotPasswordPage(
                  phoneNumber: state.queryParams["phone"] ?? ""),
            ),
          ),
          GoRoute(
            name: Names.REGISTER,
            path: Routes.REGISTER,
            parentNavigatorKey: Routes.navigatorKey,
            pageBuilder: (context, state) => SlideTransitionPage<RegisterPage>(
              key: state.pageKey,
              child: RegisterPage(phoneNumber: state.queryParams["phone"]!),
            ),
          ),
        ],
      ),
      GoRoute(
        name: Names.PERSONAL,
        path: Routes.PERSONAL,
        parentNavigatorKey: Routes.navigatorKey,
        pageBuilder: (context, state) {
          return SlideTransitionPage<PersonalInformationPage>(
            key: state.pageKey,
            child: const PersonalInformationPage(),
          );
        },
      ),
      GoRoute(
        path: Routes.CART,
        parentNavigatorKey: Routes.navigatorKey,
        pageBuilder: (context, state) {
          return SlideTransitionPage<CartPage>(
            key: state.pageKey,
            child: const CartPage(),
          );
        },
      ),
      GoRoute(
        path: Routes.PAYMENT,
        name: Names.PAYMENT,
        parentNavigatorKey: Routes.navigatorKey,
        pageBuilder: (context, state) {
          return FadeTransitionPage<PaymentPage>(
            key: state.pageKey,
            child: const PaymentPage(),
          );
        },
      ),
      GoRoute(
        path: Routes.PROMOTION,
        name: Names.PROMOTION,
        parentNavigatorKey: Routes.navigatorKey,
        pageBuilder: (context, state) {
          return FadeTransitionPage<PromotionPage>(
            key: state.pageKey,
            child: const PromotionPage(),
          );
        },
      ),
      ShellRoute(
        navigatorKey: Routes.shellNavigatorKey,
        builder: (BuildContext context, GoRouterState state, Widget child) {
          final isVisibility = state.subloc == Routes.HOME ||
              state.subloc == Routes.NOTIFICATION ||
              Routes.PROFILE == state.subloc;
          final widget = BottomNavigationBarApp(pagePath: state.subloc);
          return Scaffold(
            body: child,
            /* ... */
            bottomNavigationBar: isVisibility ? widget : null,
          );
        },
        routes: <RouteBase>[
          GoRoute(
            parentNavigatorKey: Routes.shellNavigatorKey,
            path: Routes.HOME,
            pageBuilder: (context, state) {
              return NoTransitionPage(
                key: state.pageKey,
                child: const HomePage(),
              );
            },
            routes: [
              GoRoute(
                name: Names.SEARCH,
                path: Routes.SEARCH,
                parentNavigatorKey: Routes.navigatorKey,
                pageBuilder: (context, state) => FadeTransitionPage<SearchPage>(
                  key: state.pageKey,
                  child: const SearchPage(),
                ),
                routes: [
                  GoRoute(
                    name: Names.FILTER,
                    path: Routes.FILTER,
                    parentNavigatorKey: Routes.navigatorKey,
                    pageBuilder: (context, state) =>
                        SlideTransitionPage<CategoryPage>(
                      key: state.pageKey,
                      child: const FilterPage(),
                    ),
                  )
                ],
              ),
              GoRoute(
                name: Names.CATEGORY,
                path: Routes.CATEGORY,
                parentNavigatorKey: Routes.navigatorKey,
                pageBuilder: (context, state) =>
                    FadeTransitionPage<CategoryPage>(
                  key: state.pageKey,
                  child: CategoryPage(
                    index: int.parse(state.queryParams["index"]!),
                  ),
                ),
              ),
              GoRoute(
                name: Names.PRODUCT_DETAIL,
                path: Routes.PRODUCT_DETAIL,
                parentNavigatorKey: Routes.navigatorKey,
                pageBuilder: (context, state) =>
                    FadeTransitionPage<ProductDetailPage>(
                  key: state.pageKey,
                  child: const ProductDetailPage(),
                ),
              ),
            ],
          ),
          GoRoute(
            path: Routes.NOTIFICATION,
            parentNavigatorKey: Routes.shellNavigatorKey,
            pageBuilder: (context, state) {
              return NoTransitionPage(
                key: state.pageKey,
                child: const NotificationPage(),
              );
            },
            routes: [
              GoRoute(
                path: Routes.NOTIFICATION_DETAIL,
                name: Names.NOTIFICATION_DETAIL,
                parentNavigatorKey: Routes.navigatorKey,
                pageBuilder: (context, state) {
                  final map = state.extra as Map;
                  return SlideTransitionPage<NotificationDetailPage>(
                    key: state.pageKey,
                    child: NotificationDetailPage(name: map["name"]),
                  );
                },
              ),
            ],
          ),
          GoRoute(
            path: Routes.PROFILE,
            parentNavigatorKey: Routes.shellNavigatorKey,
            pageBuilder: (context, state) {
              return NoTransitionPage(
                key: state.pageKey,
                child: const ProfilePage(),
              );
            },
            routes: [
              GoRoute(
                path: Routes.SETTING,
                name: Names.SETTING,
                parentNavigatorKey: Routes.navigatorKey,
                pageBuilder: (context, state) {
                  return SlideTransitionPage<SettingPage>(
                    key: state.pageKey,
                    child: const SettingPage(),
                  );
                },
              ),
              GoRoute(
                  path: Routes.MY_ORDER,
                  name: Names.ORDER,
                  parentNavigatorKey: Routes.navigatorKey,
                  pageBuilder: (context, state) {
                    return SlideTransitionPage<OrderPage>(
                      key: state.pageKey,
                      child: const OrderPage(),
                    );
                  },
                  routes: [
                    GoRoute(
                      path: Routes.ORDER_DETAIL,
                      name: Names.ORDER_DETAIL,
                      parentNavigatorKey: Routes.navigatorKey,
                      pageBuilder: (context, state) {
                        return SlideTransitionPage<OrderDetailPage>(
                          key: state.pageKey,
                          child: OrderDetailPage(
                            orderIndex: state.queryParams["index"]!,
                            status: state.queryParams["status"]!,
                          ),
                        );
                      },
                      routes: [
                        GoRoute(
                          path: Routes.REVIEW_SUCCESS,
                          name: Names.REVIEW_SUCCESS,
                          parentNavigatorKey: Routes.navigatorKey,
                          pageBuilder: (context, state) {
                            final index =
                                int.parse(state.queryParams["index"]!);
                            return SlideTransitionPage<ReviewSuccessPage>(
                              key: state.pageKey,
                              child: ReviewSuccessPage(indexParam: index),
                            );
                          },
                        ),
                      ],
                    ),
                    GoRoute(
                      path: Routes.RATING_PRODUCT,
                      name: Names.RATING_PRODUCT,
                      parentNavigatorKey: Routes.navigatorKey,
                      pageBuilder: (context, state) {
                        return SlideTransitionPage<CreateReviewPage>(
                          key: state.pageKey,
                          child: CreateReviewPage(
                            orderId: state.queryParams["order_id"]!,
                          ),
                        );
                      },
                    ),
                  ]),
              GoRoute(
                path: Routes.FAVORITE,
                name: Names.FAVORITE,
                parentNavigatorKey: Routes.navigatorKey,
                pageBuilder: (context, state) {
                  return SlideTransitionPage<FavoritePage>(
                    key: state.pageKey,
                    child: const FavoritePage(),
                  );
                },
              ),
              GoRoute(
                path: Routes.ADDRESS_MANAGEMENT,
                name: Names.ADDRESS_MANAGEMENT,
                parentNavigatorKey: Routes.navigatorKey,
                pageBuilder: (context, state) {
                  return FadeTransitionPage<LocationManagementPage>(
                    key: state.pageKey,
                    child: const LocationManagementPage(),
                  );
                },
              ),
              GoRoute(
                path: Routes.MESSENGER,
                name: Names.MESSENGER,
                parentNavigatorKey: Routes.navigatorKey,
                pageBuilder: (context, state) {
                  return SlideTransitionPage<RoomChatMessagePage>(
                    key: state.pageKey,
                    child: const RoomChatMessagePage(),
                  );
                },
              ),
            ],
          )
        ],
      ),
    ],
    errorBuilder: (context, state) => const ErrorPage(),
  );
}
