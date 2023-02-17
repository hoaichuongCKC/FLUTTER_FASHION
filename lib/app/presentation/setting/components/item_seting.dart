import 'package:flutter/material.dart';
import 'package:flutter_fashion/config/colors.dart';
import 'package:flutter_fashion/config/font_style.dart';

class ItemSetting extends StatefulWidget {
  const ItemSetting(
      {super.key,
      required this.title,
      this.titleTrailing,
      required this.excute,
      this.subtitle,
      this.trailing,
      required this.icon,
      required this.color,
      this.isToggled = true});
  final String title;
  final String? titleTrailing;
  final Widget? trailing;
  final String? subtitle;
  final Widget icon;
  final VoidCallback excute;
  final Color color;
  final bool isToggled;
  @override
  State<ItemSetting> createState() => _ItemSettingState();
}

class _ItemSettingState extends State<ItemSetting> {
  String get _title => widget.title;

  String get _titleTrailing =>
      widget.titleTrailing != null ? widget.titleTrailing! : "";

  String? get _subtitle => widget.subtitle != null ? widget.subtitle! : null;

  Widget? get _trailing => widget.trailing != null ? widget.trailing! : null;

  late bool _isToggled;

  @override
  void initState() {
    _isToggled = widget.isToggled;
    super.initState();
  }

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
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          !(_titleTrailing == "")
              ? Text(
                  _titleTrailing,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 14.0,
                        color: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .color!
                            .withOpacity(0.6),
                        fontWeight: FontWeight.w300,
                      ),
                )
              : const SizedBox(),
          !(_titleTrailing == "")
              ? const SizedBox(width: 6.0)
              : const SizedBox(),
          _trailing != null
              ? _trailing!
              : Switch(
                  materialTapTargetSize: MaterialTapTargetSize.padded,
                  value: !_isToggled,
                  splashRadius: 5.0,
                  onChanged: (value) {
                    widget.excute();
                    setState(() {
                      _isToggled = !_isToggled;
                    });
                  },
                  activeColor: primaryColor,
                  activeTrackColor: disablePrimaryColor,

                  // trackColor: MaterialStateProperty.all(disablePrimaryColor),
                  // thumbIcon:
                  //     MaterialStateProperty.all(const Icon(Icons.settings)),
                  inactiveThumbColor: disablePrimaryColor,
                  inactiveTrackColor: scaffoldBackgroundColor,
                ),
        ],
      ),
      subtitle: _subtitle != null
          ? Text(
              _subtitle!,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: 10.0,
                    color: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .color!
                        .withOpacity(0.6),
                    fontWeight: FontWeight.w300,
                  ),
            )
          : null,
    );
  }
}
