import 'package:flutter_fashion/app/blocs/auth/auth_cubit.dart';
import 'package:flutter_fashion/app/presentation/register/components/body.dart';
import 'package:flutter_fashion/app/presentation/register/components/header.dart';
import 'package:flutter_fashion/common/components/aurora/aurora_page.dart';

import '../../../export.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key, required this.phoneNumber});
  final String phoneNumber;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthCubit>(),
      child: AuroraBackgroundPage(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(14.0, 15.0, 14.0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeaderRegister(),
                BodyRegister(phoneNumber: phoneNumber),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
