import 'dart:developer';

import 'package:flutter_fashion/export.dart';

import '../../config/svg_files.dart';

class TextFormFieldApp extends StatefulWidget {
  const TextFormFieldApp({
    super.key,
    required this.title,
    this.onChanged,
    this.keyboardType,
    this.textInputAction,
    this.validator,
    this.hintText,
    this.inputFormatter,
    this.obscureText = false,
    this.readOnly = false,
    this.prefixIcon,
    this.titleWidget,
    this.text,
  });

  final String title;

  final String? text;

  final Widget? titleWidget;

  final void Function(String)? onChanged;

  final TextInputType? keyboardType;

  final TextInputAction? textInputAction;

  final String? Function(String?)? validator;

  final String? hintText;

  final bool obscureText;

  final List<TextInputFormatter>? inputFormatter;

  final bool readOnly;

  final Widget? prefixIcon;

  @override
  State<TextFormFieldApp> createState() => _TextFormFieldAppState();
}

class _TextFormFieldAppState extends State<TextFormFieldApp> {
  String get _title => widget.title;

  String? get _text => widget.text;

  void Function(String) get onChanged => widget.onChanged!;

  TextInputType? get keyboardType => widget.keyboardType;

  TextInputAction? get textInputAction => widget.textInputAction;

  String? Function(String?)? get validator => widget.validator;

  String? get hintText => widget.hintText;

  Widget? get _titleWidget => widget.titleWidget;

  bool get obscureText => widget.obscureText;

  bool get _readOnly => widget.readOnly;

  Widget? get _prefixIcon => widget.prefixIcon;

  List<TextInputFormatter>? get _inputFormatters => widget.inputFormatter;

  late TextEditingController _controller;

  late ValueNotifier<bool> _clearIcon;

  ValueNotifier<bool>? _eyeIcon;

  Widget? _icon;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController.fromValue(
      TextEditingValue(text: _text ?? ""),
    )..addListener(_listenText);
    _clearIcon = ValueNotifier(false);

    _initIcon();
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller.removeListener(_listenText);
    _clearIcon.dispose();

    if (_eyeIcon != null) {
      _eyeIcon?.dispose();
    }

    super.dispose();
  }

  @override
  void didUpdateWidget(TextFormFieldApp oldWidget) {
    log("===========================DidUpdateWidget======================");
    if (_text != null) {
      if (oldWidget.text != _text) {
        _clearIcon.value = false;
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  _listenText() {
    final text = _controller.text;
    if (!_clearIcon.value && text.isNotEmpty) {
      _clearIcon.value = true;
    } else if (_clearIcon.value && text.isEmpty) {
      _clearIcon.value = false;
    }
  }

  _clearButton() {
    _controller.clear();
    _clearIcon.value = false;
  }

  _initIcon() {
    _eyeIcon = ValueNotifier(obscureText);
    if (obscureText) {
      _icon = ValueListenableBuilder<bool>(
        valueListenable: _eyeIcon!,
        builder: (context, bool isVisibility, child) {
          return InkWell(
            onTap: () {
              _eyeIcon?.value = !isVisibility;
            },
            child: SvgPicture.asset(
              isVisibility ? Assets.eyeSVG : Assets.eyeOffSVG,
              fit: BoxFit.scaleDown,
              width: 20.0,
              height: 20.0,
              colorFilter: const ColorFilter.mode(
                secondaryColor,
                BlendMode.srcIn,
              ),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final textTheme = theme.textTheme;

    final inputDecorationTheme = theme.inputDecorationTheme;

    final suffixIcon = InkWell(
      onTap: _clearButton,
      child: FractionallySizedBox(
        heightFactor: 0.7,
        child: SvgPicture.asset(
          Assets.removeCircleSVG,
          colorFilter: ColorFilter.mode(
            ThemeDataApp.instance.isLight ? blackColor : lightColor,
            BlendMode.srcIn,
          ),
        ),
      ),
    );

    return ConstrainedBoxWidget(
      currentHeight: 0.1,
      maxHeight: 80,
      minHeight: 65.0,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 14.0),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(radiusBtn / 2),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _prefixIcon ?? const SizedBox(),
                _prefixIcon == null
                    ? const SizedBox()
                    : const SizedBox(width: 5.0),
                ValueListenableBuilder<bool>(
                  valueListenable: _clearIcon,
                  builder: (context, bool isVisibility, child) {
                    return Text(
                      _title,
                      style: textTheme.bodySmall!.copyWith(
                        fontSize: 10,
                        color: isVisibility
                            ? darkColor
                            : _readOnly
                                ? darkColor
                                : textDisable,
                        fontWeight: isVisibility
                            ? FontWeight.w600
                            : _readOnly
                                ? FontWeight.w600
                                : FontWeight.w400,
                      ),
                    );
                  },
                ),
                _titleWidget != null
                    ? const SizedBox(width: 5.0)
                    : const SizedBox(),
                _titleWidget ?? const SizedBox(),
              ],
            ),
            const Spacer(),
            Expanded(
              flex: 3,
              child: !obscureText
                  ? _buildNotFormEye(
                      textTheme, inputDecorationTheme, suffixIcon)
                  : _buildFormEye(textTheme, inputDecorationTheme, suffixIcon),
            ),
          ],
        ),
      ),
    );
  }

  ValueListenableBuilder<bool> _buildFormEye(TextTheme textTheme,
      InputDecorationTheme inputDecorationTheme, InkWell suffixIcon) {
    return ValueListenableBuilder<bool>(
      valueListenable: _eyeIcon!,
      builder: (context, bool isVisibility, child) {
        return TextFormField(
          obscureText: isVisibility,
          inputFormatters: _inputFormatters,
          controller: _controller,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          onChanged: onChanged,
          validator: validator,
          style: textTheme.bodyMedium!.copyWith(
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            isDense: inputDecorationTheme.isDense,
            prefixIconColor: darkColor,
            hintText: hintText,
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            hintStyle: inputDecorationTheme.hintStyle,
            contentPadding: ThemeDataApp.instance.isLight
                ? EdgeInsets.zero
                : const EdgeInsets.all(5.0),
            icon: _icon,
            suffixIcon: ValueListenableBuilder<bool>(
              valueListenable: _clearIcon,
              builder: (context, bool isVisibility, child) {
                if (!isVisibility) return const SizedBox();
                return suffixIcon;
              },
            ),
          ),
        );
      },
    );
  }

  TextFormField _buildNotFormEye(TextTheme textTheme,
      InputDecorationTheme inputDecorationTheme, InkWell suffixIcon) {
    return TextFormField(
      readOnly: _readOnly,
      controller: _controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onChanged: onChanged,
      validator: validator,
      style: textTheme.bodyMedium!.copyWith(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        isDense: inputDecorationTheme.isDense,
        prefixIconColor: darkColor,
        hintText: hintText,
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        hintStyle: inputDecorationTheme.hintStyle,
        contentPadding: ThemeDataApp.instance.isLight
            ? EdgeInsets.zero
            : const EdgeInsets.all(5.0),
        suffixIcon: ValueListenableBuilder<bool>(
          valueListenable: _clearIcon,
          builder: (context, bool isVisibility, child) {
            if (!isVisibility) return const SizedBox();
            return suffixIcon;
          },
        ),
      ),
    );
  }
}
