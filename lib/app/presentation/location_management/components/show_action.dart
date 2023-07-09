import 'package:flutter_fashion/core/models/address.dart';

import '../../../../config/svg_files.dart';
import '../../../../export.dart';
import '../../../blocs/address_user/address_user_cubit.dart';

Future showAction(
  BuildContext context,
  VoidCallback onDelete,
  VoidCallback onUse,
  ItemAddress item,
) async {
  await showModalBottomSheet(
    backgroundColor: Colors.transparent,
    elevation: 0.0,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(5),
        topRight: Radius.circular(5),
      ),
    ),
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.symmetric(
            vertical: verticalPadding / 2, horizontal: horizontalPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ButtonWidget(
              onPressed: onUse,
              background: lightColor,
              child: Text(
                item.isSelected
                    ? AppLocalizations.of(context)!.not_use
                    : AppLocalizations.of(context)!.use,
                style: PrimaryFont.instance.copyWith(
                  fontSize: 14.0,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            ButtonWidget(
              onPressed: () async {
                final result = await showDialog<String>(
                  context: context,
                  builder: (ctx) {
                    return AlertDialog(
                      surfaceTintColor: lightColor,
                      backgroundColor: lightColor,
                      title: Text(
                        AppLocalizations.of(context)!.edit_address,
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: darkColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      content: TextFormField(
                        initialValue: item.name,
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: blackColor,
                        ),
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.done,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          isDense: true,
                          enabledBorder: UnderlineInputBorder(),
                          border: UnderlineInputBorder(),
                          focusedBorder: UnderlineInputBorder(),
                        ),
                        onFieldSubmitted: (value) =>
                            AppRoutes.router.pop<String>(value),
                      ),
                    );
                  },
                );
                if (result == null) return;

                // ignore: use_build_context_synchronously
                context.read<AddressUserCubit>().edit(item, result);
                //turn off modal action
                AppRoutes.router.pop();
              },
              background: lightColor,
              child: Text(
                AppLocalizations.of(context)!.edit,
                style: PrimaryFont.instance.copyWith(
                  fontSize: 14.0,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            ButtonWidget(
              onPressed: onDelete,
              background: lightColor,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    Assets.trashSVG,
                    width: 18,
                    height: 18,
                    colorFilter: const ColorFilter.mode(
                      primaryColor,
                      BlendMode.srcIn,
                    ),
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    AppLocalizations.of(context)!.delete,
                    style: PrimaryFont.instance.copyWith(
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
