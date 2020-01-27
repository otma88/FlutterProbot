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
  final String country_id;
  final String name;
  final String country_code;
  final String season;
  final String logo;
  final String flag;
  final String created_at;
  final String updated_at;

  League(
      {this.id,
      this.country_id,
      this.name,
      this.country_code,
      this.season,
      this.logo,
      this.flag,
      this.created_at,
      this.updated_at});

  factory League.fromJson(Map<String, dynamic> json) {
    return League(
        id: json['id'].toString(),
        country_id: json['country_id'].toString(),
        name: json['name'],
        country_code: json['country_code'],
        season: json['season'].toString(),
        logo: json['logo'],
        flag: json['flag'],
        created_at: json['created_at'],
        updated_at: json['updated_at']);
  }
}
