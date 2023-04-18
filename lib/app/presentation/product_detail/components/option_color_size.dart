import 'package:flutter_fashion/app/presentation/product_detail/cubit/product_detail_ui_cubit.dart';
import 'package:flutter_fashion/app/presentation/product_detail/inherited.dart';

import '../../../../export.dart';

class OptionColorSizeDetail extends StatelessWidget {
  const OptionColorSizeDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final detailInherited = ProductDetailInherited.of(context);

    final product = detailInherited.productModel;

    final blocDetailUi = BlocProvider.of<ProductDetailUiCubit>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<ProductDetailUiCubit, ProductDetailUiState>(
          buildWhen: (previous, current) => previous.color != current.color,
          builder: (context, state) {
            return _buildOptionColors(
              title: AppLocalizations.of(context)!.colors,
              options: product.properties!.colors!,
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

  _buildOptionColors({
    required String title,
    required List options,
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
          style: PrimaryFont.instance.copyWith(
            fontSize: 16.0,
          ),
        ),
        const SizedBox(height: 5.0),
        Wrap(
          spacing: 10.0,
          children: options.map((e) {
            final isSelected = colorCode == e;

            final color = int.parse("0xFF$e");

            final index = options.indexOf(e);

            const padding = EdgeInsets.all(3.5);

            return InkWell(
              onTap: () => onPressed(e, index),
              customBorder: const CircleBorder(),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: isSelected ? Border.all(color: primaryColor) : null,
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
          }).toList(),
        ),
      ],
    );
  }

  _buildOptionSizes({
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
          style: PrimaryFont.instance.copyWith(
            fontSize: 16.0,
          ),
        ),
        const SizedBox(height: 5.0),
        Wrap(
          spacing: 14.0,
          children: options.map((e) {
            e = e.toString();
            final isSelected = size == e;

            final color = isSelected ? primaryColor : lightColor;

            final textColor = isSelected ? lightColor : darkColor;

            return InkWell(
              onTap: () => onPressed(e),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius:
                      const BorderRadius.all(Radius.circular(radiusBtn)),
                  boxShadow: const [
                    BoxShadow(color: disablePrimaryColor, blurRadius: 8.0)
                  ],
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
