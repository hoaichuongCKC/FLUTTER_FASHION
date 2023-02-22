import 'package:image_picker/image_picker.dart';

class CameraInfo {
  final ImagePicker _imagePicker;

  CameraInfo(ImagePicker imagePicker) : _imagePicker = imagePicker;

  Future<void> getLostData() async {
    final LostDataResponse response = await _imagePicker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.files != null) {
      for (final XFile file in response.files!) {}
    } else {}
  }

  Future openGallery() async {
    final XFile? image =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    if (image == null) return;

    return image;
  }

  Future openCamera() async {
    final XFile? image =
        await _imagePicker.pickImage(source: ImageSource.camera);

    if (image == null) return;

    return image;
  }
}
