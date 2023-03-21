// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'address_user_cubit.dart';

class AddressUserState extends Equatable {
  final List<ItemAddress> storageList;

  const AddressUserState({
    required this.storageList,
  });

  @override
  List<Object?> get props => [storageList];

  String toJson() {
    final listToJson = [];
    for (var item in storageList) {
      listToJson.add(item.toJson());
    }
    return jsonEncode(storageList);
  }

  List<ItemAddress> get usingAddress {
    final list = storageList.where((element) => element.isSelected).toList();
    if (list.isEmpty) return [];
    return list;
  }

  AddressUserState copyWith({
    List<ItemAddress>? storageList,
  }) {
    return AddressUserState(
      storageList: storageList ?? this.storageList,
    );
  }
}
