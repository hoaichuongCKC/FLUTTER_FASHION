// ignore_for_file: library_private_types_in_public_api
import 'dart:developer';
import 'package:flutter_fashion/app/blocs/address_user/address_user_cubit.dart';
import 'package:flutter_fashion/app/blocs/banner/banner_cubit.dart';
import 'package:flutter_fashion/app/blocs/cart/cart_cubit.dart';
import 'package:flutter_fashion/app/blocs/category/category_cubit.dart';
import 'package:flutter_fashion/app/blocs/payment/payment.dart';
import 'package:flutter_fashion/app/blocs/popular_search/popular_search_cubit.dart';
import 'package:flutter_fashion/app/blocs/product/product_cubit.dart';
import 'package:flutter_fashion/app/blocs/search_history/search_history_cubit.dart';
import 'package:flutter_fashion/app/blocs/user/user_cubit.dart';
import 'package:flutter_fashion/app_lifecycle.dart';
import 'export.dart';

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // If you're going to use other Firebase services in the background, such as Firestore,
//   // make sure you call `initializeApp` before using other Firebase services.

//   debugPrint("Handling a background message: ${message.messageId}");
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  //HydratedBloc.storage.clear();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

  await init();

  Bloc.observer = MyBlocObserver();

  runApp(MultiBlocProvider(
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
        create: (context) => getIt<SearchHistoryCubit>(),
      ),
    ],
    child: const Phoenix(child: MyApp()),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  late StreamSubscription<ConnectivityResult> _subscription;

  @override
  void initState() {
    //listen connect internet
    _subscription = getIt<Connectivity>()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      getIt<NetworkInfoImpl>().listenChangeNetwork(result);
    });

    //register
    WidgetsBinding.instance.addObserver(AppLifecycleObserver());
    super.initState();
  }

  @override
  void dispose() {
    _subscription.cancel();
    WidgetsBinding.instance.removeObserver(AppLifecycleObserver());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log("File main build", name: 'Main');
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
          create: (context) => getIt<OrderCubit>(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
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
