import 'package:flutter_fashion/app/blocs/auth/auth_cubit.dart';
import 'package:flutter_fashion/app/presentation/login/export.dart';

import '../../../../config/svg_files.dart';

class FooterLogin extends StatelessWidget {
  const FooterLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
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
                  style: theme.bodySmall,
                ),
              ),
            ),
            const Expanded(flex: 3, child: Divider(color: lightColor)),
          ],
        ),
        const SizedBox(height: 20.0),
        ButtonWidget(
          height: 45.0,
          background: lightColor,
          elevation: 0.0,
          onPressed: () => context.read<AuthCubit>().authGoogle(context),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FractionallySizedBox(
                heightFactor: 0.8,
                child: SvgPicture.asset(
                  Assets.googleSVG,
                  width: 35.0,
                  height: 35.0,
                ),
              ),
              const SizedBox(width: 15.0),
              Align(
                child: Text(
                  AppLocalizations.of(context)!.continueWithGoogle,
                  style: PrimaryFont.instance.copyWith(
                    fontSize: 14.0,
                    color: blackColor,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
