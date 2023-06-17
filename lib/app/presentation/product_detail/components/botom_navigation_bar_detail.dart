import 'package:flutter_fashion/app/models/product/product.dart';
import 'package:flutter_fashion/app/presentation/product_detail/components/app_bar_product_detail.dart';
import 'package:flutter_fashion/app/presentation/product_detail/cubit/product_detail_ui_cubit.dart';
import 'package:flutter_fashion/app/presentation/product_detail/overlay_animation/product_overlay.dart';
import 'package:flutter_fashion/core/base/api/api.dart';
import 'package:flutter_fashion/export.dart';

import 'package:fluttertoast/fluttertoast.dart';

class BottomNavigationbarDetail extends StatelessWidget {
  const BottomNavigationbarDetail({super.key});

  static GlobalKey imageKey = GlobalKey();

  static Size getImageSize() {
    final box = imageKey.currentContext!.findRenderObject() as RenderBox;

    return Size(box.size.width, box.size.height);
  }

  @override
  Widget build(BuildContext context) {
    final ProductModel product =
        InheritedDataApp.of<ProductModel>(context)!.data;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
      child: ButtonWidget(
        onPressed: () =>
            BlocProvider.of<ProductDetailUiCubit>(context).addToCart(
          context,
          product,
          (photo, quantity) => handleAnimation(quantity, photo, context),
        ),
        child: Text(
          AppLocalizations.of(context)!.add_to_cart,
          style: PrimaryFont.instance.copyWith(
            color: lightColor,
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  void handleAnimation(quantity, photo, context) async {
    final imageWidget = CachedNetworkImage(
      key: imageKey,
      imageUrl: ApiService.imageUrl + photo,
      width: 200.0,
      height: 200.0,
      fit: BoxFit.cover,
    );

    ProductOverlay.instance.showOverlay(
      context,
      image: imageWidget,
    );

    showSuccessToast(
      "Thêm giỏ hàng thành công",
      toastLength: Toast.LENGTH_SHORT,
    );
  }
}

class ItemProductScaleAnimationDetail extends StatefulWidget {
  const ItemProductScaleAnimationDetail({
    super.key,
    required this.image,
    required this.size,
  });
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

  Offset get appbarOffset => AppBarProductDetail.getOffset();

  Size get imageSize => BottomNavigationbarDetail.getImageSize();

  late Size size;

  late Offset center;

  final durationAnimation = const Duration(milliseconds: 700);

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: durationAnimation,
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

      _offsetAnimation = Tween<Offset>(begin: center, end: appbarOffset)
          .animate(_animationController);

      _animationController.forward();
    });

    _offsetAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: appbarOffset)
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
