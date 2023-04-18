import 'package:flutter_fashion/app/presentation/product_detail/components/botom_navigation_bar_detail.dart';

import '../../../../export.dart';

class ProductOverlay {
  ProductOverlay._();

  static ProductOverlay? _instance;

  static ProductOverlay get instance => _instance ??= ProductOverlay._();

  late OverlayEntry _entry;

  bool _isShow = false;

  void showOverlay(BuildContext context, {required Widget image}) {
    if (_isShow) return;

    final overlay = Overlay.of(context);

    _entry = OverlayEntry(
      builder: (context) => ItemProductScaleAnimationDetail(
        image: image,
        size: MediaQuery.of(context).size,
      ),
    );

    _isShow = true;

    overlay.insert(_entry);
  }

  void remove() {
    _isShow = false;
    _entry.remove();
  }
}
