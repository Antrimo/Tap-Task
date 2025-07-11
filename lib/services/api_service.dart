import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tap/models/company_list_model.dart';

class ApiService {
  static const String listURL = 'https://eol122duf9sy4de.m.pipedream.net/';

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
}
