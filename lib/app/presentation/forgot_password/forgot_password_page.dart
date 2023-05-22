import 'package:flutter_fashion/app/blocs/auth/auth_cubit.dart';
import 'package:flutter_fashion/app/blocs/auth_phone/auth_phone_cubit.dart';
import 'package:flutter_fashion/export.dart';
import '../sign_up/components/enter_the_otp_cpn.dart';
import '../sign_up/components/enter_the_phone_cpn.dart';
import '../sign_up/cubit/sign_up_cubit.dart';
import 'components/button_submit_fg.dart';
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

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  List<String> _stepTitles = [];

  final _totalStep = 3;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
        BlocProvider(
          create: (context) => SignUpUICubit(0),
        ),
      ],
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: horizontalPadding - 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          AppRoutes.router.go(Routes.LOGIN);
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
                              return BlocBuilder<SignUpUICubit, int>(
                                builder: (context, step) {
                                  final width =
                                      (maxWidth / _totalStep) * (step + 1);
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
                    child: BlocBuilder<SignUpUICubit, int>(
                      builder: (context, step) {
                        final text = _stepTitles[step];
                        return Text(
                          text,
                          style: Theme.of(context).textTheme.titleSmall,
                        );
                      },
                    ),
                  ),
                  BlocBuilder<SignUpUICubit, int>(
                    builder: (context, step) {
                      switch (step) {
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
                  const Spacer(),
                  const ButtonSubmitForgot(),
                  const SizedBox(height: 15.0),
                  // const SubmitSignUp(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
