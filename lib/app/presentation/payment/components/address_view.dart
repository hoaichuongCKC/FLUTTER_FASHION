// ignore_for_file: deprecated_member_use

import 'package:flutter_fashion/app/presentation/home/export.dart';
import '../../../../config/svg_files.dart';

class AddressPaymentView extends StatelessWidget {
  const AddressPaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    final applocalization = AppLocalizations.of(context)!;

    final theme = Theme.of(context);

    return BlocBuilder<AddressUserCubit, AddressUserState>(
      builder: (context, state) {
        final bool isNoAddress = state.usingAddress.isEmpty;

        if (isNoAddress) {
          return Container(
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              color: disablePrimaryColor.withAlpha(100),
              borderRadius: const BorderRadius.all(
                Radius.circular(radiusBtn / 2),
              ),
            ),
            child: ListTile(
              onTap: () => AppRoutes.router
                  .push("${Routes.PROFILE}/${Routes.ADDRESS_MANAGEMENT}"),
              dense: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
              title: Text(
                applocalization.shipping_address,
                style: theme.textTheme.bodySmall,
              ),
              subtitle: Text(
                applocalization.please_set_up_your_address,
                style: theme.textTheme.bodySmall,
              ),
              trailing: const Icon(
                Icons.add_circle_outline,
                size: 20.0,
                color: blackColor,
              ),
            ),
          );
        }

        final addressName = state.usingAddress[0].name;

        return DecoratedBox(
          decoration: BoxDecoration(
            color: !ThemeDataApp.instance.isLight
                ? Theme.of(context).cardColor
                : lightColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(5.0),
            ),
            boxShadow: !ThemeDataApp.instance.isLight ? null : [shadowBox],
          ),
          child: ListTile(
            leading: SvgPicture.asset(
              Assets.mapAddressSVG,
              width: 24.0,
              height: 24.0,
              color: secondaryColor,
            ),
            dense: true,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
            minLeadingWidth: 0.0,
            title: Text(
              applocalization.shipping_address,
              style: theme.textTheme.bodyMedium!.copyWith(
                fontSize: 14.0,
              ),
            ),
            subtitle: Text(
              addressName,
              style: theme.textTheme.bodySmall!.copyWith(
                color: textDisable,
              ),
            ),
            trailing: InkWell(
              onTap: () => AppRoutes.router
                  .push("${Routes.PROFILE}/${Routes.ADDRESS_MANAGEMENT}"),
              child: SvgPicture.asset(
                Assets.editSVG,
                color: secondaryColor,
              ),
            ),
          ),
        );
      },
    );
  }
}
