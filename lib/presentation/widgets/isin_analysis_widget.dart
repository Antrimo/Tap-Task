import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tap/bloc/issuer_details_cubit.dart';
import 'package:tap/presentation/widgets/graph_widget.dart';
import 'package:tap/presentation/widgets/issuer_details_widget.dart';
import 'package:tap/services/api_services.dart';

class IsinAnalysisWidget extends StatefulWidget {
  const IsinAnalysisWidget({super.key});

  @override
  State<IsinAnalysisWidget> createState() => _IsinAnalysisWidgetState();
}

class _IsinAnalysisWidgetState extends State<IsinAnalysisWidget> {
  bool showEbitda = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          IssuerDetailsCubit(apiServices: ApiServices())..fetchIssuerDetails(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: const Color(0xFFE2E8F0), width: 1.0),
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
                  GraphWidget(showEbitda: showEbitda),
                ],
              ),
            ),
            const SizedBox(height: 16),
            BlocBuilder<IssuerDetailsCubit, IssuerDetailsState>(
              builder: (context, state) {
                return state.when(
                  initial: () => const SizedBox(),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  loaded: (issuerDetails) =>
                      IssuerDetailsWidget(issuerDetails: issuerDetails),
                  error: (message) => Center(child: Text('Error: $message')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget toggleButton(
    String text,
    bool selected,
    VoidCallback onTap,
    bool isLeft,
  ) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        onTap();
      },
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
}
