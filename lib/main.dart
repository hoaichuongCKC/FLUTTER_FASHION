import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_fashion/app/blocs/address_user/address_user_cubit.dart';
import 'package:flutter_fashion/app/blocs/banner/banner_cubit.dart';
import 'package:flutter_fashion/app/blocs/category/category_cubit.dart';
import 'package:flutter_fashion/app/blocs/popular_search/popular_search_cubit.dart';
import 'package:flutter_fashion/app/blocs/product/product_cubit.dart';
import 'package:flutter_fashion/app/blocs/user/user_cubit.dart';
import 'export.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.

  debugPrint("Handling a background message: ${message.messageId}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

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
        create: (context) => getIt<UserCubit>(),
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
    ],
    child: const MyApp(),
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
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    _subscription.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (kDebugMode) {
      switch (state) {
        case AppLifecycleState.paused:
          print("background mode");
          // getIt.isRegistered()<Connectivity>();
          // getIt.unregister<ImagePicker>();
          // if (getIt.isRegistered<CameraInfo>()) {
          //   getIt.unregister<CameraInfo>();
          // }

          break;
        case AppLifecycleState.resumed:
          print("foreground mode");

          break;
        case AppLifecycleState.inactive:
          print("inactive");
          break;
        case AppLifecycleState.detached:
          print("detached");
          break;
        default:
      }
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    //get context root
    return BlocBuilder<ThemeCubit, ThemeState>(
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
    );
  }
}
