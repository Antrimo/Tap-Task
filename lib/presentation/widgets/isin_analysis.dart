import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tap/presentation/widgets/graph.dart';

class IsinAnalysis extends StatefulWidget {
  const IsinAnalysis({super.key});

  @override
  State<IsinAnalysis> createState() => _IsinAnalysisState();
}

class _IsinAnalysisState extends State<IsinAnalysis> {
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
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: const Color(0xFFE2E8F0),
                    width: 1.0,
                  ),
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
                            fontSize: 10,
                            letterSpacing: 0.08 * 12,
                            height: 1.5,
                            color: Colors.grey,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          height: 30,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF4F4F4),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
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
                padding: const EdgeInsets.all(16.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: const Color(0xFFE2E8F0),
                    width: 1.0,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info_outline_rounded,
                          color: Colors.grey.shade900,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Issuer Details',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.grey.shade300,
                      thickness: 1,
                      height: 24,
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
      Text(
        label,
        style: TextStyle(
          color: Colors.blue.shade700,
          fontSize: 12,
          fontWeight: FontWeight.w500,
          height: 1.5,
        ),
      ),
      const SizedBox(height: 6),
      Text(
        value,
        style: TextStyle(
          color: Colors.grey.shade900,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      const SizedBox(height: 30),
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
      padding: const EdgeInsets.symmetric(horizontal: 8),
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
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: selected ? Colors.black : Colors.grey,
          ),
        ),
      ),
    ),
  );
}
