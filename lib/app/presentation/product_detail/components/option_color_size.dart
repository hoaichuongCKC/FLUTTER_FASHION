import 'package:flutter_fashion/app/models/product/product.dart';
import 'package:flutter_fashion/app/presentation/product_detail/cubit/product_detail_ui_cubit.dart';
import '../../../../export.dart';

class OptionColorSizeDetail extends StatelessWidget {
  const OptionColorSizeDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductModel product =
        InheritedDataApp.of<ProductModel>(context)!.data;

    final blocDetailUi = BlocProvider.of<ProductDetailUiCubit>(context);

    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<ProductDetailUiCubit, ProductDetailUiState>(
          buildWhen: (previous, current) => previous.color != current.color,
          builder: (context, state) {
            return _buildOptionColors(
              theme,
              title: AppLocalizations.of(context)!.colors,
              options: product.product_detail!,
              colorCode: state.color,
              onPressed: (code, index) => blocDetailUi.changeColor(code, index),
            );
          },
        ),
        const SizedBox(height: 10.0),
        BlocBuilder<ProductDetailUiCubit, ProductDetailUiState>(
          buildWhen: (previous, current) => previous.size != current.size,
          builder: (context, state) {
            return _buildOptionSizes(
              theme,
              title: AppLocalizations.of(context)!.sizes,
              options: product.properties!.sizes!,
              size: state.size,
              onPressed: (size) => blocDetailUi.changeSize(size),
            );
          },
        ),
      ],
    );
  }

  _buildOptionColors(
    ThemeData theme, {
    required String title,
    required List<ProductDetailModel> options,
    String colorCode = "",
    required Function(String, int) onPressed,
  }) {
    if (options.isEmpty) {
      return const SizedBox();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5.0),
        Wrap(
          spacing: 10.0,
          children: options.map((e) {
            final isSelected = colorCode == e.color;

            final color = int.parse("0xFF${e.color}");

            final index = options.indexOf(e);

            const padding = EdgeInsets.all(3.5);

            final bool isStock = e.stock! > 0;

            late final Widget itemColor;

            if (isStock) {
              itemColor = InkWell(
                onTap: () => onPressed(e.color!, index),
                customBorder: const CircleBorder(),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border:
                        isSelected ? Border.all(color: secondaryColor) : null,
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: padding,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Color(color),
                        shape: BoxShape.circle,
                      ),
                      child: const SizedBox(
                        width: 25.0,
                        height: 25.0,
                      ),
                    ),
                  ),
                ),
              );
            } else {
              itemColor = DecoratedBox(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: padding,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Color(color),
                      shape: BoxShape.circle,
                    ),
                    child: SizedBox(
                      width: 25.0,
                      height: 25.0,
                      child: Stack(
                        fit: StackFit.expand,
                        clipBehavior: Clip.none,
                        children: [
                          Align(
                            child: Transform.rotate(
                              angle: 95,
                              child: Container(
                                width: 30.0,
                                height: 3.0,
                                color: errorColor,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }

            return itemColor;
          }).toList(),
        ),
      ],
    );
  }

  _buildOptionSizes(
    ThemeData theme, {
    required String title,
    required List options,
    String size = "",
    required Function(String) onPressed,
  }) {
    if (options.isEmpty) {
      return const SizedBox();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5.0),
        Wrap(
          spacing: 14.0,
          children: options.map((e) {
            e = e.toString();
            final isSelected = size == e;

            final color = isSelected ? secondaryColor : lightColor;

            final textColor = isSelected ? lightColor : darkColor;

            return InkWell(
              onTap: () => onPressed(e),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius:
                      const BorderRadius.all(Radius.circular(radiusBtn)),
                  boxShadow:
                      !ThemeDataApp.instance.isLight ? null : [shadowBox],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: SizedBox(
                    width: 35,
                    child: Align(
                      child: Text(
                        e,
                        style: PrimaryFont.instance.copyWith(
                          fontSize: 14.0,
                          color: textColor,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
