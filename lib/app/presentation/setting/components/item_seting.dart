import 'package:flutter/material.dart';
import 'package:flutter_fashion/config/colors.dart';

class ItemSetting extends StatelessWidget {
  const ItemSetting(
      {super.key,
      required this.title,
      this.titleTrailing,
      required this.excute,
      this.subtitle,
      this.trailing,
      required this.icon,
      required this.color,
      this.isToggled = true,
      this.isHasToggled = true});
  final String title;
  final String? titleTrailing;
  final Widget? trailing;
  final String? subtitle;
  final Widget icon;
  final VoidCallback excute;
  final Color color;
  final bool isToggled;
  final bool isHasToggled;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      onTap: isHasToggled ? null : excute,
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
                color: color.withOpacity(0.2),
              ),
              child: const SizedBox(width: 40, height: 40.0),
            ),
            Center(child: icon),
          ],
        ),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      trailing: !isHasToggled
          ? trailing
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                !(titleTrailing == "")
                    ? Text(
                        titleTrailing!,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontSize: 12.0,
                              color: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .color!
                                  .withOpacity(0.6),
                              fontWeight: FontWeight.w300,
                            ),
                      )
                    : const SizedBox(),
                !(titleTrailing == "")
                    ? const SizedBox(width: 6.0)
                    : const SizedBox(),
                trailing != null
                    ? trailing!
                    : Switch(
                        materialTapTargetSize: MaterialTapTargetSize.padded,
                        value: isToggled,
                        splashRadius: 5.0,
                        onChanged: (value) {
                          excute();
                        },
                        activeColor: primaryColor,
                        activeTrackColor: disablePrimaryColor,
                        inactiveThumbColor: disablePrimaryColor,
                        inactiveTrackColor: scaffoldBackgroundColor,
                      ),
              ],
            ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
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
