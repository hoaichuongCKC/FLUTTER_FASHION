import 'package:flutter_fashion/app/presentation/profile/export.dart';
import 'package:flutter_fashion/app/presentation/profile/profile_data.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<AuthCubit>(),
        ),
      ],
      child: BlocProvider(
        lazy: false,
        create: (context) => getIt<UserCubit>()..call(UserEvent.fetchUser),
        child: WillPopScope(
          onWillPop: () async {
            return true;
          },
          child: ProfileBackgroundPage(
            appBar: AppBar(
              systemOverlayStyle: SystemUiOverlayStyle.dark,
              backgroundColor: Colors.transparent,
              title: Text(
                AppLocalizations.of(context)!.profile,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              actions: [
                Builder(builder: (ncontext) {
                  return IconButton(
                    onPressed: () {
                      ncontext
                          .read<AuthCubit>()
                          .call(AuthEvent.loggout, context: ncontext);
                      ncontext.read<UserCubit>().call(UserEvent.init);
                    },
                    icon: SvgPicture.asset("assets/icons/logout.svg"),
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
              child: RefreshIndicator(
                onRefresh: () async {},
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  child: BlocBuilder<UserCubit, UserState>(
                    builder: (context, state) {
                      return state.when(
                        initial: () => const SizedBox(),
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                        fetchCompleted: (data) =>
                            ProfileData(data, child: const ProfileBody()),
                        failure: (error) => Center(
                          child: Text(error),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
