// ignore_for_file: invalid_override_of_non_virtual_member

import 'dart:convert';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_fashion/app/blocs/user/user_cubit.dart';
import 'package:flutter_fashion/app/presentation/home/export.dart';
import 'package:flutter_fashion/core/models/address.dart';
import 'package:flutter_fashion/core/storage/key.dart';
part 'address_user_state.dart';

class AddressUserCubit extends HydratedCubit<AddressUserState> {
  AddressUserCubit() : super(const AddressUserState(storageList: []));

  @override
  String get storageToken =>
      KeyStorage.userAdress + getIt<UserCubit>().user.id.toString();

  void createNew(ItemAddress data) {
    final state = this.state;

    emit(state.copyWith(
        storageList: List<ItemAddress>.from(state.storageList)..add(data)));
  }

  void delete(ItemAddress item) {
    final state = this.state;

    emit(state.copyWith(
        storageList: List<ItemAddress>.from(state.storageList)..remove(item)));
    log("storage list :${state.storageList}", name: "Deleted_Address");
  }

  void setUseDefault(ItemAddress item) {
    final state = this.state;

    if (!(item.isSelected)) {
      final storageList = state.storageList;
      final updatedStorageList = List<ItemAddress>.from(storageList).map(
        (e) {
          if (e.name == item.name) {
            return e.copyWith(isSelected: true);
          } else {
            return e.copyWith(isSelected: false);
          }
        },
      ).toList();

      log('updated: $updatedStorageList', name: "Update variable is_selected");

      emit(state.copyWith(storageList: updatedStorageList));
    }
  }

  @override
  AddressUserState? fromJson(Map<String, dynamic> json) {
    final dataConvert = convertMapToList(jsonDecode(json["address"]));

    return AddressUserState(storageList: dataConvert);
  }

  @override
  Map<String, dynamic>? toJson(AddressUserState state) {
    return {
      "address": state.toJson(),
    };
  }

  List<ItemAddress> convertMapToList(List<dynamic> list) {
    return list.map((e) {
      return ItemAddress(
        name: e["name"],
        isSelected: e["is_selected"],
      );
    }).toList();
  }
}
