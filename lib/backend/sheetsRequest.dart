import 'package:http/http.dart' as http;
import '../pages/missionView.dart';
import 'package:flutter/material.dart';

import 'dart:convert';

Future<http.Response> fetchData() {
  return http.get(
      'https://script.googleusercontent.com/macros/echo?user_content_key=sK-i7Ih7z-4ejWL9kHzXx9gGFiAVBBXS9rZy4c3WvRcc1tYz0rI7JkdJK2z6Tmr2GdWmgNScbEbU5DyNqgtbcleJlTLOPYpkm5_BxDlH2jW0nuo2oDemN9CCS2h10ox_1xSncGQajx_ryfhECjZEnELbY4E7ppxKAWrbPG30sTTqGIoL3LBg6NjpvHnSf2Y68t9eu_6Q8r_W8g2MhE1T3sRmDybUbpwZ&lib=Mqk3BzsG3OKkrmQKXRlnkI6rlsreDHU_N');
}

Future<List<Mission>> fetchJsonList() async {
  print("FETCHING DATA");
  final response = await fetchData();

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON

    Map<String, dynamic> map = json.decode(response.body);

    //seznam vseh jsonov za misije
    List<dynamic> data = map["mission"];

    //nvm kak to dela
    List<Mission> misije = new List();

    for (int i = 0; i < data.length; i++) {
      dynamic missionJson = data[i];
      misije.add(Mission.fromJson(missionJson));
    }

    return misije;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
