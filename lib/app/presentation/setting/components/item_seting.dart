import 'package:flutter/material.dart';
import 'package:flutter_fashion/config/colors.dart';
import 'package:flutter_fashion/config/font_style.dart';
import 'package:flutter_svg/svg.dart';

class ItemSetting extends StatefulWidget {
  const ItemSetting(
      {super.key,
      required this.title,
      this.titleTrailing,
      required this.excute,
      this.subtitle,
      this.trailing,
      required this.icon,
      required this.color});
  final String title;
  final String? titleTrailing;
  final Widget? trailing;
  final String? subtitle;
  final Widget icon;
  final VoidCallback excute;
  final Color color;
  @override
  State<ItemSetting> createState() => _ItemSettingState();
}

class _ItemSettingState extends State<ItemSetting> {
  String get _title => widget.title;

  String get _titleTrailing =>
      widget.titleTrailing != null ? widget.titleTrailing! : "";

  String? get _subtitle => widget.subtitle != null ? widget.subtitle! : null;

  Widget? get _trailing => widget.trailing != null ? widget.trailing! : null;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      minLeadingWidth: 50.0,
      contentPadding: EdgeInsets.zero,
      leading: SizedBox(
        width: 50,
        height: 50,
        child: Stack(
          fit: StackFit.expand,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.color.withOpacity(0.2),
              ),
              child: const SizedBox(width: 40, height: 40.0),
            ),
            Center(child: widget.icon),
          ],
        ),
      ),
      title: Text(
        _title,
        style: PrimaryFont.instance.copyWith(
          fontSize: 18.0,
          fontWeight: FontWeight.w400,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          !(_titleTrailing == "")
              ? Text(
                  _titleTrailing,
                  style: PrimaryFont.instance.copyWith(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w300,
                    color: darkColor.withOpacity(0.6),
                  ),
                )
              : const SizedBox(),
          !(_titleTrailing == "")
              ? const SizedBox(width: 6.0)
              : const SizedBox(),
          _trailing != null
              ? _trailing!
              : Switch(
                  value: true,
                  onChanged: (value) {
                    widget.excute();
                  },
                  activeColor: primaryColor,
                  activeTrackColor: disablePrimaryColor,
                  inactiveThumbColor: darkColor,
                ),
        ],
      ),
      subtitle: _subtitle != null
          ? Text(
              _subtitle!,
              style: PrimaryFont.instance.copyWith(
                fontSize: 12.0,
                color: darkColor.withOpacity(0.6),
                fontWeight: FontWeight.w300,
              ),
            )
          : null,
    );
  }
}
