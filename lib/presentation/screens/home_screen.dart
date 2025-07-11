import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tap/bloc/company_cubit.dart';
import 'package:tap/color.dart';
import 'package:tap/presentation/screens/detail_screen.dart';
import 'package:tap/models/company_list_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CompanyListModel> companies = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.primary,
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
              Text(
                "SUGGESTED RESULTS",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  height: 1.5,
                  letterSpacing: 0.08 * 16,
                  color: AppColor.primaryFont,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: BlocBuilder<CompanyBloc, List<CompanyListModel>>(
                  builder: (context, companies) {
                    if (companies.isEmpty) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return Container(
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
                                HapticFeedback.lightImpact();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const DetailScreen(),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                  horizontal: 16,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                          company.logo,
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
                                              text: company.isin.substring(
                                                0,
                                                company.isin.length - 4,
                                              ),
                                              style: TextStyle(
                                                fontSize: 14,
                                                height: 1.5,
                                                letterSpacing: 0.7,
                                                color: Colors.grey.shade800,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: company.isin.substring(
                                                    company.isin.length - 4,
                                                  ),
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    height: 1.5,
                                                    letterSpacing: 0.7,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            "${company.rating} · ${company.companyName}",
                                            style: TextStyle(
                                              fontSize: 10,
                                              overflow: TextOverflow.ellipsis,
                                              color: AppColor.primaryFont,
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
                    );
                  },
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
        children: [
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
                  color: AppColor.primaryFont,
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
