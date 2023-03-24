// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:flutter_fashion/app/models/cart/cart.dart';
import 'package:flutter_fashion/core/status_cubit/status_cubit.dart';

class PaymentState extends Equatable {
  final String phone;
  final String fullname;
  final String note;
  final String address;
  final bool isRead;
  final AppStatus status;
  const PaymentState({
    this.phone = "",
    this.fullname = "",
    this.address = "",
    this.note = "",
    this.isRead = false,
    this.status = AppStatus.init,
  });
  @override
  List<Object> get props {
    return [
      phone,
      fullname,
      note,
      address,
      isRead,
      status,
    ];
  }

  PaymentState copyWith({
    String? phone,
    String? fullname,
    String? note,
    String? address,
    bool? isRead,
    AppStatus? status,
  }) {
    return PaymentState(
      phone: phone ?? this.phone,
      fullname: fullname ?? this.fullname,
      note: note ?? this.note,
      address: address ?? this.address,
      isRead: isRead ?? this.isRead,
      status: status ?? this.status,
    );
  }
}

class OrderParams extends Equatable {
  final String shippingAddress;
  final String shippingFullname;
  final String shippingPhone;
  final String paymentMethod;
  final List<CartModel> listCart;
  final int tempPrice;
  final int shipPrice;
  final String note;
  final int total;
  const OrderParams({
    this.shippingAddress = "",
    this.shippingFullname = "",
    this.shippingPhone = "",
    this.paymentMethod = "COD",
    required this.listCart,
    this.tempPrice = 0,
    this.shipPrice = 0,
    this.note = "",
    required this.total,
  });

  factory OrderParams.initial() => const OrderParams(listCart: [], total: 0);
  @override
  List<Object> get props {
    return [
      shippingAddress,
      shippingFullname,
      shippingPhone,
      paymentMethod,
      listCart,
      tempPrice,
      shipPrice,
      note,
      total,
    ];
  }

  Map<String, String> toMap() {
    return <String, String>{
      'shipping_address': shippingAddress,
      'shipping_fullname': shippingFullname,
      'shipping_phone': shippingPhone,
      'order_payment': paymentMethod,
      'temp_price': tempPrice.toString(),
      'ship_prce': shipPrice.toString(),
      'list_product': jsonEncode(toMapListCart()),
      'notes': note,
      'total_price': total.toString(),
    };
  }

  List toMapListCart() {
    return listCart
        .map(
          (e) => <String, dynamic>{
            'product_id': e.product.id.toString(),
            'quantity': e.quantity.toString(),
            'size': e.size,
            'color': e.color,
          },
        )
        .toList();
  }

  String toJson() => json.encode(toMap());

  OrderParams copyWith({
    String? shippingAddress,
    String? shippingFullname,
    String? shippingPhone,
    String? paymentMethod,
    List<CartModel>? listCart,
    int? tempPrice,
    int? shipPrice,
    String? note,
    int? total,
  }) {
    return OrderParams(
      shippingAddress: shippingAddress ?? this.shippingAddress,
      shippingFullname: shippingFullname ?? this.shippingFullname,
      shippingPhone: shippingPhone ?? this.shippingPhone,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      listCart: listCart ?? this.listCart,
      tempPrice: tempPrice ?? this.tempPrice,
      shipPrice: shipPrice ?? this.shipPrice,
      note: note ?? this.note,
      total: total ?? this.total,
    );
  }
}
