import 'package:flutter_fashion/app/blocs/auth/auth_cubit.dart';
import 'package:flutter_fashion/app/blocs/auth_phone/auth_phone_cubit.dart';

import 'package:flutter_fashion/common/components/aurora/aurora_page.dart';
import 'package:flutter_fashion/export.dart';
import 'package:flutter_fashion/utils/alert/error.dart';
import 'package:flutter_fashion/utils/alert/pop_up.dart';
import '../sign_up/components/enter_the_otp_cpn.dart';
import '../sign_up/components/enter_the_phone_cpn.dart';
import 'components/setup_new_password.dart';

const stepForgotFirstVn = "1. Vui lòng nhập số điện thoại của bạn";
const stepForgotSecondVn = "2. Nhập mã OTP";
const stepForgotThirdVn = "3. Cập nhật mật khẩu mới";

const List<String> stepForgotTitlesVN = [
  stepForgotFirstVn,
  stepForgotSecondVn,
  stepForgotThirdVn,
];

const stepForgotFirstEn = "1. Please enter the phone number";
const stepForgotSecondEn = "2. Enter OTP code";
const stepForgotThirdEn = "3. Update new password";

const List<String> stepForgotTitlesEN = [
  stepForgotFirstEn,
  stepForgotSecondEn,
  stepForgotThirdEn,
];

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});
  static String phoneNumber = "";

  static String codeOTP = "";

  static String verificationId = "";

  static final ValueNotifier<int> currentStep = ValueNotifier<int>(0);

  static void dispose() {
    currentStep.value = 0;
  }

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  List<String> _stepTitles = [];

  final _totalStep = 3;

  @override
  void dispose() {
    ForgotPasswordPage.dispose();
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
      _stepTitles = [...stepForgotTitlesVN];
    } else {
      _stepTitles = [...stepForgotTitlesEN];
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
          child: ValueListenableBuilder<int>(
            valueListenable: ForgotPasswordPage.currentStep,
            builder: (context, int currentStep, child) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Builder(
                    builder: (context) {
                      return ButtonWidget(
                        width: size.width - 15,
                        onPressed: () {
                          if (!validateSignUp) return;
                          final bloc = context.read<AuthPhoneCubit>();
                          switch (ForgotPasswordPage.currentStep.value) {
                            case 0:
                              bloc.phoneAuth(ForgotPasswordPage.phoneNumber,
                                  context, Names.FORGOT_PASSWORD);
                              break;
                            case 1:
                              bloc.verifyOtp(
                                  ForgotPasswordPage.phoneNumber,
                                  ForgotPasswordPage.codeOTP,
                                  context,
                                  ForgotPasswordPage.verificationId);
                              break;

                            case 2:
                              if (SetupNewPasswordCpn.validate) {
                                final phone = (ForgotPasswordPage.phoneNumber);
                                final newPass = (SetupNewPasswordCpn.password);
                                final bloc = context.read<AuthCubit>();
                                bloc.forgotPassword(context, phone, newPass);
                                return;
                              }
                              errorAlert(
                                context: context,
                                message: AppLocalizations.of(context)!
                                    .password_not_match,
                              );

                              break;
                            default:
                          }
                        },
                        btnColor: ThemeDataApp.instance.isLight
                            ? primaryColor
                            : theme.cardColor,
                        labelWidget: currentStep == _totalStep - 1
                            ? Text(
                                AppLocalizations.of(context)!.update,
                                style: theme.textTheme.bodyMedium!.copyWith(
                                  fontSize: 14.0,
                                  color: lightColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            : Row(
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
                    },
                  ),
                  (currentStep == 0)
                      ? const SizedBox()
                      : const SizedBox(height: 10.00),
                  (currentStep == 0)
                      ? const SizedBox()
                      : ButtonWidget(
                          width: size.width - 15,
                          onPressed: () async {
                            await popupAlert(
                                context: context,
                                onPressed: () {
                                  ForgotPasswordPage.currentStep.value = 1;
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
                        ),
                ],
              );
            },
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
                          // ForgotPasswordPage.reset();
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
                                valueListenable: ForgotPasswordPage.currentStep,
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
                      valueListenable: ForgotPasswordPage.currentStep,
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
                    valueListenable: ForgotPasswordPage.currentStep,
                    builder: (context, int currentStep, child) {
                      switch (currentStep) {
                        case 0:
                          return const EnterThePhoneCpn(
                              payload: Names.FORGOT_PASSWORD);
                        case 1:
                          return const EnterTheOtpCpn(
                              payload: Names.FORGOT_PASSWORD);
                        case 2:
                          return const SetupNewPasswordCpn();
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
