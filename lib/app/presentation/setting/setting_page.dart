// ignore_for_file: deprecated_member_use

import 'package:flutter_fashion/app/presentation/login/export.dart';
import 'package:flutter_fashion/app/presentation/setting/components/item_seting.dart';
import 'package:flutter_fashion/common/components/app/background_app.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return BaseAppBackground(
      title: 'Cài đặt',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 15.0),
          ItemSetting(
            title: "Ngôn ngữ",
            titleTrailing: "Việt Nam",
            subtitle: "(Mặc định ngôn ngữ là Tiếng Việt)",
            excute: () {},
            color: const Color(0xFFFF9F43),
            icon: SvgPicture.asset("assets/icons/setting/language.svg"),
          ),
          const SizedBox(height: 15.0),
          ItemSetting(
            title: "Chế độ tối",
            titleTrailing: "Bật",
            excute: () {},
            color: primaryColor,
            icon: SvgPicture.asset("assets/icons/setting/moon.svg"),
          ),
          const SizedBox(height: 15.0),
          ItemSetting(
            title: "Thông báo",
            titleTrailing: "Âm thanh",
            excute: () {},
            color: const Color(0xFFFF7043),
            icon: SvgPicture.asset("assets/icons/notification.svg",
                color: const Color(0xFFFF7043)),
          ),
        ],
      ),
    );
  }
}
