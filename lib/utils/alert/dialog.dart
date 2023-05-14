import 'package:flutter_fashion/export.dart';

showCustomDialog(
  BuildContext context, {
  required String content,
  required String title,
  String? submitNameFirst,
  String? submitNameSecond,
  VoidCallback? onFirst,
  VoidCallback? onSecond,
  Widget? icon,
}) {
  showDialog(
    context: context,
    builder: (context) {
      final theme = Theme.of(context);
      return AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(radiusBtn * 2),
          ),
        ),
        backgroundColor: lightColor,
        icon: icon,
        surfaceTintColor: lightColor,
        title: Text(title),
        titleTextStyle: theme.textTheme.bodyMedium!.copyWith(
          fontSize: 14.0,
          fontWeight: FontWeight.w800,
        ),
        iconPadding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
        contentTextStyle: theme.textTheme.bodySmall,
        content:
            Text(content, textAlign: icon != null ? TextAlign.center : null),
        actionsPadding: EdgeInsets.zero,
        contentPadding: const EdgeInsets.fromLTRB(25, 8, 25, 8),
        actions: [
          submitNameFirst == null
              ? const SizedBox()
              : TextButton(
                  onPressed: onFirst,
                  child: Text(
                    submitNameFirst,
                    style: theme.textTheme.bodySmall!.copyWith(
                      color: secondaryColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
          submitNameSecond == null
              ? const SizedBox()
              : TextButton(
                  onPressed: onSecond,
                  child: Text(
                    submitNameSecond,
                    style: theme.textTheme.bodySmall!.copyWith(
                      color: secondaryColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
        ],
        actionsAlignment: MainAxisAlignment.end,
      );
    },
  );
}
