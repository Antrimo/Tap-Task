import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
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
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<Map<String, dynamic>>(
          future: companyData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            final data = snapshot.data!;

            return DefaultTabController(
              length: 2,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey.shade300,
                              width: 1,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.arrow_back),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 12,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.grey.shade300,
                                width: 1,
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                ),
                              ],
                            ),
                            child: Image.network(
                              data['logo'],
                              height: 48,
                              width: 48,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            data['company_name'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              height: 1.5,
                              letterSpacing: -0.01 * 16,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            data['description'],
                            style: const TextStyle(fontSize: 12, height: 1.5),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade100,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  "ISIN: ${data['isin']}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.green.shade100,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  data['status'],
                                  style: const TextStyle(color: Colors.green),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          const TabBar(
                            isScrollable: true,
                            labelColor: Colors.black,
                            indicatorColor: Colors.black,
                            tabAlignment: TabAlignment.start,
                            labelPadding: EdgeInsets.only(right: 20),
                            tabs: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Tab(child: Text('Tab 1')),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Tab(child: Text('Tab 2')),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: 200,
                      child: const TabBarView(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Text("Tab 1 Content"),
                          ),
                          Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Text("Tab 2 Content"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
