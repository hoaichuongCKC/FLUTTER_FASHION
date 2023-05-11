import 'package:flutter_fashion/app/blocs/auth_phone/auth_phone_cubit.dart';
import 'package:flutter_fashion/app/blocs/auth/auth_cubit.dart';
import 'package:flutter_fashion/app/presentation/sign_up/components/enter_the_otp_cpn.dart';
import 'package:flutter_fashion/app/presentation/sign_up/components/enter_the_phone_cpn.dart';
import 'package:flutter_fashion/app/presentation/sign_up/components/filling_out_information_personal.dart';
import 'package:flutter_fashion/app/presentation/sign_up/components/setup_password_avatar.dart';
import 'package:flutter_fashion/export.dart';
import 'package:flutter_fashion/utils/alert/error.dart';
import 'package:flutter_fashion/utils/alert/pop_up.dart';
import '../../../common/components/aurora/aurora_page.dart';

const stepFirstVn = "1. Vui lòng nhập số điện thoại của bạn";
const stepSecondVn = "2. Nhập mã OTP";
const stepThirdVn = "3. Điền thông tin cá nhân";
const stepFourthVn = "4. Thiết lập mật khẩu";

const List<String> stepTitlesVN = [
  stepFirstVn,
  stepSecondVn,
  stepThirdVn,
  stepFourthVn
];

const stepFirstEn = "1. Please enter the phone number";
const stepSecondEn = "2. Enter OTP code";
const stepThirdEn = "3. Filling out personal information";
const stepFourthEn = "4. Setup the password";

const List<String> stepTitlesEN = [
  stepFirstEn,
  stepSecondEn,
  stepThirdEn,
  stepFourthEn
];

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  static String phoneNumber = "";

  static String codeOTP = "";

  static String verificationId = "";

  static final ValueNotifier<int> currentStep = ValueNotifier<int>(0);

  static void dispose() {
    currentStep.value = 0;
  }

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  List<String> _stepTitles = [];

  final _totalStep = 4;

  @override
  void dispose() {
    SignUpPage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final size = MediaQuery.of(context).size;

    const duration = Duration(milliseconds: 500);

    const curve = Curves.easeIn;

    final isVietnamese = context.watch<SettingsCubit>().state.isVietnamese;

    if (isVietnamese) {
      _stepTitles = [...stepTitlesVN];
    } else {
      _stepTitles = [...stepTitlesEN];
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<AuthPhoneCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<AuthCubit>(),
        ),
      ],
      child: AuroraBackgroundPage(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Builder(builder: (context) {
                return ButtonWidget(
                  width: size.width - 15,
                  onPressed: () {
                    if (!validateSignUp) return;
                    final bloc = context.read<AuthPhoneCubit>();
                    switch (SignUpPage.currentStep.value) {
                      case 0:
                        bloc.phoneAuth(
                            SignUpPage.phoneNumber, context, Names.REGISTER);
                        break;
                      case 1:
                        bloc.verifyOtp(
                            SignUpPage.phoneNumber,
                            SignUpPage.codeOTP,
                            context,
                            SignUpPage.verificationId);
                        break;
                      case 2:
                        SignUpPage.currentStep.value++;
                        break;
                      case 3:
                        if (FillingOutInformationPersonalCpn
                            .checkMatchPassword) {
                          final bloc = context.read<AuthCubit>();
                          final params =
                              FillingOutInformationPersonalCpn.params;
                          bloc.accountRegister(params, context);
                          return;
                        }
                        errorAlert(
                          context: context,
                          message:
                              AppLocalizations.of(context)!.password_not_match,
                        );

                        break;
                      default:
                    }
                  },
                  btnColor: ThemeDataApp.instance.isLight
                      ? primaryColor
                      : theme.cardColor,
                  labelWidget: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.continue_r,
                        style: theme.textTheme.bodyMedium!.copyWith(
                          fontSize: 14.0,
                          color: lightColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 5.0),
                      Icon(
                        Icons.arrow_forward,
                        size: 18.0,
                        color: lightColor.withOpacity(0.75),
                      ),
                    ],
                  ),
                );
              }),
              ValueListenableBuilder<int>(
                valueListenable: SignUpPage.currentStep,
                builder: (context, int currentStep, child) {
                  if (currentStep == 0) return const SizedBox();
                  return const SizedBox(height: 10.00);
                },
              ),
              ValueListenableBuilder<int>(
                  valueListenable: SignUpPage.currentStep,
                  builder: (context, int current, child) {
                    if (current == 0) return const SizedBox();
                    return ButtonWidget(
                      width: size.width - 15,
                      onPressed: () async {
                        await popupAlert(
                            context: context,
                            onPressed: () {
                              SignUpPage.currentStep.value = 1;
                              AppRoutes.router.pop();
                            },
                            onCancel: () {
                              AppRoutes.router.pop();
                            },
                            message: "Bạn muốn huỷ tất cả các bước trên?");
                      },
                      btnColor: ThemeDataApp.instance.isLight
                          ? primaryColor
                          : theme.cardColor,
                      labelWidget: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.cancel,
                            style: theme.textTheme.bodyMedium!.copyWith(
                              fontSize: 14.0,
                              color: lightColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 0),
            child: Form(
              key: formKeySignUp,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          AppRoutes.router.pop();
                          // SignUpPage.reset();
                        },
                        child: Icon(
                          Icons.arrow_back,
                          size: 24.0,
                          color: theme.iconTheme.color,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              final double maxWidth = constraints.biggest.width;
                              return ValueListenableBuilder<int>(
                                valueListenable: SignUpPage.currentStep,
                                builder: (context, int currentStep, child) {
                                  final width = (maxWidth / _totalStep) *
                                      (currentStep + 1);
                                  return Stack(
                                    children: [
                                      DecoratedBox(
                                        decoration: BoxDecoration(
                                          color: theme.cardColor,
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(
                                              radiusBtn,
                                            ),
                                          ),
                                        ),
                                        child: SizedBox(
                                          height: 10.0,
                                          width: maxWidth,
                                        ),
                                      ),
                                      AnimatedContainer(
                                        duration: duration,
                                        width: width,
                                        height: 10.0,
                                        curve: curve,
                                        decoration: const BoxDecoration(
                                          color: successfullyColor,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(
                                              radiusBtn,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: verticalPadding * 2),
                    child: ValueListenableBuilder<int>(
                      valueListenable: SignUpPage.currentStep,
                      builder: (context, int currentStep, child) {
                        final text = _stepTitles[currentStep];
                        return Text(
                          text,
                          style: Theme.of(context).textTheme.titleSmall,
                        );
                      },
                    ),
                  ),
                  ValueListenableBuilder<int>(
                    valueListenable: SignUpPage.currentStep,
                    builder: (context, int currentStep, child) {
                      switch (currentStep) {
                        case 0:
                          return const EnterThePhoneCpn();
                        case 1:
                          return const EnterTheOtpCpn();
                        case 2:
                          return const FillingOutInformationPersonalCpn();
                        case 3:
                          return const SetupPasswordAvatarCpn();
                      }
                      return const SizedBox();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
