import 'package:ahmed_shop/constant/app_colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class OwnerAnalyticScreen extends StatefulWidget {
  const OwnerAnalyticScreen({super.key});

  @override
  State<OwnerAnalyticScreen> createState() => _OwnerAnalyticScreenState();
}

class _OwnerAnalyticScreenState extends State<OwnerAnalyticScreen> {
  String _selectedFilter = "Last Week"; // Default filter value
  final List<String> _filterOptions = [
    "This Week",
    "Last Day",
    "Today",
    "Last Month",
    "Last Week",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.instance.ownerPhoneBackground,
      // Light background color
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // First Container: Total Product, Total Earning, Status
              _buildCombinedStatCard(
                [
                  _buildStatItem("Total Product", "133"),
                  _buildStatItem("Total Earning", "\$2,423"),
                  _buildStatItem("Status", "Active"),
                ],
                Colors.red,
              ),
              const SizedBox(height: 16),
              // Second Container: Total Order, Pending Order, Filter
              _buildCombinedStatCard(
                [
                  _buildStatItem("Total Order", "120"),
                  _buildStatItem("Pending Order", "04"),
                  _buildStatItem("All", ""),
                ],
                Colors.white,
              ),
              const SizedBox(height: 16),
              // Line Chart: Total Earning
              _buildLineChart(),
            ],
          ),
        ),
      ),
    );
  }

  // Widget for the combined stat card (all items in one container)
  Widget _buildCombinedStatCard(List<Widget> children, Color backgroundColor) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(51),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: children.map((child) {
          return Expanded(
            child: Center(child: child),
          );
        }).toList(),
      ),
    );
  }

  // Widget for individual stat items (Total Product, Total Earning, etc.)
  Widget _buildStatItem(String title, String value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  // Widget for the filter button with dropdown

  // Widget for the Line Chart
  Widget _buildLineChart() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(51),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "TOTAL EARNING",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedFilter,
                    icon: const Icon(Icons.arrow_drop_down, size: 20),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedFilter = newValue!;
                        // In a real app, you would update the chart data here based on the filter
                      });
                    },
                    items: _filterOptions
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: true,
                  horizontalInterval: 1,
                  verticalInterval: 1,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: Colors.grey.shade200,
                      strokeWidth: 1,
                    );
                  },
                  getDrawingVerticalLine: (value) {
                    return FlLine(
                      color: Colors.grey.shade200,
                      strokeWidth: 1,
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles:
                        SideTitles(showTitles: false), // Hide left titles
                  ),
                  rightTitles: AxisTitles(
                    sideTitles:
                        SideTitles(showTitles: false), // Hide right titles
                  ),
                  topTitles: AxisTitles(
                    sideTitles:
                        SideTitles(showTitles: false), // Hide top titles
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        const style = TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        );
                        String text;
                        switch (value.toInt()) {
                          case 0:
                            text = "16 MAR";
                            break;
                          case 1:
                            text = "17 MAR";
                            break;
                          case 2:
                            text = "18 MAR";
                            break;
                          case 3:
                            text = "19 MAR";
                            break;
                          case 4:
                            text = "20 MAR";
                            break;
                          case 5:
                            text = "21 MAR";
                            break;
                          case 6:
                            text = "22 MAR";
                            break;
                          default:
                            return Container();
                        }
                        return Text(text, style: style);
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                minX: 0,
                maxX: 6,
                minY: 0,
                maxY: 6,
                lineBarsData: [
                  LineChartBarData(
                    spots: const [
                      FlSpot(0, 1),
                      FlSpot(1, 0.5),
                      FlSpot(2, 3),
                      FlSpot(3, 2),
                      FlSpot(4, 4),
                      FlSpot(5, 2),
                      FlSpot(6, 3),
                    ],
                    isCurved: true,
                    color: Colors.red,
                    barWidth: 2,
                    belowBarData: BarAreaData(
                      show: true,
                      color: Colors.red.withAlpha(51),
                    ),
                    dotData: FlDotData(show: false),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
