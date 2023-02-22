import 'package:flutter_fashion/app/blocs/edit_information/edit_information_cubit.dart';
import 'package:flutter_fashion/app/presentation/personal_information/export.dart';

class PersonalInformationPage extends StatelessWidget {
  const PersonalInformationPage({super.key});
  @override
  Widget build(BuildContext context) {
    final isLight = Brightness.light == Theme.of(context).brightness;
    return BlocProvider(
      create: (context) => getIt<EditInformationCubit>(),
      child: BaseAppBackground(
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
              Color color = primaryColor.withOpacity(0.6);
              bool isDisable = true;
              if ((state.status != EditStatus.init)) {
                color = primaryColor;
                isDisable = false;
              }
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: const BorderRadius.all(Radius.circular(7.0)),
                ),
                child: InkWell(
                  onTap: isDisable
                      ? null
                      : () => context
                          .read<EditInformationCubit>()
                          .onSubmit(context),
                  child: const SizedBox(
                    width: 40,
                    height: 35.0,
                    child: Icon(
                      Icons.check,
                      size: 25.0,
                      color: lightColor,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
        isScrollScreen: true,
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
