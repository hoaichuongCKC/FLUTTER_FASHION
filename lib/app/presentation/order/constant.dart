// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum OrderStatus {
  awaiting,
  processing,
  shipping,
  delivered,
  cancelled,
}

class ChoiceChipCustom extends Equatable {
  final int id;
  final String label;
  final Widget prefixIcon;
  const ChoiceChipCustom({
    required this.id,
    required this.label,
    required this.prefixIcon,
  });

  @override
  List<Object?> get props => [id, label, prefixIcon];

  static List<ChoiceChipCustom> get listData => const [
        ChoiceChipCustom(
          id: 1,
          label: "Chờ xác nhận",
          prefixIcon: Icon(
            Icons.hourglass_empty_outlined,
            size: 18.0,
          ),
        ),
        ChoiceChipCustom(
          id: 2,
          label: "Đang lên đơn",
          prefixIcon: Icon(
            Icons.shopping_cart_outlined,
            size: 18.0,
          ),
        ),
        ChoiceChipCustom(
          id: 3,
          label: "Đang giao",
          prefixIcon: Icon(
            Icons.local_shipping_outlined,
            size: 18.0,
          ),
        ),
        ChoiceChipCustom(
          id: 4,
          label: "Đã giao",
          prefixIcon: Icon(
            Icons.check_circle_outlined,
            size: 18.0,
          ),
        ),
        ChoiceChipCustom(
          id: 5,
          label: "Đã huỷ",
          prefixIcon: Icon(
            Icons.cancel_outlined,
            size: 18.0,
          ),
        ),
      ];
}
