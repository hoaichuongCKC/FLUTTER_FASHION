import 'package:flutter_fashion/app/presentation/filter/cubit/filter_cubit.dart';

import '../../../export.dart';

Future<void> initDICategory() async {
  getIt.registerFactory<FilterCubit>(
    () => FilterCubit(),
  );

  getIt.registerLazySingleton<CategoryTabCubit>(
    () => CategoryTabCubit(caterepo: getIt()),
  );
}
