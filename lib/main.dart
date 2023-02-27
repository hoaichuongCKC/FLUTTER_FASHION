import 'package:firebase_messaging/firebase_messaging.dart';
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
    _subscription = Connectivity()
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
    return BlocBuilder<ThemeCubit, ThemeState>(
      key: const ValueKey("theme-cubit"),
      builder: (context, state) {
        return BlocBuilder<LanguageCubit, LanguageState>(
          key: const ValueKey("language-cubit"),
          builder: (context, languageState) {
            return MaterialApp.router(
              theme: state.isDark ? appThemeDark : appThemeLight,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              scaffoldMessengerKey: AppSnackbarMessenger.scaffoldMessengerKey,
              routerConfig: AppRoutes.router,
              debugShowCheckedModeBanner: false,
              locale: languageState.locale,
              title: 'App Fashion',
            );
          },
        );
      },
    );
  }
}
