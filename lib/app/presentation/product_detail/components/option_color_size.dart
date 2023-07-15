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
          buildWhen: (p, c) => c.color != p.color,
          builder: (context, state) {
            return _buildOptionColors(
              theme,
              title: AppLocalizations.of(context)!.colors,
              options: product.product_detail!,
              color: state.color,
              onPressed: (color, index) =>
                  blocDetailUi.selectImage(color, index),
            );
          },
        ),
        const SizedBox(height: 10.0),
        BlocBuilder<ProductDetailUiCubit, ProductDetailUiState>(
          buildWhen: (p, c) => c.size != p.size || c.color != p.color,
          builder: (context, state) {
            return _buildOptionSizes(
              theme,
              title: AppLocalizations.of(context)!.sizes,
              options: product.product_detail!,
              color: state.color,
              size: state.size,
              onPressed: (size, id) => blocDetailUi.changeSize(size, id),
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
    required String color,
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
          spacing: 5.0,
          children: options.map((item) {
            final index = options.indexOf(item);

            if (index != 0) {
              final bool isColor =
                  options[index - 1].color == options[index].color;
              if (isColor) return const SizedBox();
            }

            final isSelected = color == item.color;

            final hex = "0xFF${item.color!.substring(1)}";

            final parseColor = int.parse(hex);

            const padding = EdgeInsets.all(3.5);

            final bool isStock = item.stock! > 0;

            late final Widget itemColor;

            if (isStock) {
              itemColor = InkWell(
                onTap: () => onPressed(item.color!, index),
                customBorder: const CircleBorder(),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: isSelected ? Border.all(color: darkColor) : null,
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: padding,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Color(parseColor),
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
                      color: Color(parseColor),
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
    required List<ProductDetailModel> options,
    required String color,
    required String size,
    required Function(String, int id) onPressed,
  }) {
    if (options[0].size == null || options[0].size!.isEmpty) {
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
          spacing: 5.0,
          children:
              options.where((element) => element.color == color).map((item) {
            final isSelected = size == item.size;

            final color = isSelected ? darkColor : lightColor;

            final textColor = isSelected ? lightColor : blackColor;

            return InkWell(
              onTap: () => onPressed(item.size!, item.id),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius:
                      const BorderRadius.all(Radius.circular(radiusBtn / 2)),
                  boxShadow:
                      !ThemeDataApp.instance.isLight ? null : [shadowBox],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: SizedBox(
                    width: 35,
                    child: Align(
                      child: Text(
                        item.size.toString(),
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
