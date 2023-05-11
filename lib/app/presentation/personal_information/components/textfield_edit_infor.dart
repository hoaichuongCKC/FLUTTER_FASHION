import '../../../../export.dart';

class TextFieldEditInforWidget extends StatefulWidget {
  const TextFieldEditInforWidget({
    super.key,
    required this.onChanged,
    this.keyboardType = TextInputType.name,
    this.textInputAction = TextInputAction.next,
    required this.label,
    this.helperText,
    this.prefixIcon,
    this.labelStyle,
    required this.title,
    this.validator,
  });
  final String title;

  final void Function(String) onChanged;

  final TextInputType? keyboardType;

  final TextInputAction? textInputAction;

  final String label;

  final String? helperText;

  final Widget? prefixIcon;

  final TextStyle? labelStyle;

  final String? Function(String?)? validator;

  @override
  State<TextFieldEditInforWidget> createState() =>
      _TextFieldEditInforWidgetState();
}

class _TextFieldEditInforWidgetState extends State<TextFieldEditInforWidget> {
  late ValueNotifier<bool> _isShowIconClear;

  @override
  void initState() {
    super.initState();
    _isShowIconClear = ValueNotifier<bool>(false);
  }

  @override
  void dispose() {
    _isShowIconClear.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderColor = disableDarkColor;
    final backgroundColor = lightColor.withOpacity(0.6);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: theme.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8.0),
        TextFormField(
          onChanged: widget.onChanged,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          style: theme.textTheme.bodySmall!.copyWith(
            fontSize: 14.0,
          ),
          validator: widget.validator,
          decoration: InputDecoration(
            filled: true,
            fillColor: backgroundColor,
            labelText: widget.label,
            labelStyle: widget.labelStyle ?? theme.textTheme.bodySmall!,
            helperText: widget.helperText,
            helperStyle: theme.textTheme.bodySmall!.copyWith(
              color: successfullyColor,
              fontSize: 10.0,
              fontWeight: FontWeight.w800,
            ),
            prefixIcon: widget.prefixIcon,
            border: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor),
              borderRadius: const BorderRadius.all(
                Radius.circular(radiusBtn),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor),
              borderRadius: const BorderRadius.all(
                Radius.circular(radiusBtn),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor),
              borderRadius: const BorderRadius.all(
                Radius.circular(radiusBtn),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
