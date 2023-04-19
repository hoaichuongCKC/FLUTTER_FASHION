import 'package:freezed_annotation/freezed_annotation.dart';
part 'range_price.freezed.dart';

@freezed
class RangePriceModel with _$RangePriceModel {
  const factory RangePriceModel.initial() = _Inital;
  const factory RangePriceModel.below100k(
      {required int priceFirst, required int piceSendcond}) = _Below100K;
  const factory RangePriceModel.from100kTo500k(
      {required int priceFirst, required int piceSendcond}) = _From100kTo500k;
  const factory RangePriceModel.from500kAbove(
      {required int priceFirst, required int piceSendcond}) = _From500kAbove;

  static List<RangePriceModel> get initList => const [
        RangePriceModel.below100k(priceFirst: 0, piceSendcond: 100000),
        RangePriceModel.from100kTo500k(
            priceFirst: 100000, piceSendcond: 500000),
        RangePriceModel.from500kAbove(priceFirst: 500000, piceSendcond: 0),
      ];

  static bool queryPrice(int index, int price) {
    if (index == -1) return true;
    if (index == 0) {
      return price <= 100000;
    } else if (index == 1) {
      return 100000 <= price && price <= 500000;
    }
    return price >= 500000;
  }
}
