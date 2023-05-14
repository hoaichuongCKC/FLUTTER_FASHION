import 'package:flutter_fashion/export.dart';

abstract class ScrollStateful extends StatefulWidget {
  const ScrollStateful({super.key});
}

abstract class ScrollState<T extends ScrollStateful> extends State<T> {
  late ScrollController _scrollController;

  ScrollController get scrollController => _scrollController;

  @override
  void initState() {
    super.initState();
    init();
    _scrollController = ScrollController()
      ..addListener(
        () {
          scrollListen(_scrollController);
        },
      );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    destroy(_scrollController);
    super.dispose();
  }

  void init();

  void scrollListen(ScrollController controller);

  void destroy(ScrollController controller);
}
