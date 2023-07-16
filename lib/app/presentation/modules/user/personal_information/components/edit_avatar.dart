import 'dart:io';

import 'package:flutter_fashion/app/blocs/edit_information/edit_information_cubit.dart';
import 'package:flutter_fashion/app/models/user/user_model.dart';
import 'package:flutter_fashion/app/presentation/modules/user/home/export.dart';
import 'package:flutter_fashion/app/presentation/sign_up/widgets/choose_image_widget.dart';

const size = 130.0;

class EditAvatarCpn extends StatelessWidget {
  const EditAvatarCpn({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<EditInformationCubit>();
    final UserModel user = InheritedDataApp.of<UserModel>(context)!.data;

    if (user.photo.isNotEmpty) {
      return Center(
        child: InkWell(
          onTap: () => bloc.onChangedImage(),
          child: Stack(
            children: [
              BlocBuilder<EditInformationCubit, EditInformationState>(
                buildWhen: (p, c) => p.image != c.image,
                builder: (context, state) {
                  final isChanged = state.image != null ? true : false;

                  if (isChanged) {
                    return SizedBox(
                      width: size,
                      height: size,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(radiusBtn * 9),
                        ),
                        child: Image.file(
                          File(state.image!.path),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }

                  return SizedBox(
                    width: size,
                    height: size,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(radiusBtn * 8),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: ApiService.imageUrl + user.photo,
                        cacheKey: ApiService.imageUrl + user.photo,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
              Positioned(
                bottom: 8,
                right: 8,
                child: SvgPicture.asset(
                  Assets.editSVG,
                  colorFilter: const ColorFilter.mode(
                    secondaryColor,
                    BlendMode.srcIn,
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }
    return Center(
      child: ChooseImageWidget(
        onTap: (p0) => bloc.onChangedImage(file: p0),
        size: size,
      ),
    );
  }
}
