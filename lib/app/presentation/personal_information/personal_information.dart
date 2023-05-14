import 'package:flutter_fashion/app/blocs/edit_information/edit_information_cubit.dart';
import 'package:flutter_fashion/app/presentation/personal_information/components/edit_avatar.dart';
import 'package:flutter_fashion/app/presentation/personal_information/components/email_user.dart';
import 'package:flutter_fashion/app/presentation/personal_information/components/fullname_user.dart';
import 'package:flutter_fashion/app/presentation/personal_information/components/phone_user.dart';
import 'package:flutter_fashion/app/presentation/personal_information/export.dart';

import 'components/username_user.dart';

class PersonalInformationPage extends StatelessWidget {
  const PersonalInformationPage({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider(
      create: (context) => getIt<EditInformationCubit>(),
      child: AppBackgroundBlur.normal(
        leading: Builder(builder: (context) {
          return InkWell(
            onTap: () => context
                .read<EditInformationCubit>()
                .checkWhenPopScreen(context),
            child: Icon(
              Icons.clear,
              size: 24.0,
              color: theme.iconTheme.color,
            ),
          );
        }),
        actions: [
          BlocSelector<EditInformationCubit, EditInformationState, bool>(
            selector: (state) => state.status != EditStatus.init,
            builder: (context, isDisable) {
              if (!isDisable) {
                return const SizedBox();
              }
              return ButtonWidget(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  context.read<EditInformationCubit>().onSubmit(context);
                },
                width: 100,
                height: 40,
                child: Text(
                  AppLocalizations.of(context)!.save,
                  style: PrimaryFont.instance.copyWith(
                    fontSize: 14,
                    color: lightColor,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              );
            },
          ),
        ],
        title: AppLocalizations.of(context)!.editInformation,
        child: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            return state.when(
              initial: () => const SizedBox(),
              loading: () => const SizedBox(),
              failure: (error) => const SizedBox(),
              fetchCompleted: (user) {
                return InheritedDataApp<UserModel>(
                  data: user,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: horizontalPadding - 4,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        EditAvatarCpn(),
                        FullnameUserEdit(),
                        UsernameUserEdit(),
                        PhoneUserEdit(),
                        EmailUserEdit(),
                      ],
                    ),
                  ),
                );
              },
            )!;
          },
        ),
      ),
    );
  }
}
