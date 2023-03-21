// ignore_for_file: deprecated_member_use

import 'package:flutter_fashion/export.dart';

class FormSearch extends StatefulWidget {
  const FormSearch({
    super.key,
    required this.onChanged,
  });
  final void Function(String) onChanged;
  @override
  State<FormSearch> createState() => _FormSearchState();
}

class _FormSearchState extends State<FormSearch> {
  final controller = TextEditingController();
  bool isShow = false;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: DecoratedBox(
        decoration: const BoxDecoration(boxShadow: [
          BoxShadow(color: disablePrimaryColor, blurRadius: 7.0),
        ]),
        child: TextFormField(
          controller: controller,
          autofocus: true,
          style: PrimaryFont.instance.copyWith(
            fontSize: 16.0,
            color: darkColor.withOpacity(0.7),
            fontWeight: FontWeight.w400,
          ),
          onChanged: (value) {
            widget.onChanged(value);
            if (value.isNotEmpty && !isShow) {
              isShow = !isShow;
            } else if (value.isEmpty && isShow) {
              isShow = !isShow;
            }

            setState(() {});
          },
          decoration: InputDecoration(
            prefixIcon: Hero(
              tag: "icon-search",
              transitionOnUserGestures: true,
              child: SvgPicture.asset(
                "assets/icons/search.svg",
                fit: BoxFit.scaleDown,
                width: 20.0,
                height: 20.0,
                color: darkColor.withOpacity(0.4),
              ),
            ),
            hintText: "vd: Quần jean",
            fillColor: lightColor,
            hintStyle: PrimaryFont.instance.copyWith(
              fontSize: 12.0,
              color: darkColor.withOpacity(0.4),
              fontWeight: FontWeight.w400,
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: horizontalPadding - 4),
            isDense: true,
            filled: true,
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(radiusBtn / 2),
              ),
            ),
            suffixIcon: Visibility(
              visible: isShow,
              child: IconButton(
                onPressed: () {
                  setState(() {
                    isShow = !isShow;
                    controller.clear();
                  });
                },
                icon: const Icon(
                  Icons.clear,
                  size: 20.0,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
