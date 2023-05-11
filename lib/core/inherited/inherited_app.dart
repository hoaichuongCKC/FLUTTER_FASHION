import '../../export.dart';

class InheritedDataApp<T> extends InheritedWidget {
  const InheritedDataApp({
    super.key,
    required super.child,
    required this.data,
  });
  final T data;

  static InheritedDataApp<T>? of<T>(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<InheritedDataApp<T>>();

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
