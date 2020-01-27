import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

class League {
  // List<dynamic> data;

//  Future<List<dynamic>> getLeagues() async {
//    var response = await http.get(Uri.encodeFull(url), headers: {
//      HttpHeaders.contentTypeHeader: "application/json",
//      HttpHeaders.authorizationHeader: "Bearer $accessToken",
//    });
//
//    Map<String, dynamic> map = jsonDecode(response.body);
//
//    return data = map["data"];
//  }

  final String id;
  final String name;
  final String flag;

  League({this.id, this.name, this.flag});

  factory League.fromJson(Map<String, dynamic> json) {
    return League(
      id: json['id'],
      name: json['name'],
      flag: json['flag'],
    );
  }
}
