import 'dart:convert';
import 'package:flutter/services.dart';

class MerchantModel {
  int? id;
  String? name;
  String? address;
  double? long;
  double? lat;
  String? image;

  MerchantModel(
      {this.id, this.name, this.address, this.long, this.lat, this.image});

  MerchantModel.fromJson(Map<String, dynamic> json) {
    id = json['merchantId'];
    name = json['merchantName'];
    address = json['merchantAddress'];
    long = double.parse(json['long']);
    lat = double.parse(json['lat']);
    image = json['image'];
  }
}

Future<List<MerchantModel>> ReadJsonData() async {
  final jsondata = await rootBundle.loadString('assets/data/merchant.json');
  final List<dynamic> list = json.decode(jsondata) as List<dynamic>;
  return list.map((e) => MerchantModel.fromJson(e)).toList();
}
