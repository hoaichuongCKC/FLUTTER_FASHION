import 'package:flutter_fashion/app/presentation/category/blocs/category_tab_cubit.dart';
import 'package:flutter_fashion/app/presentation/filter/blocs/filter_bloc.dart';

import '../../../export.dart';

Future<void> initDICategory() async {
  getIt.registerLazySingleton<FilterBloc>(
    () => FilterBloc(),
  );

  getIt.registerLazySingleton<CategoryTabCubit>(
    () => CategoryTabCubit(product: getIt()),
  );
}
