import 'package:flutter_fashion/app/blocs/auth_phone/auth_phone_cubit.dart';
import 'package:flutter_fashion/app/blocs/auth/auth_cubit.dart';
import 'package:flutter_fashion/app/presentation/sign_up/components/button_submit.dart';
import 'package:flutter_fashion/app/presentation/sign_up/components/enter_the_otp_cpn.dart';
import 'package:flutter_fashion/app/presentation/sign_up/components/enter_the_phone_cpn.dart';
import 'package:flutter_fashion/app/presentation/sign_up/components/filling_out_information_personal.dart';
import 'package:flutter_fashion/app/presentation/sign_up/components/setup_password_avatar.dart';
import 'package:flutter_fashion/export.dart';

import 'cubit/sign_up_cubit.dart';

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

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  List<String> _stepTitles = [];

  final _totalStep = 4;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
        BlocProvider(
          create: (context) => SignUpUICubit(0),
        ),
      ],
      child: BlocListener<AuthPhoneCubit, AuthPhoneState>(
        listener: (context, state) {
          if (state == const AuthPhoneState.error()) {
            const String msg = "SOMETHING WRONG";

            showErrorToast(msg);
          }
        },
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            AppRoutes.router.go(Routes.LOGIN);
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
                                final double maxWidth =
                                    constraints.biggest.width;
                                return BlocBuilder<SignUpUICubit, int>(
                                  builder: (context, step) {
                                    final width =
                                        (maxWidth / _totalStep) * (step + 1);
                                    return Stack(
                                      children: [
                                        DecoratedBox(
                                          decoration: BoxDecoration(
                                            color: theme.cardColor,
                                            borderRadius:
                                                const BorderRadius.all(
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
                          vertical: verticalPadding * 1.5),
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
                    const Spacer(),
                    const SubmitSignUp(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
