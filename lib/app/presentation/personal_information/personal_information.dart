import 'package:flutter_fashion/app/blocs/edit_information/edit_information_cubit.dart';
import 'package:flutter_fashion/app/presentation/personal_information/export.dart';

class PersonalInformationPage extends StatelessWidget {
  const PersonalInformationPage({super.key});
  @override
  Widget build(BuildContext context) {
    final isLight = Brightness.light == Theme.of(context).brightness;
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
              color: Theme.of(context).iconTheme.color,
            ),
          );
        }),
        actions: [
          BlocBuilder<EditInformationCubit, EditInformationState>(
            builder: (context, state) {
              bool isDisable = true;
              if (state.status != EditStatus.init) {
                isDisable = false;
              }
              return InkWell(
                onTap: isDisable
                    ? null
                    : () =>
                        context.read<EditInformationCubit>().onSubmit(context),
                child: Text(
                  AppLocalizations.of(context)!.edit,
                  style: PrimaryFont.instance.copyWith(
                    fontSize: 14,
                    color: isDisable ? disableDarkColor : darkColor,
                    fontWeight: isDisable ? FontWeight.w300 : FontWeight.w400,
                  ),
                ),
              );
            },
          ),
        ],
        title: AppLocalizations.of(context)!.editInformation,
        child: isLight
            ? BlocBuilder<UserCubit, UserState>(
                builder: (context, state) {
                  return state.whenOrNull(
                    fetchCompleted: (user) => LightPersonalBody(user: user),
                  )!;
                },
              )
            : const SizedBox(),
      ),
    );
  }
}
