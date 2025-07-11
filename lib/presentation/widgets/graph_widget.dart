import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class GraphWidget extends StatefulWidget {
  final bool showEbitda;

  const GraphWidget({super.key, required this.showEbitda});

  @override
  State<GraphWidget> createState() => _GraphWidgetState();
}

class _GraphWidgetState extends State<GraphWidget> {
  final List<double> ebitdaValues = List.generate(12, (_) => 1.0);
  final List<double> revenueValues = List.generate(12, (_) => 1.7);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                      toY: widget.showEbitda
                          ? ebitdaValues[index]
                          : revenueValues[index],
                      color: widget.showEbitda
                          ? Colors.grey.shade900
                          : Colors.blue,
                      width: 16,
                      borderRadius: BorderRadius.circular(4),
                      backDrawRodData: BackgroundBarChartRodData(
                        show: widget.showEbitda,
                        toY: 1.7,
                        color: Colors.lightBlue.shade100,
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
                      if (value == 1) {
                        return const Text('₹1', style: TextStyle(fontSize: 10));
                      }
                      if (value == 2) {
                        return const Text('₹2', style: TextStyle(fontSize: 10));
                      }
                      if (value == 3) {
                        return const Text('₹3', style: TextStyle(fontSize: 10));
                      }
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
              extraLinesData: ExtraLinesData(
                verticalLines: [
                  VerticalLine(
                    x: 3.5,
                    color: Colors
                        .black, //i dont know why this isnt showing up in graph
                    strokeWidth: 4,
                    dashArray: [5, 5],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
