import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProsAndCons extends StatefulWidget {
  const ProsAndCons({super.key});

  @override
  State<ProsAndCons> createState() => _ProsAndConsState();
}

class _ProsAndConsState extends State<ProsAndCons> {
  late Future<Map<String, dynamic>> companyData;

  Future<Map<String, dynamic>> fetchData() async {
    final response = await http.get(
      Uri.parse('https://eo61q3zd4heiwke.m.pipedream.net/'),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    companyData = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        child: Container(
          height: 800,
          color: Colors.yellow,
          child: Align(alignment: Alignment.bottomCenter, child: Text("data")),
        ),
      ),
    );
  }
}
