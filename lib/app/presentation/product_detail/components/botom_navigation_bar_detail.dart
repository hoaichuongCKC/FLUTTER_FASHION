import 'package:flutter_fashion/app/presentation/product_detail/components/app_bar_product_detail.dart';
import 'package:flutter_fashion/app/presentation/product_detail/cubit/product_detail_ui_cubit.dart';
import 'package:flutter_fashion/app/presentation/product_detail/inherited.dart';
import 'package:flutter_fashion/app/presentation/product_detail/overlay_animation/product_overlay.dart';
import 'package:flutter_fashion/core/base/api/api.dart';
import 'package:flutter_fashion/export.dart';

class BottomNavigationbarDetail extends StatelessWidget {
  const BottomNavigationbarDetail({super.key});

  static GlobalKey imageKey = GlobalKey();

  static Size getImageSize() {
    final box = imageKey.currentContext!.findRenderObject() as RenderBox;

    return Size(box.size.width, box.size.height);
  }

  @override
  Widget build(BuildContext context) {
    final detailInherited = ProductDetailInherited.of(context);

    final product = detailInherited.productModel;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: lightColor,
          borderRadius: BorderRadius.all(
            Radius.circular(radiusBtn),
          ),
        ),
        child: ConstrainedBoxWidget(
          currentHeight: 0.1,
          maxHeight: 45.0,
          minHeight: 40.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                flex: 1,
                child: FractionallySizedBox(
                  heightFactor: 1.0,
                  child: ButtonWidget(
                    height: 40.0,
                    animate: true,
                    radius: 5.0,
                    btnColor: primaryColor,
                    onPressed: () {
                      BlocProvider.of<ProductDetailUiCubit>(context).addToCart(
                        context,
                        product,
                        (quantity) async {
                          final index =
                              BlocProvider.of<ProductDetailUiCubit>(context)
                                  .state
                                  .indexImage;
                          final imageWidget = CachedNetworkImage(
                            key: imageKey,
                            imageUrl: ApiService.imageUrl +
                                product.product_detail![index].photo,
                            width: 200.0,
                            height: 200.0,
                            fit: BoxFit.cover,
                          );

                          ProductOverlay.instance
                              .showOverlay(context, image: imageWidget);
                        },
                      );
                    },
                    label: AppLocalizations.of(context)!.add_to_cart,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ItemProductScaleAnimationDetail extends StatefulWidget {
  const ItemProductScaleAnimationDetail(
      {super.key, required this.image, required this.size});
  final Widget image;
  final Size size;
  @override
  State<ItemProductScaleAnimationDetail> createState() =>
      _ItemProductScaleAnimationDetailState();
}

class _ItemProductScaleAnimationDetailState
    extends State<ItemProductScaleAnimationDetail>
    with TickerProviderStateMixin {
  late Animation<Offset> _offsetAnimation;

  late Animation<double> _scaleAnimation;

  late ValueNotifier<double> _notifier;

  late AnimationController _animationController;

  Offset get cartOffset => AppBarProductDetail.getOffset();

  Size get imageSize => BottomNavigationbarDetail.getImageSize();

  late Size size;

  late Offset center;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) {
            ProductOverlay.instance.remove();
          }
        },
      );

    _notifier = ValueNotifier(0.0);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _notifier.value = 1.0;

      size = widget.size;

      final double centerX = (size.width) / 2 - (imageSize.width / 2);

      final double centerY = size.height / 2 - (imageSize.height / 2);

      center = Offset(centerX, centerY);

      _offsetAnimation = Tween<Offset>(begin: center, end: cartOffset)
          .animate(_animationController);

      _animationController.forward();
    });

    _offsetAnimation = Tween<Offset>(begin: const Offset(0, 0), end: cartOffset)
        .animate(_animationController);

    _scaleAnimation =
        Tween<double>(begin: 1.0, end: 0.3).animate(_animationController);
  }

  @override
  void dispose() {
    _notifier.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (BuildContext context, Widget? child) {
        child = child ??= const SizedBox();
        return Positioned(
          left: _offsetAnimation.value.dx,
          top: _offsetAnimation.value.dy,
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: child,
          ),
        );
      },
      child: ValueListenableBuilder<double>(
        valueListenable: _notifier,
        builder: (context, opa, child) {
          return Opacity(
            opacity: opa,
            child: widget.image,
          );
        },
      ),
    );
  }
}
