// ignore_for_file: deprecated_member_use
import '../../../../../../export.dart';

class MethodPaymentView extends StatelessWidget {
  const MethodPaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isVN = context.watch<SettingsCubit>().state.isVietnamese;
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16.0),
        ListTile(
          dense: true,
          contentPadding: EdgeInsets.zero,
          minLeadingWidth: 0.0,
          leading: SvgPicture.asset(
            Assets.walletSVG,
            color: secondaryColor,
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
                : secondaryColor.withOpacity(0.2),
            borderRadius: const BorderRadius.all(
              Radius.circular(radiusBtn),
            ),
          ),
          child: ListTile(
            dense: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
            title: Text(
              isVN ? 'Phương thức COD (mặc định)' : 'COD (default)',
              style: theme.textTheme.bodySmall,
            ),
            trailing: SvgPicture.asset(
              Assets.arrowRightSVG,
              colorFilter:
                  ColorFilter.mode(theme.iconTheme.color!, BlendMode.srcIn),
            ),
          ),
        ),
      ],
    );
  }
}
