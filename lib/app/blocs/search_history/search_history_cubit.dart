import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:rxdart/rxdart.dart';

class SearchHistoryCubit extends HydratedCubit<List<String>> {
  SearchHistoryCubit()
      : super([
          "Quần jean",
          'Áo thun nữ',
          'Váy ngắn dạ hội',
          'Áo trẻ em thể thao',
          'Áo sơ mi công sở nữ',
        ]) {
    _isShowMore = BehaviorSubject.seeded(false);
    _list = BehaviorSubject.seeded([]);
    fetchData();
  }
  final int _defaultLimit = 4;

  late BehaviorSubject<bool> _isShowMore;

  BehaviorSubject<bool> get showMoreStream => _isShowMore;

  late BehaviorSubject<List<String>> _list;

  BehaviorSubject<List<String>> get listStream => _list;

  void fetchData() {
    final state = this.state;
    if (state.length <= _defaultLimit) {
      _list.sink.add(state);
    } else {
      final list = List<String>.from(state).take(_defaultLimit).toList();
      _isShowMore.sink.add(true);
      _list.sink.add(list);
    }
  }

  void loadMoreData() {
    final state = this.state;

    _isShowMore.sink.add(false);
    _list.sink.add(state);
  }

  void clearData() {
    _list.sink.add([]);
    emit(List<String>.from(state)..clear());
  }

  @override
  List<String>? fromJson(Map<String, dynamic> json) {
    return json["data"];
  }

  @override
  Map<String, dynamic>? toJson(List<String> state) {
    return {"data": state};
  }
}
