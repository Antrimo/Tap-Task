import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Graph extends StatefulWidget {
  const Graph({super.key});

  @override
  State<Graph> createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  bool showEbitda = true;

  final List<double> ebitdaValues = List.generate(12, (_) => 1.0);
  final List<double> revenueValues = List.generate(12, (_) => 0.7);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        AspectRatio(
          aspectRatio: 1.6,
          child: BarChart(
            BarChartData(
              maxY: 4,
              minY: 0,
              barGroups: List.generate(12, (index) {
                return BarChartGroupData(
                  x: index,
                  barRods: [
                    BarChartRodData(
                      toY: showEbitda
                          ? ebitdaValues[index]
                          : ebitdaValues[index],
                      color: Colors.blueGrey,
                      width: 14,
                      borderRadius: BorderRadius.circular(4),
                      backDrawRodData: BackgroundBarChartRodData(
                        show: true,
                        toY: 2,
                        color: Colors.blue[100],
                      ),
                    ),
                  ],
                );
              }),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, n) {
                      if (value == 0) return const Text('');
                      if (value == 1) return const Text('1');
                      if (value == 2) return const Text('2');
                      if (value == 3) return const Text('3');
                      return const Text('');
                    },
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, _) {
                      const months = [
                        'J',
                        'F',
                        'M',
                        'A',
                        'M',
                        'J',
                        'J',
                        'A',
                        'S',
                        'O',
                        'N',
                        'D',
                      ];
                      return Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          months[value.toInt()],
                          style: const TextStyle(fontSize: 10),
                        ),
                      );
                    },
                  ),
                ),
                rightTitles: AxisTitles(),
                topTitles: AxisTitles(),
              ),
              gridData: FlGridData(show: true, drawVerticalLine: false),
              borderData: FlBorderData(show: false),
            ),
          ),
        ),
      ],
    );
  }
}
