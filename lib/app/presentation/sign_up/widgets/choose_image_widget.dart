import 'dart:io';

import 'package:flutter_fashion/core/camera/camera_info.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../export.dart';

class ChooseImageWidget extends StatefulWidget {
  const ChooseImageWidget({
    super.key,
    this.onTap,
    this.color = lightColor,
    this.isChooseMultipleImage = false,
    this.onListen,
    this.size = 140.0,
    this.dashedWidth = 10.0,
    this.spaceWidth = 5.0,
  });
  final double dashedHeight = 2.0;
  final double spaceWidth;
  final double dashedWidth;
  final double size;
  final double dashSpace = 5.0;
  final void Function(XFile)? onTap;
  final Color color;
  final bool isChooseMultipleImage;
  final void Function(List<XFile>?)? onListen;
  @override
  State<ChooseImageWidget> createState() => _ChooseImageWidgetState();
}

class _ChooseImageWidgetState extends State<ChooseImageWidget> {
  bool get _isOnTap => widget.onTap == null;

  Color get _color => widget.color;

  bool get _isMultipleImage => widget.isChooseMultipleImage;

  final ValueNotifier<Widget?> _notifier = ValueNotifier(null);

  @override
  void dispose() {
    _notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () => _isMultipleImage ? _handleMultipleImage() : _handleImage(),
      child: SizedBox(
        width: widget.size,
        height: widget.size,
        child: Stack(
          children: [
            SquareDashedWidget(
              dashedHeight: widget.dashedHeight,
              dashedWidth: widget.dashedWidth,
              size: widget.size,
              color: _color,
              spaceWidth: widget.spaceWidth,
            ),
            Align(
              child: ValueListenableBuilder<Widget?>(
                valueListenable: _notifier,
                builder: (context, Widget? image, child) {
                  if (image != null) return image;
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/camera.svg",
                        width: 24.0,
                        height: 24.0,
                        fit: BoxFit.scaleDown,
                      ),
                      SizedBox(height: widget.size * 0.05),
                      Text(
                        AppLocalizations.of(context)!.uploadFile,
                        style: theme.textTheme.bodyMedium!.copyWith(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Future _handleMultipleImage() async {
    final List<XFile>? files = await getIt.get<CameraInfo>().chooseImages();
    if (widget.onListen == null) return;

    widget.onListen!(files);
  }

  Future _handleImage() async {
    final XFile? file = await getIt.get<CameraInfo>().chooseImage();

    if (file == null) return;

    if (!_isOnTap) {
      widget.onTap!(file);
    }

    final image = ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(100.0)),
      child: SizedBox(
        width: widget.size - widget.size * 0.3,
        height: widget.size - widget.size * 0.3,
        child: AspectRatio(
          aspectRatio: 1.0,
          child: Image.file(
            File(file.path),
            width: widget.size - widget.size * 0.3,
            height: widget.size - widget.size * 0.3,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
    _notifier.value = image;
  }
}

class SquareDashedWidget extends StatelessWidget {
  const SquareDashedWidget({
    super.key,
    required this.size,
    required this.dashedWidth,
    required this.dashedHeight,
    required this.spaceWidth,
    required this.color,
  });
  final double size;
  final double dashedWidth;
  final double dashedHeight;
  final double spaceWidth;
  final Color color;
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
            child: _buildDashedSquere(color),
          ),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            width: size,
            child: _buildDashedSquere(color),
          ),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            height: size,
            child: _buildVerticalDashedSquere(color),
          ),
          Positioned(
            bottom: 0.0,
            right: 0.0,
            height: size,
            child: _buildVerticalDashedSquere(color),
          ),
        ],
      ),
    );
  }

  _buildDashedSquere(color) {
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
            color: color,
            borderRadius: !isBorder ? border : null,
          ),
        );
      }),
    );
  }

  _buildVerticalDashedSquere(color) {
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
            color: color,
            borderRadius: !isBorder ? border : null,
          ),
        );
      }),
    );
  }
}
