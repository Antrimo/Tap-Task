import 'package:flutter/material.dart';
import 'package:tap/color.dart';

class ProsAndConsWidget extends StatelessWidget {
  final List<String> pros;
  final List<String> cons;
  const ProsAndConsWidget({super.key, required this.pros, required this.cons});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: const Color(0xFFE2E8F0), width: 1.0),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(width: 8),
                const Text(
                  'Pros and Cons',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Pros',
              style: TextStyle(
                fontSize: 16,
                color: Colors.green,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            ...pros.map(
              (pro) => Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 2.0),
                      child: Container(
                        width: 18,
                        height: 18,
                        decoration: const BoxDecoration(
                          color: AppColor.check,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.check,
                          size: 12,
                          color: Color.fromRGBO(18, 129, 61, 1),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        pro,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color.fromRGBO(54, 65, 83, 1),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Cons',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromRGBO(180, 83, 9, 1),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            ...cons.map(
              (con) => Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 18,
                      height: 18,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(217, 119, 6, 0.12),
                        shape: BoxShape.circle,
                      ),
                      child: Center(child: Text("!")),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        con,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color.fromRGBO(100, 116, 139, 1),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
