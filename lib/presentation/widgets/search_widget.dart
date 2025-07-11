import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tap/color.dart';
import 'package:tap/bloc/search_cubit.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final searchCubit = context.read<SearchCubit>();

    return Container(
      height: 42,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 1, color: AppColor.border),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: BlocBuilder<SearchCubit, String>(
        builder: (context, query) {
          return Row(
            children: [
              Icon(Icons.search, color: Colors.grey.shade500, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  onChanged: searchCubit.updateSearch,
                  style: const TextStyle(fontSize: 13, height: 1.3),
                  decoration: InputDecoration(
                    isCollapsed: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
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
          );
        },
      ),
    );
  }
}
