import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tap/bloc/company_cubit.dart';
import 'package:tap/color.dart';
import 'package:tap/models/company_detail_model.dart';
import 'package:tap/presentation/widgets/isin_analysis_widget.dart';
import 'package:tap/presentation/widgets/pros_and_cons_widget.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<CompanyDetailCubit, CompanyDetailModel?>(
          builder: (context, data) {
            if (data == null) {
              return Center(child: CircularProgressIndicator());
            }

            return DefaultTabController(
              length: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: GestureDetector(
                      onTap: () {
                        HapticFeedback.lightImpact();
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 2.0,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: const Icon(Icons.arrow_back),
                      ),
                    ),
                  ),
                  Column(
                    children: [
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
                                  color: AppColor.border,
                                  width: 1.0,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    offset: Offset(0, 2),
                                    blurRadius: 6,
                                    spreadRadius: -1,
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(data.logo),
                              ),
                            ),

                            const SizedBox(height: 12),
                            Text(
                              data.companyName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                height: 1.5,
                                letterSpacing: -0.01 * 16,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              data.description,
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
                                    color: Colors.blue.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Text(
                                    "ISIN: ${data.isin}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: AppColor.isin,
                                      height: 1.5,
                                      letterSpacing: 0.08 * 16,
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
                                    color: Colors.green.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Text(
                                    data.status,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: AppColor.green,
                                      height: 1.5,
                                      letterSpacing: 0.08 * 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
                      const TabBar(
                        isScrollable: true,
                        labelColor: Colors.blue,
                        indicatorColor: Colors.blue,
                        tabAlignment: TabAlignment.start,
                        tabs: [
                          Tab(child: Text('ISIN Analysis')),
                          Tab(child: Text('Pros & Cons')),
                        ],
                      ),
                    ],
                  ),

                  Expanded(
                    child: TabBarView(
                      children: [
                        const IsinAnalysisWidget(),
                        ProsAndConsWidget(
                          pros: data.prosAndCons.pros,
                          cons: data.prosAndCons.cons,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
