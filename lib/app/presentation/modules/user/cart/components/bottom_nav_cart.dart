
import '../../../../../../export.dart';

class BottomNavigationBarCart extends StatelessWidget {
  const BottomNavigationBarCart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        if (state.items.isEmpty) {
          return const SizedBox();
        }
        return DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(5.0),
              topRight: Radius.circular(5.0),
            ),
            boxShadow: !ThemeDataApp.instance.isLight ? null : [shadowBox],
          ),
          child: ConstrainedBoxWidget(
            currentHeight: 0.1,
            maxHeight: 70.0,
            minHeight: 60,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: horizontalPadding - 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${AppLocalizations.of(context)!.total_amount}:",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 14.0,
                            ),
                      ),
                      Text(
                        state.totalCart().toDouble().toVndCurrency(),
                        style: PrimaryFont.instance.copyWith(
                          fontSize: 14.0,
                          color: errorColor.withOpacity(0.7),
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: ButtonWidget(
                      height: 40.0,
                      onPressed: () =>
                          AppRoutes.router.pushNamed(Names.PAYMENT),
                      child: Text(
                        AppLocalizations.of(context)!.check_it_out,
                        style: PrimaryFont.instance.copyWith(
                          fontSize: 14.0,
                          color: lightColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
