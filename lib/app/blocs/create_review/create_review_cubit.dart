import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter_fashion/app/blocs/order/order_cubit.dart';
import 'package:flutter_fashion/app/presentation/home/export.dart';
import 'package:flutter_fashion/app/repositories/product_repository.dart';
import 'package:flutter_fashion/core/camera/camera_info.dart';
import 'package:flutter_fashion/core/status_cubit/status_cubit.dart';
import 'package:flutter_fashion/utils/alert/error.dart';
import 'package:flutter_fashion/utils/alert/loading.dart';

part 'create_review_state.dart';

class CreateReviewCubit extends Cubit<CreateReviewState> {
  final ProductRepositoryImpl productRepositoryImpl;

  final CameraInfo cameraInfo;

  CreateReviewCubit(
      {required this.productRepositoryImpl, required this.cameraInfo})
      : super(const CreateReviewState());

  void changedContent(String value) => emit(state.copyWith(content: value));

  void changedStar(int star) => emit(state.copyWith(stars: star));

  void changedOrderId(String orderId) => emit(state.copyWith(orderId: orderId));

  void onSelectImage(BuildContext context) async {
    final state = this.state;
    final files = await cameraInfo.chooseImages();

    if (files == null) return;

    if (state.files.length + files.length > 3) {
      // ignore: use_build_context_synchronously
      errorAlert(
        context: context,
        message: "Số ảnh chọn vượt quá qui định",
      );
      return;
    }

    final fileCompress = await cameraInfo.compressAndGetListFile(
      files.map((file) => File(file.path)).toList(),
      "upload",
      size: const Size(150, 150),
    );

    if (fileCompress != null) {
      emit(state.copyWith(files: [...state.files, ...fileCompress]));
    }
  }

  void deleteImage(int index) {
    final state = this.state;
    final updated = List<File>.from(state.files)..removeAt(index);
    emit(state.copyWith(files: updated));
  }

  void rating(BuildContext context, String orderId) async {
    final state = this.state;

    loadingAlert(context: context);

    final params = state;

    final result = await productRepositoryImpl.createReview(params);
    //turn off loading alert
    AppRoutes.router.pop();

    result.fold(
      (erorr) {
        errorAlert(context: context);
        emit(state.copyWith(status: AppStatus.error));
      },
      (responseData) async {
        emit(state.copyWith(status: AppStatus.success));

        AppRoutes.router.pushNamed(
          Names.REVIEW_SUCCESS,
          queryParams: {
            "index": state.stars.toString(),
          },
        );

        context.read<OrderCubit>().updateEvaluated(int.parse(orderId));
      },
    );
  }
}
