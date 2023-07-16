
import 'package:flutter_fashion/app/presentation/modules/user/category/blocs/category_tab_cubit.dart';
import 'package:flutter_fashion/app/presentation/modules/user/filter/cubit/filter_cubit.dart';
import 'package:flutter_fashion/export.dart';

Future<void> initDICategory() async {
  getIt.registerFactory<FilterCubit>(
    () => FilterCubit(),
  );

  getIt.registerLazySingleton<CategoryTabCubit>(
    () => CategoryTabCubit(caterepo: getIt()),
  );
}
