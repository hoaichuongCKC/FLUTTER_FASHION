import 'package:equatable/equatable.dart';
import 'package:flutter_fashion/core/models/intro_view.dart';
import 'package:flutter_fashion/export.dart';

part 'intro_cubit_state.dart';

class IntroCubit extends Cubit<IntroState> {
  late PageController _pageController;
  IntroCubit() : super(IntroState.initial());

  PageController get pageController => _pageController;

  final Curve _curve = Curves.easeIn;

  final Duration _duration = const Duration(milliseconds: 450);

  bool isLoadingPage = false;

  void init() {
    _pageController = PageController()..addListener(_listenPageController);
  }

  void continuePage() async {
    isLoadingPage = !isLoadingPage;

    final state = this.state;

    int currentPage = state.currentIndex;

    emit(state.copyWith(currentIndex: ++currentPage));

    await _pageController.animateToPage(currentPage,
        duration: _duration, curve: _curve);

    isLoadingPage = !isLoadingPage;
  }

  void skipPage() async {
    isLoadingPage = !isLoadingPage;

    final state = this.state;

    final lastPage = state.intros.length - 1;

    emit(state.copyWith(currentIndex: lastPage));

    await _pageController.animateToPage(lastPage,
        duration: _duration, curve: _curve);

    isLoadingPage = !isLoadingPage;
  }

  void _listenPageController() {
    if (isLoadingPage) return;

    final page = _pageController.page!;

    emit(state.copyWith(currentIndex: page.round()));
  }

  void dipose() {
    _pageController.removeListener(_listenPageController);
    _pageController.dispose();
  }
}
