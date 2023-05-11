import 'package:flutter_fashion/app/blocs/edit_information/edit_information_cubit.dart';
import 'package:flutter_fashion/app/presentation/personal_information/components/edit_avatar.dart';
import 'package:flutter_fashion/app/presentation/personal_information/export.dart';

import 'components/textfield_edit_infor.dart';

class PersonalInformationPage extends StatelessWidget {
  const PersonalInformationPage({super.key});
  @override
  Widget build(BuildContext context) {
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
          BlocSelector<EditInformationCubit, EditInformationState, bool>(
            selector: (state) => state.status != EditStatus.init,
            builder: (context, isDisable) {
              if (!isDisable) {
                return const SizedBox();
              }
              return InkWell(
                onTap: () {
                  if (!validateEditInformation) return;
                  context.read<EditInformationCubit>().onSubmit(context);
                },
                child: Text(
                  AppLocalizations.of(context)!.save,
                  style: PrimaryFont.instance.copyWith(
                    fontSize: 14,
                    color: primaryColor,
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
                final bloc = context.read<EditInformationCubit>();
                return InheritedDataApp<UserModel>(
                  data: user,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: horizontalPadding - 4,
                    ),
                    child: Form(
                      key: formKeyEditInformation,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const EditAvatarCpn(),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: verticalPadding),
                            child: BlocBuilder<EditInformationCubit,
                                EditInformationState>(
                              buildWhen: (previous, current) =>
                                  previous.fullname != current.fullname,
                              builder: (context, state) {
                                final isChanged = state.fullname.isNotEmpty;

                                return TextFieldEditInforWidget(
                                  title: AppLocalizations.of(context)!.fullname,
                                  label: user.fullName,
                                  prefixIcon: SvgPicture.asset(
                                    "assets/icons/user1.svg",
                                    fit: BoxFit.scaleDown,
                                  ),
                                  helperText: isChanged
                                      ? AppLocalizations.of(context)!
                                          .theAboveTextHasBeenEdited
                                      : null,
                                  onChanged: (value) =>
                                      bloc.onChangedFullname(value),
                                  validator: (p0) {
                                    if (p0!.isEmpty && isChanged) {
                                      return "Invalid form";
                                    }
                                    return null;
                                  },
                                );
                              },
                            ),
                          ),
                          BlocBuilder<EditInformationCubit,
                              EditInformationState>(
                            buildWhen: (p, c) => p.username != c.username,
                            builder: (context, state) {
                              final isChanged = state.username.isNotEmpty;
                              return TextFieldEditInforWidget(
                                title: AppLocalizations.of(context)!.username,
                                label: user.username,
                                prefixIcon: SvgPicture.asset(
                                  "assets/icons/user1.svg",
                                  fit: BoxFit.scaleDown,
                                ),
                                helperText: isChanged
                                    ? AppLocalizations.of(context)!
                                        .theAboveTextHasBeenEdited
                                    : null,
                                onChanged: (value) =>
                                    bloc.onChangedUsername(value),
                                validator: (p0) {
                                  if (p0!.isEmpty && isChanged) {
                                    return "Invalid form";
                                  }
                                  return null;
                                },
                              );
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: verticalPadding),
                            child: BlocBuilder<EditInformationCubit,
                                EditInformationState>(
                              buildWhen: (p, c) => p.phone != c.phone,
                              builder: (context, state) {
                                final isChanged = state.phone.isNotEmpty;
                                return TextFieldEditInforWidget(
                                  title:
                                      AppLocalizations.of(context)!.phoneNumber,
                                  label: user.phone.isEmpty
                                      ? "Vui lòng cập nhật số điện thoại"
                                      : user.phone,
                                  prefixIcon: const Icon(
                                    Icons.phone,
                                    size: 24.0,
                                    color: darkColor,
                                  ),
                                  labelStyle: user.phone.isNotEmpty
                                      ? Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            fontWeight: FontWeight.w500,
                                          )
                                      : Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 10.0,
                                            color: errorColor,
                                          ),
                                  helperText: isChanged
                                      ? AppLocalizations.of(context)!
                                          .theAboveTextHasBeenEdited
                                      : null,
                                  onChanged: (value) =>
                                      bloc.onChangedPhone(value),
                                  validator: (p0) {
                                    if (p0!.isEmpty && isChanged) {
                                      return "Invalid form";
                                    }
                                    return null;
                                  },
                                );
                              },
                            ),
                          ),
                          BlocBuilder<EditInformationCubit,
                              EditInformationState>(
                            buildWhen: (p, c) => p.email != c.email,
                            builder: (context, state) {
                              final isChanged = state.email.isNotEmpty;
                              return TextFieldEditInforWidget(
                                title: "Email",
                                label: user.email,
                                prefixIcon: const Icon(
                                  Icons.email,
                                  size: 24.0,
                                  color: darkColor,
                                ),
                                helperText: isChanged
                                    ? AppLocalizations.of(context)!
                                        .theAboveTextHasBeenEdited
                                    : null,
                                onChanged: (value) {
                                  bloc.onChangedEmail(value);
                                  if (validateEditInformation) return;
                                },
                                validator: (p0) {
                                  if (p0!.isEmpty && isChanged) {
                                    return "Invalid form";
                                  }
                                  if (!p0.isValidEmail() && isChanged) {
                                    return "Email invalid";
                                  }
                                  return null;
                                },
                              );
                            },
                          ),
                        ],
                      ),
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
