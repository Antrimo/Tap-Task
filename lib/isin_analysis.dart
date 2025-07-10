import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tap/graph.dart';

class ISINAnalysis extends StatefulWidget {
  const ISINAnalysis({super.key});

  @override
  State<ISINAnalysis> createState() => _ISINAnalysisState();
}

class _ISINAnalysisState extends State<ISINAnalysis> {
  late Future<Map<String, dynamic>> companyData;
  bool showEbitda = true;

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
    return FutureBuilder<Map<String, dynamic>>(
      future: companyData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final data = snapshot.data!;

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                height: 400,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(
                        255,
                        15,
                        11,
                        11,
                      ).withOpacity(0.1),
                      blurRadius: 10.0,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "COMPANY FINANCIALS",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            letterSpacing: 0.08 * 14,
                            height: 1.5,
                            color: Colors.grey,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFF4F4F4),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.all(4),
                          child: Row(
                            children: [
                              toggleButton("EBITDA", showEbitda, () {
                                setState(() {
                                  showEbitda = true;
                                });
                              }, true),

                              toggleButton("Revenue", !showEbitda, () {
                                setState(() {
                                  showEbitda = false;
                                });
                              }, false),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Graph(showEbitda: showEbitda),

                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                height: 450,
                padding: const EdgeInsets.all(16.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10.0,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Issuer Details',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    issuerDetails(
                      "Issuer Name",
                      data["issuer_details"]["issuer_name"],
                    ),
                    issuerDetails(
                      "Type of Issuer",
                      data["issuer_details"]["type_of_issuer"],
                    ),
                    issuerDetails("Sector", data["issuer_details"]["sector"]),
                    issuerDetails(
                      "Industry",
                      data["issuer_details"]["industry"],
                    ),
                    issuerDetails(
                      "Issuer Nature",
                      data["issuer_details"]["issuer_nature"],
                    ),
                    issuerDetails("CIN", data["issuer_details"]["cin"]),
                    issuerDetails(
                      "Lead Manager",
                      data["issuer_details"]["lead_manager"],
                    ),
                    issuerDetails(
                      "Registrar",
                      data["issuer_details"]["registrar"],
                    ),
                    issuerDetails(
                      "Debenture Trustee",
                      data["issuer_details"]["debenture_trustee"],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

Widget issuerDetails(String label, String value) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("$label:", style: const TextStyle(fontWeight: FontWeight.w600)),
      Text(value),
    ],
  );
}

Widget toggleButton(
  String text,
  bool selected,
  VoidCallback onTap,
  bool isLeft,
) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: selected ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.only(
          topLeft: isLeft
              ? const Radius.circular(30)
              : (selected ? Radius.zero : const Radius.circular(30)),
          bottomLeft: isLeft
              ? const Radius.circular(30)
              : (selected ? Radius.zero : const Radius.circular(30)),
          topRight: !isLeft
              ? const Radius.circular(30)
              : (selected ? Radius.zero : const Radius.circular(30)),
          bottomRight: !isLeft
              ? const Radius.circular(30)
              : (selected ? Radius.zero : const Radius.circular(30)),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: selected ? Colors.black : Colors.grey,
        ),
      ),
    ),
  );
}
