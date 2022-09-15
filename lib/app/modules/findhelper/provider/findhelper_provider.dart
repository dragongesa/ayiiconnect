import 'dart:developer';

import 'package:ayiconnect/app/data/models/dial_country/dial_country.dart';
import 'package:ayiconnect/app/data/utils/extensions/iterable_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:location/location.dart';

class FindHelperProvider extends ChangeNotifier {
  int currentIndex = 0;
  int? selectedRole;
  String? selectedGender;
  Location location = Location();
  String? fullName;
  DateTime? dateOfBirth;
  DialCountry? selectedDialCountry = DialCountry('+62', 'Indonesia');
  String? phoneNumber;
  double? lat;
  double? long;
  String? occupation;
  String? company;
  final List<String> _selectedLanguage = [];
  String get selectedLanguage {
    var joined = _selectedLanguage.join(', ');
    if (_selectedLanguage.isNotEmpty) {
      joined = joined.substring(0, joined.length);
    }
    return joined;
  }

  String? preferedService;
  String? userDesc;

  Future<String?> get currentLatLngGeocoding async {
    var temp = (await Geocoder.local
            .findAddressesFromCoordinates(Coordinates(lat!, long!)))
        .firstOrNull;
    String result = '';
    if (temp != null) {
      result = '${temp.adminArea}, ${temp.countryName}';
    }
    log(result.toString());
    return result;
  }

  List<String> steps = [
    'Select\nYour Role',
    'Personal\nInformation',
    'Profesional\nInformation',
  ];

  onSelectRole(int index) {
    selectedRole = index;
    currentIndex = 1;
    notifyListeners();
  }

  onSelectDateOfBirth(DateTime date) {
    dateOfBirth = date;
    notifyListeners();
  }

  onFullnameChanged(String value) {
    fullName = value;
    notifyListeners();
  }

  changeCurrentIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  onSelectGender(String gender) {
    selectedGender = gender;
    notifyListeners();
  }

  onSelectedDialCountry(DialCountry dialCountry) {
    selectedDialCountry = dialCountry;
    notifyListeners();
  }

  getCurrentLocation() async {
    var position = await location.getLocation();
    lat = position.latitude;
    long = position.longitude;
    notifyListeners();
  }

  onPhoneChanged(String value) {
    phoneNumber = value;
    log(phoneNumber ?? '');
    notifyListeners();
  }

  onOccupationChanged(String value) {
    occupation = value;
    notifyListeners();
  }

  onCompanyChanged(String value) {
    company = value;
    notifyListeners();
  }

  onAddLanguage(String language, Function() onChanged) {
    if (_selectedLanguage.contains(language)) {
      _selectedLanguage.remove(language);
    } else {
      _selectedLanguage.add(language);
    }
    Future.delayed(const Duration(milliseconds: 100), onChanged);
    notifyListeners();
  }

  onPreferedServiceChanged(String? selected) {
    preferedService = selected;
    notifyListeners();
  }

  onDescChanged(String? value) {
    userDesc = value;

    notifyListeners();
  }
}
