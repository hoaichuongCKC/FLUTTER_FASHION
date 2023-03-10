import 'dart:io';

import 'package:flutter_fashion/app/blocs/edit_information/edit_information_cubit.dart';
import 'package:flutter_fashion/app/presentation/personal_information/components/show_form_password.dart';
import 'package:flutter_fashion/app/presentation/personal_information/export.dart';
import 'package:flutter_fashion/app/presentation/profile/export.dart';
import 'package:flutter_fashion/core/base/api/api.dart';

class LightPersonalBody extends StatefulWidget {
  const LightPersonalBody({super.key, required this.user});
  final UserModel user;
  @override
  State<LightPersonalBody> createState() => _LightPersonalBodyState();
}

class _LightPersonalBodyState extends State<LightPersonalBody> {
  late TextEditingController fullnameController;

  late TextEditingController phoneController;

  late TextEditingController usernameController;

  late TextEditingController emailController;

  @override
  void initState() {
    fullnameController = TextEditingController(text: widget.user.fullName);
    phoneController = TextEditingController(text: widget.user.phone);
    usernameController = TextEditingController(text: widget.user.username);
    emailController = TextEditingController(text: widget.user.email);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: horizontalPadding - 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildItem(
            context,
            title: AppLocalizations.of(context)!.image,
            col: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<EditInformationCubit, EditInformationState>(
                  buildWhen: (previous, current) =>
                      previous.image != current.image,
                  builder: (context, state) {
                    final imageUrl = widget.user.photo;
                    final isImageEmpty = imageUrl.isEmpty;

                    if (isImageEmpty && state.image == null) {
                      return const UserAvatarDefault(isCamera: false);
                    }

                    if (state.image != null) {
                      final fileWidget = Image.file(
                        File(state.image!.path),
                        fit: BoxFit.cover,
                      );

                      return ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.3,
                          maxHeight: MediaQuery.of(context).size.width * 0.3,
                          minWidth: 60,
                          minHeight: 60,
                        ).normalize(),
                        child: AspectRatio(
                          aspectRatio: 1.0,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(100),
                            ),
                            child: fileWidget,
                          ),
                        ),
                      );
                    }

                    return ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.3,
                        maxHeight: MediaQuery.of(context).size.height * 0.3,
                        minWidth: 60,
                        minHeight: 60,
                      ).normalize(),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(100),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: ApiService.imageUrl + imageUrl,
                          httpHeaders: getIt<ApiService>().headers,
                          cacheKey: imageUrl,
                          fit: BoxFit.cover,
                          width: 90,
                          height: 90,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10.0),
                TextButton(
                  onPressed: () =>
                      context.read<EditInformationCubit>().onChangedImage(),
                  child: Text(
                    AppLocalizations.of(context)!.uploadFile,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 40),
          _buildItem(
            context,
            title: AppLocalizations.of(context)!.username,
            col: BlocBuilder<EditInformationCubit, EditInformationState>(
              buildWhen: (previous, current) =>
                  previous.username != current.username,
              builder: (context, state) {
                return TextFieldApp(
                  isOnchanged: state.username.isNotEmpty,
                  controller: usernameController,
                  onChanged: (value) => context
                      .read<EditInformationCubit>()
                      .onChangedUsername(value!),
                );
              },
            ),
          ),
          const SizedBox(height: 40),
          _buildItem(
            context,
            title: AppLocalizations.of(context)!.fullname,
            col: BlocBuilder<EditInformationCubit, EditInformationState>(
              buildWhen: (previous, current) =>
                  previous.fullname != current.fullname,
              builder: (context, state) {
                return TextFieldApp(
                  isOnchanged: state.fullname.isNotEmpty,
                  controller: fullnameController,
                  onChanged: (value) => context
                      .read<EditInformationCubit>()
                      .onChangedFullname(value!),
                );
              },
            ),
          ),
          const SizedBox(height: 40),
          _buildItem(
            context,
            title: AppLocalizations.of(context)!.phoneNumber,
            col: BlocBuilder<EditInformationCubit, EditInformationState>(
              buildWhen: (previous, current) => previous.phone != current.phone,
              builder: (context, state) {
                return TextFieldApp(
                  isOnchanged: state.phone.isNotEmpty,
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  onChanged: (value) => context
                      .read<EditInformationCubit>()
                      .onChangedPhone(value!),
                );
              },
            ),
          ),
          const SizedBox(height: 40),
          _buildItem(
            context,
            title: "Email",
            col: BlocBuilder<EditInformationCubit, EditInformationState>(
                buildWhen: (previous, current) =>
                    previous.email != current.email,
                builder: (context, state) {
                  return TextFieldApp(
                    isOnchanged: state.email.isNotEmpty,
                    controller: emailController,
                    onChanged: (value) => context
                        .read<EditInformationCubit>()
                        .onChangedEmail(value!),
                  );
                }),
          ),
          const SizedBox(height: 40),
          _buildItem(
            context,
            title: AppLocalizations.of(context)!.password,
            col: Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                onTap: () => showDialog(
                    context: context,
                    builder: (context) => const FormChangePassword()),
                child: Text(
                  AppLocalizations.of(context)!.changePassword,
                  style: PrimaryFont.instance.copyWith(
                    color: primaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "${AppLocalizations.of(context)!.clickOnTheParagraphThatNeedsToBeEdited}.",
            style: PrimaryFont.instance.copyWith(
              color: darkColor.withOpacity(0.5),
              fontWeight: FontWeight.w400,
              fontSize: 12.0,
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  _buildItem(BuildContext context,
          {required String title, required Widget col}) =>
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w400,
                      color: darkColor.withOpacity(0.6),
                    ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: col,
          )
        ],
      );
}
