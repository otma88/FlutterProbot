import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:http/http.dart' as http;

class League {
  final String url = 'http://probot-backend.test/api/auth/leagues';
  List<dynamic> data;

  Future<List<dynamic>> getLeagues() async {
    var response = await http.get(Uri.encodeFull(url), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $accessToken",
    });

    Map<String, dynamic> map = jsonDecode(response.body);
    return data = map["data"];
  }
}
