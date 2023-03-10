// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class ItemAddress extends Equatable {
  final String name;
  bool isSelected;

  ItemAddress({required this.name, required this.isSelected});
  static ItemAddress fromJson(String data) {
    var x = data as ItemAddress;
    return ItemAddress(
      name: x.name,
      isSelected: x.isSelected,
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "is_selected": isSelected,
      };

  @override
  List<Object?> get props => [name, isSelected];

  ItemAddress copyWith({
    String? name,
    bool? isSelected,
  }) {
    return ItemAddress(
      name: name ?? this.name,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
