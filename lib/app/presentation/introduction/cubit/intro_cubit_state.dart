// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'intro_cubit_cubit.dart';

final dataIntro = [
  IntroViewModel(
    image: SvgPicture.asset(
      "assets/images/introduction/intro_1.svg",
      fit: BoxFit.contain,
    ),
    title: 'Chào mừng bạn',
    subtitle: 'đến với cửa hàng Kira',
    titleEn: 'Welcome to',
    subtitleEn: 'our store',
  ),
  IntroViewModel(
    image: SvgPicture.asset(
      "assets/images/introduction/intro_2.svg",
      fit: BoxFit.contain,
    ),
    title: 'Sản phẩm đa dạng',
    subtitle: 'mua sắm thả ga',
    titleEn: 'Diversified products',
    subtitleEn: 'free shopping',
  ),
  IntroViewModel(
    image: SvgPicture.asset(
      "assets/images/introduction/intro_3.svg",
      fit: BoxFit.contain,
    ),
    title: 'Thanh toán & giao hàng',
    subtitle: 'nhanh chóng tiện lợi',
    titleEn: 'Payment & delivery',
    subtitleEn: 'quick and convenient',
  ),
];

class IntroState extends Equatable {
  final List<IntroViewModel> intros;
  final int currentIndex;
  factory IntroState.initial() => IntroState(intros: dataIntro);

  const IntroState({this.intros = const [], this.currentIndex = 0});

  @override
  List<Object?> get props => [intros, currentIndex];

  IntroState copyWith({
    List<IntroViewModel>? intros,
    int? currentIndex,
  }) {
    return IntroState(
      intros: intros ?? this.intros,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}
