import 'package:flutter_fashion/config/colors.dart';
import 'package:flutter_fashion/config/font_style.dart';
import 'package:flutter_fashion/export.dart';

class TextFiledPICustom extends StatefulWidget {
  const TextFiledPICustom(
      {super.key,
      required this.controller,
      this.keyboardType,
      required this.onChanged,
      this.isOnchanged = false});
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final Function(String?) onChanged;
  final bool isOnchanged;
  @override
  State<TextFiledPICustom> createState() => _TextFiledPICustomState();
}

class _TextFiledPICustomState extends State<TextFiledPICustom> {
  TextEditingController get _controller => widget.controller;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: _controller,
          maxLines: 2,
          minLines: 1,
          textInputAction: TextInputAction.done,
          onChanged: (value) => widget.onChanged(value),
          keyboardType: widget.keyboardType,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontWeight: FontWeight.w500),
          decoration: InputDecoration(
            hintText: '',
            isDense: true,
            filled: false,
            contentPadding: EdgeInsets.zero,
            focusedBorder: InputBorder.none,
            border: Theme.of(context).inputDecorationTheme.border,
            errorBorder: InputBorder.none,
          ),
        ),
        widget.isOnchanged ? const SizedBox(height: 7.0) : const SizedBox(),
        widget.isOnchanged
            ? ColoredBox(
                color: errorColor.withOpacity(0.05),
                child: SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      AppLocalizations.of(context)!.theAboveTextHasBeenEdited,
                      style: PrimaryFont.instance.copyWith(
                        fontSize: 12.0,
                        color: errorColor,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
