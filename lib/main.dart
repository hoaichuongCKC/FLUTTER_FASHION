import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_fashion/app/blocs/address_user/address_user_cubit.dart';
import 'package:flutter_fashion/app/blocs/cart/cart_cubit.dart';
import 'package:flutter_fashion/app/blocs/category/category_cubit.dart';
import 'package:flutter_fashion/app/blocs/chat/chat_cubit.dart';
import 'package:flutter_fashion/app/blocs/favorite/favorite_cubit.dart';
import 'package:flutter_fashion/app/blocs/notification/notification_cubit.dart';
import 'package:flutter_fashion/app/blocs/order/order_cubit.dart';
import 'package:flutter_fashion/app/blocs/popular_search/popular_search_cubit.dart';
import 'package:flutter_fashion/app/blocs/product/product_cubit.dart';
import 'package:flutter_fashion/app/blocs/product_detail/product_detail_cubit.dart';
import 'package:flutter_fashion/app/blocs/promotion/promotion_cubit.dart';
import 'package:flutter_fashion/app/blocs/review/review_cubit.dart';
import 'package:flutter_fashion/app/blocs/search/search_cubit.dart';
import 'package:flutter_fashion/app/blocs/user/user_cubit.dart';
import 'package:flutter_fashion/app/presentation/category/blocs/category_tab_cubit.dart';
import 'package:flutter_fashion/app/presentation/home/export.dart';
import 'package:flutter_fashion/app_lifecycle.dart';
import 'package:flutter_fashion/core/pusher/beams.dart';
import 'package:flutter_fashion/core/pusher/chat.dart';
import 'package:flutter_fashion/core/pusher/order.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.

  log("Handling a background message: ${message.notification!.body}",
      name: "Firebase Messagesing Background");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  // HydratedBloc.storage.clear();

  await PusherBeamsApp.instance.getStarted();

  await init();

  Bloc.observer = MyBlocObserver();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<ThemeCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<LanguageCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<CategoryCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<BannerCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<ProductCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<PopularSearchCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<CategoryTabCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<ProductDetailCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<ReviewCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<PromotionCubit>(),
        ),
      ],
      child: const Phoenix(child: MyApp()),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  late StreamSubscription<ConnectivityResult> _subscription;

  late PusherChatApp _pusherChatApp;

  // late PusherOrderApp _pusherOrderApp;

  @override
  void initState() {
    super.initState();
    //listen connect internet
    _subscription = getIt
        .get<Connectivity>()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      getIt.get<NetworkInfoImpl>().listenChangeNetwork(result);
    });

    //register
    WidgetsBinding.instance.addObserver(AppLifecycleObserver());

    PusherBeamsApp.instance.onMessageReceivedInTheForeground();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    getIt.get<UserCubit>().stream.listen(
      (event) {
        event.when(
            initial: () {},
            loading: () {},
            fetchCompleted: (user) {
              //register notfication with authentication userId
              PusherBeamsApp.instance.initToUser(user.id);

              //register real-time chat app
              _pusherChatApp = getIt<PusherChatApp>()
                ..initialize(
                  onEvent: (event) {
                    if (event.data.isNotEmpty) {
                      _pusherChatApp.handleData(context, event.data);
                    }
                  },
                );

              // _pusherOrderApp = getIt<PusherOrderApp>()
              //   ..initialize(
              //     onEvent: (event) {
              //       if (event.data.isNotEmpty) {
              //         _pusherOrderApp.handleData(context, event.data);
              //       }
              //     },
              //   );
            },
            failure: (e) {});
      },
    );
  }

  @override
  void dispose() {
    _subscription.cancel();
    WidgetsBinding.instance.removeObserver(AppLifecycleObserver());
    if (getIt.isRegistered<PusherChatApp>()) {
      _pusherChatApp.dispose();
    }
    // if (getIt.isRegistered<PusherOrderApp>()) {
    //   _pusherOrderApp.dispose();
    // }
    PusherBeamsApp.instance.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<UserCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<CartCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<AddressUserCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<OrderCubit>()..fetchOrder(),
        ),
        BlocProvider(
          create: (context) => getIt<FavoriteCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<ChatCubit>()..fetchChats(),
        ),
        BlocProvider(
          create: (context) => getIt<NotificationCubit>()..fetch(null),
        ),
        BlocProvider(
          create: (context) => getIt<SearchCubit>(),
        ),
      ],
      child: BlocConsumer<ThemeCubit, ThemeState>(
        listener: (context, state) {
          if (state.isDark) {
            SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
            return;
          }
          SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
        },
        builder: (context, state) {
          return BlocBuilder<LanguageCubit, LanguageState>(
            builder: (context, languageState) {
              return MaterialApp.router(
                theme: state.isDark ? appThemeDark : appThemeLight,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                scaffoldMessengerKey: AppSnackbarMessenger.scaffoldMessengerKey,
                routerConfig: AppRoutes.router,
                debugShowCheckedModeBanner: false,
                locale: languageState.isVietnamese
                    ? const Locale('vi', 'VN')
                    : const Locale('en', 'US'),
                title: 'App Fashion',
              );
            },
          );
        },
      ),
    );
  }
}
