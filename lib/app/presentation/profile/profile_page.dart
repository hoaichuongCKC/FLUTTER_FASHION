import 'dart:math';
import 'package:flutter/services.dart';
import 'package:flutter_fashion/app/common/components/user_avatar.dart';
import 'package:flutter_fashion/app/core/config/colors.dart';
import 'package:flutter_fashion/app/core/config/font_style.dart';
import 'package:flutter_fashion/app/presentation/introduction/export.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.transparent,
        title: Text(
          'Hồ sơ',
          style: PrimaryFont.instance.big(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 14.0),
            child: SvgPicture.asset("assets/icons/logout.svg"),
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: -size.height * .09,
            left: -size.width * .65,
            child: Image.asset(
              "assets/images/half_circle.png",
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Flexible(
                    flex: 5,
                    fit: FlexFit.tight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const UserAvatarApp(
                                  imageUrl:
                                      "assets/images/avatar_user_fake.jpg"),
                              const SizedBox(width: 10.0),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Flexible(
                                      flex: 2,
                                      child: FractionallySizedBox(
                                        alignment: Alignment.centerLeft,
                                        widthFactor: 0.7,
                                        child: FittedBox(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'JackTheRipper',
                                            style: PrimaryFont.instance
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.w400),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: FractionallySizedBox(
                                        alignment: Alignment.centerLeft,
                                        widthFactor: 0.45,
                                        child: FittedBox(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            '0918031587',
                                            style: PrimaryFont.instance
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.w300),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: [],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    fit: FlexFit.tight,
                    child: Row(
                      children: [
                        DecoratedBox(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: primaryColor,
                              width: 0.7,
                              style: BorderStyle.solid,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxHeight: 100.0,
                              minHeight: 90.0,
                              minWidth: 90.0,
                              maxWidth: 100.0,
                            ),
                            child: SizedBox(
                              width: size.width * 0.3,
                              height: size.width * 0.3,
                              child: const Padding(
                                padding: EdgeInsets.all(7.0),
                                child: CircleAvatar(
                                  radius: 30.0,
                                  backgroundImage: AssetImage(
                                      "assets/images/avatar_user_fake.jpg"),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(flex: 2),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
