// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_fashion/app/models/promotion/promotion_model.dart';
import 'package:flutter_fashion/core/status_cubit/status_cubit.dart';

class PaymentState extends Equatable {
  final String phone;

  final String fullname;

  final String note;

  final String address;

  final bool isRead;

  final PromotionModel promotion;

  final AppStatus status;

  const PaymentState({
    this.phone = "",
    this.fullname = "",
    this.address = "",
    this.note = "Note",
    this.isRead = false,
    this.promotion = const PromotionModel(
        id: 0,
        name: '',
        code: '',
        desc: '',
        order_price_conditions: 0,
        discount_price: 0,
        limit: 0,
        end_date: null,
        created_at: null),
    this.status = AppStatus.init,
  });
  @override
  List<Object> get props {
    return [phone, fullname, note, address, isRead, status, promotion];
  }

  PaymentState copyWith({
    String? phone,
    String? fullname,
    String? note,
    String? address,
    bool? isRead,
    PromotionModel? promotion,
    AppStatus? status,
  }) {
    return PaymentState(
      phone: phone ?? this.phone,
      fullname: fullname ?? this.fullname,
      note: note ?? this.note,
      address: address ?? this.address,
      isRead: isRead ?? this.isRead,
      promotion: promotion ?? this.promotion,
      status: status ?? this.status,
    );
  }
}
