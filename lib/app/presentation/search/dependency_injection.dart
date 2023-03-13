import 'package:flutter_fashion/app/blocs/search_history/search_history_cubit.dart';
import 'package:flutter_fashion/export.dart';

void initDISearch() {
  getIt.registerLazySingleton(() => SearchHistoryCubit());
}
