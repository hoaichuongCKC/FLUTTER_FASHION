// ignore_for_file: deprecated_member_use

import '../../../../export.dart';

class MethodPaymentView extends StatelessWidget {
  const MethodPaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            minLeadingWidth: 0.0,
            leading: SvgPicture.asset(
              "assets/icons/wallet.svg",
              color: primaryColor,
            ),
            title: Text(
              AppLocalizations.of(context)!.payment_method,
              style: theme.textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              color: !ThemeDataApp.instance.isLight
                  ? theme.cardColor
                  : disablePrimaryColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(radiusBtn),
              ),
            ),
            child: ListTile(
              dense: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
              title: Text(
                'Phương thức COD (mặc định)',
                style: theme.textTheme.bodySmall,
              ),
              trailing: SvgPicture.asset(
                "assets/icons/arrow_right.svg",
                colorFilter:
                    ColorFilter.mode(theme.iconTheme.color!, BlendMode.srcIn),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
