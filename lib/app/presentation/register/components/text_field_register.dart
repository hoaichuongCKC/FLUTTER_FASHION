// ignore_for_file: deprecated_member_use

import '../../../../export.dart';

class TextFormFieldRegister extends StatefulWidget {
  const TextFormFieldRegister(
      {super.key,
      required this.controller,
      this.keyboardType,
      required this.onChanged,
      this.hintText,
      this.prefixIcon,
      required this.labelText,
      this.subFixIcon,
      this.isobscureText = false,
      this.textInputAction = TextInputAction.next,
      this.validator});
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String? hintText;
  final Function(String?) onChanged;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Widget? subFixIcon;
  final Widget labelText;
  final bool isobscureText;
  final TextInputAction? textInputAction;
  @override
  State<TextFormFieldRegister> createState() => _TextFormFieldRegisterState();
}

class _TextFormFieldRegisterState extends State<TextFormFieldRegister> {
  TextEditingController get _controller => widget.controller;

  bool _isVisibility = true;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.labelText,
        const SizedBox(height: 5.0),
        TextFormField(
          key: ValueKey(widget.hintText),
          validator: widget.validator ??
              (value) {
                if (value!.isEmpty) {
                  return "Invalid form";
                }
                return null;
              },
          controller: _controller,
          obscureText: widget.isobscureText ? _isVisibility : false,
          textInputAction: widget.textInputAction,
          onChanged: (value) => widget.onChanged(value),
          keyboardType: widget.keyboardType,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontWeight: FontWeight.w500),
          decoration: InputDecoration(
            hintText: widget.hintText ?? "",
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.isobscureText
                ? InkWell(
                    onTap: () {
                      _isVisibility = !_isVisibility;
                      setState(() {});
                    },
                    child: SvgPicture.asset(
                      _isVisibility
                          ? "assets/icons/eye.svg"
                          : "assets/icons/eye_off.svg",
                      fit: BoxFit.scaleDown,
                      color: primaryColor,
                    ),
                  )
                : null,
            isDense: true,
            filled: true,
            fillColor: lightColor,
          ),
        ),
      ],
    );
  }
}
