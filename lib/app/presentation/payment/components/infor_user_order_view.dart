// ignore_for_file: deprecated_member_use

import 'package:flutter_fashion/app/blocs/payment/payment.dart';
import 'package:flutter_fashion/app/blocs/payment/payment_state.dart';
import 'package:flutter_fashion/app/blocs/user/user_cubit.dart';

import '../../../../export.dart';

class InfoUserOrderView extends StatelessWidget {
  const InfoUserOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    final user = getIt.get<UserCubit>().user;
    final fullnameController = TextEditingController(text: user.fullName);
    final phoneController = TextEditingController(text: user.phone);
    final theme = Theme.of(context);
    context.read<PaymentCubit>().changedFullname(user.fullName);
    context.read<PaymentCubit>().changedPhone(user.phone);

    final noteController = TextEditingController(text: '......');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          dense: true,
          contentPadding: EdgeInsets.zero,
          minLeadingWidth: 0.0,
          leading: SvgPicture.asset(
            "assets/icons/user1.svg",
            color: primaryColor,
          ),
          title: Text(
            AppLocalizations.of(context)!.recipient_informatio,
            style: theme.textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(5.0),
            ),
            boxShadow: !ThemeDataApp.instance.isLight
                ? null
                : [
                    BoxShadow(
                      color: primaryColor.withOpacity(0.2),
                      blurRadius: 8.0,
                    )
                  ],
          ),
          child: Builder(builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ItemInforUserOrder(
                    title: AppLocalizations.of(context)!.recipient,
                    controller: fullnameController,
                    onChanged: (value) =>
                        context.read<PaymentCubit>().changedFullname(value),
                  ),
                  const SizedBox(height: 5.0),
                  BlocBuilder<PaymentCubit, PaymentState>(
                    buildWhen: (previous, current) =>
                        previous.phone != current.phone,
                    builder: (context, state) {
                      return ItemInforUserOrder(
                        title: AppLocalizations.of(context)!.phoneNumber,
                        controller: phoneController,
                        hintText: state.phone.isEmpty
                            ? "Vui lòng nhập số điện thoại"
                            : "",
                        onChanged: (value) =>
                            context.read<PaymentCubit>().changedPhone(value),
                      );
                    },
                  ),
                  const SizedBox(height: 5.0),
                  ItemInforUserOrder(
                    title: AppLocalizations.of(context)!.note,
                    controller: noteController,
                    onChanged: (value) =>
                        context.read<PaymentCubit>().changeNote(value),
                  ),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }
}

class ItemInforUserOrder extends StatefulWidget {
  const ItemInforUserOrder(
      {super.key,
      required this.title,
      required this.controller,
      required this.onChanged,
      this.hintText});
  final String title;
  final void Function(String) onChanged;
  final TextEditingController controller;
  final String? hintText;
  @override
  State<ItemInforUserOrder> createState() => _ItemInforUserOrderState();
}

class _ItemInforUserOrderState extends State<ItemInforUserOrder> {
  @override
  void dispose() {
    super.dispose();
    widget.controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: theme.textTheme.bodyMedium!.copyWith(
            fontSize: 14.0,
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: TextField(
            onChanged: widget.onChanged,
            textAlign: TextAlign.end,
            controller: widget.controller,
            style: theme.textTheme.bodyMedium!.copyWith(
              fontSize: 14.0,
            ),
            decoration: InputDecoration.collapsed(
              hintText: widget.hintText ?? "",
              hintStyle: theme.textTheme.bodySmall!.copyWith(
                color: errorColor,
              ),
            ),
          ),
        )
      ],
    );
  }
}
