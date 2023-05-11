import 'package:flutter_fashion/app/blocs/edit_information/edit_information_cubit.dart';
import 'package:flutter_fashion/app/presentation/profile/export.dart';
import 'package:flutter_fashion/common/components/app/background_app.dart';

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
          create: (context) => getIt<EditInformationCubit>(),
        ),
      ],
      child: WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: Builder(
          builder: (context) {
            return AppBackgroundBlur.withAppBar(
              autoLeading: false,
              title: AppLocalizations.of(context)!.profile,
              child: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: BlocBuilder<UserCubit, UserState>(
                    builder: (context, state) {
                      return state.when(
                        initial: () => const SizedBox(),
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                        fetchCompleted: (user) => InheritedDataApp(
                          data: user,
                          child: const ProfileBody(),
                        ),
                        failure: (error) => Center(
                          child: Text(error),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
