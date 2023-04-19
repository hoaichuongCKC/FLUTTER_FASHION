import 'dart:io';

import 'package:flutter_fashion/core/camera/camera_info.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../export.dart';

class ChooseAvatar extends StatefulWidget {
  const ChooseAvatar({super.key, this.onTap});
  static const dashedHeight = 3.0;
  static const spaceWidth = 5.0;
  static const dashedWidth = 12.0;
  static const size = 150.0;
  static const dashSpace = 5.0;
  final void Function(Widget, XFile)? onTap;
  @override
  State<ChooseAvatar> createState() => _ChooseAvatarState();
}

class _ChooseAvatarState extends State<ChooseAvatar> {
  bool get _isOnTap => widget.onTap == null;
  Widget? _image;
  XFile? _file;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await _handleImage();
        if (!_isOnTap) {
          widget.onTap!(_image!, _file!);
        }
      },
      child: SizedBox(
        width: ChooseAvatar.size,
        height: ChooseAvatar.size,
        child: Stack(
          children: [
            const SquareDashedWidget(
              dashedHeight: ChooseAvatar.dashedHeight,
              dashedWidth: ChooseAvatar.dashedWidth,
              size: ChooseAvatar.size,
              spaceWidth: ChooseAvatar.spaceWidth,
            ),
            Align(
              child: _image ??
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/camera.svg",
                        width: 24.0,
                        height: 24.0,
                      ),
                      const SizedBox(height: ChooseAvatar.size * 0.05),
                      Text(
                        AppLocalizations.of(context)!.uploadFile,
                        style: PrimaryFont.instance.copyWith(
                          fontSize: 14.0,
                        ),
                      )
                    ],
                  ),
            )
          ],
        ),
      ),
    );
  }

  Future _handleImage() async {
    _file = await getIt.get<CameraInfo>().chooseImage();

    _image = ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(100.0)),
      child: SizedBox(
        width: ChooseAvatar.size - ChooseAvatar.size * 0.3,
        height: ChooseAvatar.size - ChooseAvatar.size * 0.3,
        child: AspectRatio(
          aspectRatio: 1.0,
          child: Image.file(
            File(_file!.path),
            width: ChooseAvatar.size - ChooseAvatar.size * 0.3,
            height: ChooseAvatar.size - ChooseAvatar.size * 0.3,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
    setState(() {});
  }
}

class SquareDashedWidget extends StatelessWidget {
  const SquareDashedWidget(
      {super.key,
      required this.size,
      required this.dashedWidth,
      required this.dashedHeight,
      required this.spaceWidth});
  final double size;
  final double dashedWidth;
  final double dashedHeight;
  final double spaceWidth;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: 0.0,
            left: 0.0,
            width: size,
            child: _buildDashedSquere(),
          ),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            width: size,
            child: _buildDashedSquere(),
          ),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            height: size,
            child: _buildVerticalDashedSquere(),
          ),
          Positioned(
            bottom: 0.0,
            right: 0.0,
            height: size,
            child: _buildVerticalDashedSquere(),
          ),
        ],
      ),
    );
  }

  _buildDashedSquere() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children:
          List.generate((size / (dashedWidth + spaceWidth)).floor(), (index) {
        final lastLength = (size / (dashedWidth + spaceWidth)).floor() - 1;
        final bool isBorder = index > 0 && index < lastLength;
        BorderRadiusGeometry? border;
        if (index == 0) {
          border = const BorderRadius.only(
            topLeft: Radius.circular(5.0),
            bottomLeft: Radius.circular(5.0),
          );
        } else if (index == lastLength) {
          border = const BorderRadius.only(
            topRight: Radius.circular(5.0),
            bottomRight: Radius.circular(5.0),
          );
        }
        return Container(
          width: dashedWidth,
          height: dashedHeight,
          decoration: BoxDecoration(
            color: lightColor,
            borderRadius: !isBorder ? border : null,
          ),
        );
      }),
    );
  }

  _buildVerticalDashedSquere() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children:
          List.generate((size / (dashedWidth + spaceWidth)).floor(), (index) {
        final lastLength = (size / (dashedWidth + spaceWidth)).floor() - 1;
        final bool isBorder = index > 0 && index < lastLength;
        BorderRadiusGeometry? border;
        if (index == 0) {
          border = const BorderRadius.only(
            topLeft: Radius.circular(5.0),
            topRight: Radius.circular(5.0),
          );
        } else if (index == lastLength) {
          border = const BorderRadius.only(
            bottomLeft: Radius.circular(5.0),
            bottomRight: Radius.circular(5.0),
          );
        }
        return Container(
          width: dashedHeight,
          height: dashedWidth,
          decoration: BoxDecoration(
            color: lightColor,
            borderRadius: !isBorder ? border : null,
          ),
        );
      }),
    );
  }
}
