import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tap/color.dart';
import 'package:tap/detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> companies = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCompanies();
  }

  Future<void> fetchCompanies() async {
    try {
      final response = await http.get(
        Uri.parse('https://eol122duf9sy4de.m.pipedream.net/'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['data'] == null || data['data'].isEmpty) {
          throw Exception('No companies found');
        }
        setState(() {
          companies = data['data'];
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load companies');
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error loading data: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Home",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 26,
                  height: 1.5,
                  letterSpacing: -0.03 * 26,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),
              const SearchInput(),
              const SizedBox(height: 24),
              const Text(
                "SUGGESTED RESULTS",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  height: 1.5,
                  letterSpacing: 0.08 * 16,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 2),
                          ],
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: companies.map((company) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const DetailScreen(),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                    horizontal: 16,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.grey,
                                            width: 0.5,
                                          ),
                                        ),
                                        child: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                            company['logo'],
                                          ),
                                          radius: 18,
                                          backgroundColor: Colors.grey.shade200,
                                        ),
                                      ),

                                      const SizedBox(width: 10),

                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text.rich(
                                              TextSpan(
                                                text: company['isin'].substring(
                                                  0,
                                                  company['isin'].length - 4,
                                                ),
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  height: 1.5,
                                                  letterSpacing: 0.7,
                                                  color: Colors.grey,
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text: company['isin']
                                                        .substring(
                                                          company['isin']
                                                                  .length -
                                                              4,
                                                        ),
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      height: 1.5,
                                                      letterSpacing: 0.7,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              "${company['rating']} · ${company['company_name']}",
                                              style: const TextStyle(
                                                fontSize: 10,
                                                overflow: TextOverflow.ellipsis,
                                                color: Colors.black87,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      const Icon(
                                        Icons.arrow_forward_ios,
                                        size: 16,
                                        color: Colors.blue,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchInput extends StatelessWidget {
  const SearchInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 1, color: const Color(0xFFE0E0E0)),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: const [
          Icon(Icons.search, color: Colors.grey, size: 20),
          SizedBox(width: 12),
          Expanded(
            child: TextField(
              style: TextStyle(fontSize: 13, height: 1.3),
              decoration: InputDecoration(
                isCollapsed: true,
                contentPadding: EdgeInsets.symmetric(vertical: 12),
                hintText: "Search by Issuer Name or ISIN",
                hintStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                  color: Color(0xFFB5B5B5),
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
