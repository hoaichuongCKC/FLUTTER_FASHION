import 'package:flutter_fashion/app/blocs/auth/auth_cubit.dart';
import 'package:flutter_fashion/app/presentation/login/export.dart';

class FooterLogin extends StatelessWidget {
  const FooterLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            const Expanded(flex: 3, child: Divider(color: lightColor)),
            Expanded(
              child: Align(
                child: Text(
                  AppLocalizations.of(context)!.or,
                  style: PrimaryFont.instance.copyWith(
                    fontSize: 14.0,
                    color: lightColor,
                  ),
                ),
              ),
            ),
            const Expanded(flex: 3, child: Divider(color: lightColor)),
          ],
        ),
        const SizedBox(height: 20.0),
        ButtonWidget(
          animate: true,
          onPressed: () => context.read<AuthCubit>().authGoogle(context),
          btnColor: lightColor,
          boxShadow: [
            BoxShadow(
              color: darkColor.withOpacity(0.3),
              offset: const Offset(2, 4),
              blurRadius: 10,
            ),
          ],
          labelWidget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/icons/google.svg",
                width: 35.0,
                height: 35.0,
              ),
              const SizedBox(width: 15.0),
              Text(
                AppLocalizations.of(context)!.continueWithGoogle,
                style: PrimaryFont.instance.copyWith(
                  fontSize: 16.0,
                  color: darkColor,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
