import 'dart:io';

import 'package:flutter_fashion/app/blocs/edit_information/edit_information_cubit.dart';
import 'package:flutter_fashion/app/presentation/personal_information/components/show_form_password.dart';
import 'package:flutter_fashion/app/presentation/personal_information/export.dart';
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
    return Column(
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
                  if (state.image != null) {
                    final fileWidget = Image.file(
                      File(state.image!.path),
                      fit: BoxFit.cover,
                    );
                    return ConstrainedBoxWidget(
                      currentHeight: .2,
                      maxHeight: 100,
                      minHeight: 90,
                      maxWidth: 100,
                      minWidth: 90,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(100),
                        ),
                        child: fileWidget,
                      ),
                    );
                  }
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: disablePrimaryColor,
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(
                          ApiService.imageUrl + widget.user.image.url,
                          headers: getIt<ApiService>().headers,
                          cacheKey: widget.user.image.url,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: const ConstrainedBoxWidget(
                      currentHeight: .2,
                      maxHeight: 100,
                      minHeight: 90,
                      maxWidth: 100,
                      minWidth: 90,
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
              return TextFiledPICustom(
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
                return TextFiledPICustom(
                  isOnchanged: state.fullname.isNotEmpty,
                  controller: fullnameController,
                  onChanged: (value) => context
                      .read<EditInformationCubit>()
                      .onChangedFullname(value!),
                );
              }),
        ),
        const SizedBox(height: 40),
        _buildItem(
          context,
          title: AppLocalizations.of(context)!.phoneNumber,
          col: BlocBuilder<EditInformationCubit, EditInformationState>(
              buildWhen: (previous, current) => previous.phone != current.phone,
              builder: (context, state) {
                return TextFiledPICustom(
                  isOnchanged: state.phone.isNotEmpty,
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  onChanged: (value) => context
                      .read<EditInformationCubit>()
                      .onChangedPhone(value!),
                );
              }),
        ),
        const SizedBox(height: 40),
        _buildItem(
          context,
          title: "Email",
          col: BlocBuilder<EditInformationCubit, EditInformationState>(
              buildWhen: (previous, current) => previous.email != current.email,
              builder: (context, state) {
                return TextFiledPICustom(
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
