// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:flutter_fashion/utils/alert/loading.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';
import 'package:flutter_fashion/app/models/address/address.dart';
import 'package:flutter_fashion/core/models/address.dart';
import 'package:geolocator/geolocator.dart';
import '../../../../../../export.dart';

enum ListBuilding { province, district, commnue, desc }

class AddressManagementBloc {
  final String urlProvince =
      "https://sheltered-anchorage-60344.herokuapp.com/province";

  final String urlDistrict =
      "https://sheltered-anchorage-60344.herokuapp.com/district";

  final String urlCommune =
      "https://sheltered-anchorage-60344.herokuapp.com/commune";

  late BehaviorSubject<List<ItemProvinceModel>> _provinceSubject;

  late BehaviorSubject<List<ItemDistrictModel>> _districtSubject;

  late BehaviorSubject<List<ItemCommuneModel>> _commnueSubject;

  late BehaviorSubject<ListBuilding> _buildingSubject;

  late BehaviorSubject<List<String>> _selectedList;

  //nơi lưu giữ các giá trị của địa chỉ khi được chọn
  late List<String> _storageSelectedList;

  late List<ItemProvinceModel> _storageProvinceList;

  String desc = "";

  AddressManagementBloc() {
    _provinceSubject = BehaviorSubject.seeded([]);
    _districtSubject = BehaviorSubject.seeded([]);
    _commnueSubject = BehaviorSubject.seeded([]);
    _selectedList = BehaviorSubject.seeded([]);
    _storageSelectedList = [];
    _storageProvinceList = [];
    _buildingSubject = BehaviorSubject.seeded(ListBuilding.province);
    _fetchProvince();
  }

  BehaviorSubject<List<ItemProvinceModel>> get provinceStream =>
      _provinceSubject;

  BehaviorSubject<List<ItemDistrictModel>> get districtStream =>
      _districtSubject;

  BehaviorSubject<List<ItemCommuneModel>> get commnueStream => _commnueSubject;

  BehaviorSubject<List<String>> get seletedListStream => _selectedList;

  BehaviorSubject<ListBuilding> get buildingStream => _buildingSubject;

  Future<void> _fetchProvince() async {
    try {
      final response = await http.get(Uri.parse(urlProvince));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final list = ItemProvinceModel.listFromJson(data);

        _storageProvinceList = [...list];

        _provinceSubject.add(list);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> _fetchDistrict(String idProvince) async {
    try {
      final response =
          await http.get(Uri.parse("$urlDistrict?idProvince=$idProvince"));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final list = ItemDistrictModel.listFromJson(data);

        _districtSubject.add(list);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> _fetchCommune(String idDistrict) async {
    try {
      final response =
          await http.get(Uri.parse("$urlCommune?idDistrict=$idDistrict"));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final list = ItemCommuneModel.listFromJson(data);

        _commnueSubject.add(list);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  //add item string address on a variable _storageList
  void selectProvince(ItemProvinceModel item) {
    _storageSelectedList.add(item.name);

    //use stream build update ui
    _selectedList.add(_storageSelectedList);

    _buildingSubject.add(ListBuilding.district);

    _fetchDistrict(item.idProvince);
  }

  void selectDistrict(ItemDistrictModel item) {
    //add item string address on a variable _storageList
    _storageSelectedList.add(item.name);
    //use stream build update ui
    _selectedList.sink.add(_storageSelectedList);

    _buildingSubject.add(ListBuilding.commnue);

    _fetchCommune(item.idDistrict);
  }

  void selectCommune(ItemCommuneModel item) {
    //add item string address on a variable _storageList
    _storageSelectedList.add(item.name);
    //use stream build update ui
    _selectedList.sink.add(_storageSelectedList);

    _buildingSubject.add(ListBuilding.desc);
  }

  void setDesc(String desc) => this.desc = desc;

  void submitCreateAddress(BuildContext context) {
    String address = desc;

    _storageSelectedList.reversed.toList().forEach((element) {
      address = "$address, $element";
    });
    Navigator.of(context).pop(ItemAddress(name: address, isSelected: false));
    Future.delayed(const Duration(seconds: 1), () => reset());
  }

  void getCurrentLocation(BuildContext context) async {
    loadingAlert(context: context);
    Position position = await _determinePosition(context);
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    String address =
        '${placemarks[0].street!},${placemarks[0].locality!}, ${placemarks[0].administrativeArea!}';

    AppRoutes.router.pop();

    Navigator.of(context).pop(ItemAddress(name: address, isSelected: false));
    Future.delayed(const Duration(seconds: 1), () => reset());
  }

  Future<Position> _determinePosition(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      AppRoutes.router.pop();
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text("Vui lòng bật vị trí của điện thoại"),
          );
        },
      );
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  void reset() {
    _provinceSubject.sink.add(_storageProvinceList);
    _districtSubject.sink.add([]);
    _commnueSubject.sink.add([]);
    _selectedList.sink.add([]);
    _storageSelectedList = [];
    desc = "";
    _buildingSubject.sink.add(ListBuilding.province);
  }
}
