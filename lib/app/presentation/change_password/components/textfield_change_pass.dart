import '../../../../export.dart';

class TextFieldChangePasswordWidget extends StatefulWidget {
  const TextFieldChangePasswordWidget(
      {super.key,
      required this.hintText,
      this.controller,
      required this.iconUrl,
      required this.onChanged});

  final String hintText;
  final String iconUrl;
  final TextEditingController? controller;
  final Function(String) onChanged;

  @override
  State<TextFieldChangePasswordWidget> createState() =>
      _ShowInputPasswordState();
}

class _ShowInputPasswordState extends State<TextFieldChangePasswordWidget> {
  ValueNotifier<bool> notifier = ValueNotifier<bool>(true);
  @override
  void dispose() {
    notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ValueListenableBuilder<bool>(
      valueListenable: notifier,
      builder: (context, bool isVisibility, child) {
        return TextFormField(
          controller: widget.controller,
          obscureText: isVisibility,
          style: theme.textTheme.bodyMedium!.copyWith(
            fontSize: 12.0,
            wordSpacing: 5,
          ),
          onChanged: (value) => widget.onChanged(value),
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.name,
          validator: (value) {
            if (value!.isEmpty) {
              return "Invalid form";
            }
            if (!value.isValidPassword) {
              return AppLocalizations.of(context)!.text_validate_valid_pass;
            }
            return null;
          },
          decoration: InputDecoration(
            filled: true,
            errorMaxLines: 3,
            fillColor: theme.inputDecorationTheme.fillColor,
            hintText: widget.hintText,
            isDense: true,
            suffixIconConstraints: const BoxConstraints(
              minHeight: 20.0,
              maxHeight: 50.0,
              minWidth: 20.0,
              maxWidth: 50.0,
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7.0),
              child: InkWell(
                onTap: () => notifier.value = !isVisibility,
                customBorder: const CircleBorder(),
                child: SvgPicture.asset(
                  isVisibility
                      ? "assets/icons/eye.svg"
                      : "assets/icons/eye_off.svg",
                  fit: BoxFit.scaleDown,
                  width: 24.0,
                  height: 24.0,
                  // ignore: deprecated_member_use
                  color: primaryColor,
                ),
              ),
            ),
            prefixIconConstraints: const BoxConstraints(
              minHeight: 20.0,
              maxHeight: 50.0,
              minWidth: 20.0,
              maxWidth: 50.0,
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: SvgPicture.asset(
                widget.iconUrl,
                fit: BoxFit.scaleDown,
                width: 24.0,
                height: 24.0,
              ),
            ),
            hintStyle: theme.inputDecorationTheme.hintStyle,
          ),
        );
      },
    );
  }
}
