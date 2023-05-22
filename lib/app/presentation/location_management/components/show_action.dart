import '../../../../export.dart';

void showAction(
  BuildContext context,
  VoidCallback onDelete,
  VoidCallback onUse,
  bool isSelected,
) {
  showModalBottomSheet(
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
                isSelected
                    ? AppLocalizations.of(context)!.not_use
                    : AppLocalizations.of(context)!.use,
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
                    "assets/icons/trash.svg",
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
