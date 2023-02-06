import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spots_discovery/data/endpoint/spot_endpoint.dart';
import 'package:spots_discovery/data/model/spot.dart';
import 'package:dio/dio.dart';

class HomeViewModel extends ChangeNotifier {
  final SpotEndpoint _spotEndpoint;
  HomeViewModel(this._spotEndpoint) {
    _init();
  }

  List<Spot> spots = <Spot>[];

  Future<void> _init() async {
    // Opening json file
    var jsonString = await rootBundle.loadString("assets/json/spots.json");
    // Decoding json
    var json = jsonDecode(jsonString);
    // Mapping data
    spots = List<Map<String, dynamic>>.from(json["data"])
        .map((json) => Spot.fromJson(json))
        .toList();
    notifyListeners();
    print(spots.toString());
  }

  void loadMore() async {
    /// TODO
  }

  Spot getRandom() {
    /// TODO
    spots.shuffle();
    return spots.first;
  }

  void navigateToDetail(BuildContext context) {
    /// TODO
  }

  void getSpotByName(String name) {
    /// TODO
  }

  List<Spot> getSpots() {
    return spots;
  }
}
