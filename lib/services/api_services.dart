import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tap/models/company_detail_model.dart';
import 'package:tap/models/company_list_model.dart';

class ApiServices {
  static const String listURL = 'https://eol122duf9sy4de.m.pipedream.net/';
  static const String detailURL = 'https://eo61q3zd4heiwke.m.pipedream.net/';

  static Future<List<CompanyListModel>> fetchList() async {
    final response = await http.get(Uri.parse(listURL));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> data = jsonData['data'];

      return data.map((item) => CompanyListModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load company list...');
    }
  }

  static Future<CompanyDetailModel> fetchDetail() async {
    final response = await http.get(Uri.parse(detailURL));

    if (response.statusCode == 200) {
      print("RESPONSE: ${response.body}");
      final jsonData = json.decode(response.body);
      return CompanyDetailModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to load company list...');
    }
  }
}
