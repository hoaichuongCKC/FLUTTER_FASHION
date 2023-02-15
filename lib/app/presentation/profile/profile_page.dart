import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fashion/app/blocs/auth/auth_cubit.dart';
import 'package:flutter_fashion/app/blocs/auth/auth_event.dart';
import 'package:flutter_fashion/app/blocs/user/user_cubit.dart';
import 'package:flutter_fashion/app/blocs/user/user_event.dart';
import 'package:flutter_fashion/app/presentation/profile/export.dart';
import 'package:flutter_fashion/dependency_injection.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<AuthCubit>(),
        ),
        BlocProvider(
          create: (context) =>
              getIt<UserCubit>()..handleEvent(UserEvent.fetchUser),
        ),
      ],
      child: ScreenBackground(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          backgroundColor: Colors.transparent,
          title: Text(
            'Hồ sơ',
            style: PrimaryFont.instance.big(),
          ),
          actions: [
            Builder(builder: (ncontext) {
              return Padding(
                padding: const EdgeInsets.only(right: 14.0),
                child: InkWell(
                  onTap: () => ncontext
                      .read<AuthCubit>()
                      .call(AuthEvent.loggout, context: ncontext),
                  child: SvgPicture.asset("assets/icons/logout.svg"),
                ),
              );
            }),
          ],
        ),
        floatingActionButton: InkWell(
          // onTap: () => context
          //   .read<AuthCubit>()
          //    .call(AuthEvent.loggout, context: context),
          borderRadius: const BorderRadius.all(Radius.circular(radiusBtn)),
          customBorder: const CircleBorder(),
          child: SizedBox(
            width: 65,
            height: 65,
            child: Stack(
              fit: StackFit.expand,
              children: [
                SvgPicture.asset("assets/icons/profile/float_btn.svg"),
                Align(child: SvgPicture.asset("assets/icons/edit.svg")),
              ],
            ),
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 100.0,
                    minHeight: 80,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: const [
                      UserAvatarApp(
                          imageUrl: "assets/images/avatar_user_fake.jpg"),
                      SizedBox(width: 10.0),
                      UserInformation()
                    ],
                  ),
                ),
                const BuildFrameFeature(),
                const OrderHistory(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
