
import '../../../../../export.dart';


class MenuOverlay {
  MenuOverlay._();

  static MenuOverlay? _instance;

  static MenuOverlay get instance => _instance ??= MenuOverlay._();

  OverlayEntry? _entry;

  bool _isShow = false;

  void showOverlay(BuildContext context,
      {required GlobalKey key, required Widget child}) {
    if (_isShow) {
      remove();
      return;
    }

    final overlay = Overlay.of(context);
    final renderBox = key.currentContext!.findRenderObject() as RenderBox;

    final offset = renderBox.localToGlobal(Offset.zero);
    _entry = OverlayEntry(
      builder: (context) => Positioned(
        top: offset.dy + renderBox.size.height,
        left: MediaQuery.of(context).size.width * .55,
        width: MediaQuery.of(context).size.width * .4,
        height: 115,
        child: Material(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: lightColor,
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 1),
                  blurRadius: 10.0,
                  color: textDisable,
                )
              ],
            ),
            child: child,
          ),
        ),
      ),
    );

    _isShow = true;

    overlay.insert(_entry!);
  }

  void remove() {
    if (_entry == null) return;
    _isShow = false;
    _entry!.remove();
    _entry = null;
  }
}
