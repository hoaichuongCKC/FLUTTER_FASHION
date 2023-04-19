import 'package:flutter_fashion/app/blocs/auth/auth_cubit.dart';
import 'package:flutter_fashion/app/presentation/register/components/choose_avatar.dart';
import 'package:flutter_fashion/app/presentation/register/components/text_field_register.dart';
import 'package:flutter_fashion/core/base/params/register.dart';
import 'package:flutter_fashion/export.dart';
import 'package:flutter_fashion/utils/alert/error.dart';
import 'package:image_picker/image_picker.dart';

class BodyRegister extends StatefulWidget {
  const BodyRegister({super.key, required this.phoneNumber});
  final String phoneNumber;
  @override
  State<BodyRegister> createState() => _BodyRegisterState();
}

class _BodyRegisterState extends State<BodyRegister> {
  final usernameController = TextEditingController();

  final fullnameController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmController = TextEditingController();

  late TextEditingController _phoneController;

  final _formkey = GlobalKey<FormState>();

  XFile? _file;

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController(text: widget.phoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ChooseAvatar(
            onTap: (imageWidget, file) {
              _file = file;

              setState(() {});
            },
          ),
          const SizedBox(height: 15.0),
          TextFormFieldRegister(
            controller: usernameController,
            keyboardType: TextInputType.name,
            hintText: AppLocalizations.of(context)!
                .enter_the(AppLocalizations.of(context)!.username)
                .toBeginningOfSentenceCase(),
            prefixIcon: SvgPicture.asset(
              "assets/icons/user_outline.svg",
              fit: BoxFit.scaleDown,
            ),
            onChanged: (value) {},
            labelText: Text(
              "${AppLocalizations.of(context)!.username}(*)",
              style: PrimaryFont.instance.copyWith(
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(height: 15.0),
          TextFormFieldRegister(
            controller: fullnameController,
            keyboardType: TextInputType.name,
            hintText: AppLocalizations.of(context)!
                .enter_the(AppLocalizations.of(context)!.fullname)
                .toBeginningOfSentenceCase(),
            labelText: Text(
              "${AppLocalizations.of(context)!.fullname}(*)",
              style: PrimaryFont.instance.copyWith(
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            prefixIcon: SvgPicture.asset(
              "assets/icons/user_outline.svg",
              fit: BoxFit.scaleDown,
            ),
            onChanged: (value) {},
          ),
          const SizedBox(height: 15.0),
          TextFormFieldRegister(
            readOnly: true,
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            hintText: AppLocalizations.of(context)!
                .enter_the(AppLocalizations.of(context)!.phoneNumber)
                .toBeginningOfSentenceCase(),
            prefixIcon: SvgPicture.asset(
              "assets/icons/phone.svg",
              fit: BoxFit.scaleDown,
            ),
            onChanged: (value) {},
            labelText: Text(
              "${AppLocalizations.of(context)!.phoneNumber}(*)",
              style: PrimaryFont.instance.copyWith(
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(height: 15.0),
          TextFormFieldRegister(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            hintText: AppLocalizations.of(context)!.enter_the("email"),
            labelText: Text(
              'Email(*)',
              style: PrimaryFont.instance.copyWith(
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            prefixIcon: SvgPicture.asset(
              "assets/icons/email.svg",
              fit: BoxFit.scaleDown,
            ),
            onChanged: (value) {},
            validator: (p0) {
              if (p0!.isEmpty) {
                return "Do not empty";
              }
              if (!p0.isValidEmail()) {
                return "Invalid email";
              }
              return null;
            },
          ),
          const SizedBox(height: 15.0),
          TextFormFieldRegister(
            controller: passwordController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.name,
            hintText: AppLocalizations.of(context)!
                .enter_the(AppLocalizations.of(context)!.password)
                .toBeginningOfSentenceCase(),
            labelText: Text(
              "${AppLocalizations.of(context)!.password}(*)",
              style: PrimaryFont.instance.copyWith(
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            isobscureText: true,
            prefixIcon: SvgPicture.asset(
              "assets/icons/lock.svg",
              fit: BoxFit.scaleDown,
            ),
            onChanged: (value) {},
          ),
          const SizedBox(height: 15.0),
          TextFormFieldRegister(
            controller: confirmController,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.done,
            hintText: AppLocalizations.of(context)!
                .enter_the(AppLocalizations.of(context)!.confirmPassword)
                .toBeginningOfSentenceCase(),
            labelText: Text(
              "${AppLocalizations.of(context)!.confirmPassword}(*)",
              style: PrimaryFont.instance.copyWith(
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            isobscureText: true,
            prefixIcon: SvgPicture.asset(
              "assets/icons/lock.svg",
              fit: BoxFit.scaleDown,
            ),
            onChanged: (value) {},
          ),
          const SizedBox(height: 20.0),
          ButtonWidget(
            btnColor: primaryColor,
            onPressed: () {
              if (!_formkey.currentState!.validate()) {
                return;
              }

              if (_file == null) {
                errorAlert(
                    context: context,
                    message:
                        AppLocalizations.of(context)!.please_choose_avatar);
                return;
              }

              if (passwordController.text != confirmController.text) {
                errorAlert(
                    context: context,
                    message: AppLocalizations.of(context)!.password_not_match);
                return;
              }

              final param = RegisterParams(
                username: usernameController.text,
                fullname: fullnameController.text,
                phone: widget.phoneNumber,
                email: emailController.text,
                password: passwordController.text,
                image: _file!,
              );
              context.read<AuthCubit>().accountRegister(param, context);
            },
            label: AppLocalizations.of(context)!.completed,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.07),
        ],
      ),
    );
  }
}
