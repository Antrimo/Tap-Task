import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tap/bloc/company_cubit.dart';
import 'package:tap/bloc/search_cubit.dart';
import 'package:tap/color.dart';
import 'package:tap/presentation/screens/detail_screen.dart';
import 'package:tap/models/company_list_model.dart';
import 'package:tap/presentation/widgets/search.dart';
import 'package:tap/services/api_services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => SearchCubit())],
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColor.primary,
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 20.5,
            ),
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
                BlocBuilder<SearchCubit, String>(
                  builder: (context, query) {
                    return Text(
                      query.isEmpty ? "SUGGESTED RESULTS" : "SEARCH RESULTS",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        height: 1.5,
                        letterSpacing: 0.08 * 12,
                        color: AppColor.primaryFont,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: BlocBuilder<CompanyListCubit, List<CompanyListModel>>(
                    builder: (context, companies) {
                      return BlocBuilder<SearchCubit, String>(
                        builder: (context, query) {
                          if (companies.isEmpty) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          final filteredCompanies = companies.where((company) {
                            return company.isin.toLowerCase().contains(query) ||
                                company.companyName.toLowerCase().contains(
                                  query,
                                ) ||
                                company.rating.toLowerCase().contains(query);
                          }).toList();

                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(color: Colors.black12, blurRadius: 2),
                              ],
                            ),
                            child: filteredCompanies.isEmpty
                                ? Center(
                                    child: Text(
                                      'No results found',
                                      style: TextStyle(
                                        color: AppColor.primaryFont,
                                        fontSize: 16,
                                      ),
                                    ),
                                  )
                                : SingleChildScrollView(
                                    child: Column(
                                      children: filteredCompanies.map((
                                        company,
                                      ) {
                                        return GestureDetector(
                                          onTap: () {
                                            HapticFeedback.lightImpact();
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    BlocProvider(
                                                      create: (_) =>
                                                          CompanyDetailCubit(
                                                            apiServices:
                                                                ApiServices(),
                                                          )..fetchDetail(),
                                                      child: DetailScreen(),
                                                    ),
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
                                                  padding: const EdgeInsets.all(
                                                    2,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color: AppColor.border,
                                                      width: 1,
                                                    ),
                                                  ),
                                                  child: CircleAvatar(
                                                    backgroundImage:
                                                        NetworkImage(
                                                          company.logo,
                                                        ),
                                                    radius: 18,
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text.rich(
                                                        TextSpan(
                                                          text: company.isin
                                                              .substring(
                                                                0,
                                                                company
                                                                        .isin
                                                                        .length -
                                                                    4,
                                                              ),
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            height: 1.5,
                                                            letterSpacing: 0.7,
                                                            color: Colors
                                                                .grey
                                                                .shade800,
                                                          ),
                                                          children: [
                                                            TextSpan(
                                                              text: company.isin
                                                                  .substring(
                                                                    company
                                                                            .isin
                                                                            .length -
                                                                        4,
                                                                  ),
                                                              style: const TextStyle(
                                                                fontSize: 16,
                                                                height: 1.5,
                                                                letterSpacing:
                                                                    0.7,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(height: 2),
                                                      Text(
                                                        "${company.rating} ● ${company.companyName}",
                                                        style: TextStyle(
                                                          fontSize: 10,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          color: AppColor
                                                              .primaryFont,
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
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
