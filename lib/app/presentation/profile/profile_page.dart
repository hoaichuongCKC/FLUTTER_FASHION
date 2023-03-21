import 'package:flutter_fashion/app/blocs/edit_information/edit_information_cubit.dart';
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
            return ProfileBackgroundPage(
              appBar: AppBar(
                systemOverlayStyle: SystemUiOverlayStyle.dark,
                backgroundColor: Colors.transparent,
                title: Text(
                  AppLocalizations.of(context)!.profile,
                  style: Theme.of(context).textTheme.titleSmall,
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
            );
          },
        ),
      ),
    );
  }
}
