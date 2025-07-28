import 'package:ahmed_shop/constant/app_colors.dart';
import 'package:ahmed_shop/utils/app_log.dart';
import 'package:ahmed_shop/utils/app_size.dart';
import 'package:ahmed_shop/utils/gap.dart';
import 'package:ahmed_shop/widgets/texts/app_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'controller/analytics_screen_controller.dart';

class OwnerAnalyticScreen extends StatefulWidget {
  const OwnerAnalyticScreen({super.key});

  @override
  State<OwnerAnalyticScreen> createState() => _OwnerAnalyticScreenState();
}

class _OwnerAnalyticScreenState extends State<OwnerAnalyticScreen> {
  final OwnerAnalyticsScreenController controller = Get.put(
    OwnerAnalyticsScreenController(),
  );
  late int totalOrder;

  @override
  void initState() {
    super.initState();
    // Data fetching is now handled in controller's onInit
    totalOrder = 0; // Will be updated when data loads
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.instance.ownerPhoneBackground,
      // Light background color
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: LoadingAnimationWidget.threeArchedCircle(
              color: AppColors.instance.red400,
              size: AppSize.height(value: 40),
            ),
          );
        }

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // First Container: Total Product, Total Earning, Status
                _buildCombinedStatCard([
                  _buildStatItem(
                    "Total Product",
                    controller.overViewList.value?.data?.productCount
                            ?.toString() ??
                        "0",
                  ),
                  _buildStatItem(
                    "Total Earning",
                    controller.overViewList.value?.data?.totalEarning
                            ?.toStringAsFixed(2) ??
                        "0.0",
                  ),
                  // _buildStatItem("Status", "Active"),
                ], Colors.red),
                const SizedBox(height: 16),
                // Second Container: Total Order, Pending Order, Filter
                _buildCombinedStatCard([
                  _buildStatItem(
                    "Total Order",
                    controller.overViewList.value?.data?.totalOrder
                            ?.toString() ??
                        "0",
                  ),
                  _buildStatItem(
                    "Pending Order",
                    controller.overViewList.value?.data?.totalPendingOrder
                            ?.toString() ??
                        "0",
                  ),
                  //_buildStatItem("All", totalOrder.toString()),
                ], Colors.white),
                const SizedBox(height: 16),
                // Line Chart: Total Earning
                _buildLineChart(),
              ],
            ),
          ),
        );
      }),
    );
  }

  //! Widget for the combined stat card (all items in one container)
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: children.map((child) {
          return Expanded(child: Center(child: child));
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
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        Gap(height: AppSize.height(value: 8)),
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
              AppText(
                text: "Total Earning",
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              Row(
                children: [
                  AppText(
                    text: " Last 7 days",
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  IconButton(
                    icon: const Icon(Icons.refresh, size: 20),
                    onPressed: () => controller.fetchAllData(),
                  ),
                  // IconButton(
                  //   icon: const Icon(Icons.bug_report, size: 20),
                  //   onPressed: () => controller.createTestData(),
                  // ),
                ],
              ),
            ],
          ),
          Gap(height: AppSize.height(value: 16)),
          SizedBox(
            height: AppSize.height(value: 200),
            child: Obx(() {
              if (controller.isIncomeRatioLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              final incomeData = controller.incomeRatioList.value?.data ?? [];

              // If no data, show empty chart
              if (incomeData.isEmpty) {
                return const Center(
                  child: Text(
                    "No data available",
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                );
              }

              // Filter out null dates and sort data by date
              final validData = incomeData
                  .where((datum) => datum.dateHour != null)
                  .toList();

              final sortedData = List.from(validData)
                ..sort((a, b) => a.dateHour!.compareTo(b.dateHour!));

              // Debug logging
              appLog("Chart data - Total items: ${incomeData.length}");
              appLog("Chart data - Valid items: ${validData.length}");
              appLog("Chart data - Sorted items: ${sortedData.length}");

              // Create FlSpot list from sorted data
              final spots = sortedData.asMap().entries.map((entry) {
                final index = entry.key;
                final datum = entry.value;
                final spot = FlSpot(index.toDouble(), datum.totalIncome ?? 0.0);
                appLog("Chart spot: x=${spot.x}, y=${spot.y}");
                return spot;
              }).toList();

              // Find max income for chart scaling (ensure minimum scale)
              final incomeValues = sortedData
                  .map((d) => d.totalIncome ?? 0.0)
                  .where((income) => income > 0)
                  .toList();

              final maxIncome = incomeValues.isEmpty
                  ? 10.0
                  : incomeValues.reduce((a, b) => a > b ? a : b);

              // Set minimum scale to 10 if max income is less than 10
              final chartMaxY = maxIncome < 10 ? 10.0 : maxIncome * 1.2;

              // Debug chart scaling
              appLog("Chart scaling - Max income: $maxIncome");
              appLog("Chart scaling - Chart maxY: $chartMaxY");
              appLog("Chart scaling - Spots count: ${spots.length}");

              // If no valid spots, show message
              if (spots.isEmpty) {
                return const Center(
                  child: Text(
                    "No valid data points to display",
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                );
              }

              return LineChart(
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
                      sideTitles: SideTitles(
                        showTitles: false,
                      ), // Hide left titles
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: false,
                      ), // Hide right titles
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: false,
                      ), // Hide top titles
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

                          final index = value.toInt();
                          if (index >= 0 && index < sortedData.length) {
                            final date = sortedData[index].dateHour;
                            if (date != null) {
                              final formattedDate = DateFormat(
                                'dd MMM',
                              ).format(date);
                              return Text(
                                formattedDate.toUpperCase(),
                                style: style,
                              );
                            }
                          }
                          return Container();
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  minX: 0,
                  maxX: sortedData.isEmpty
                      ? 1.0
                      : (sortedData.length - 1).toDouble(),
                  minY: 0,
                  maxY: chartMaxY,
                  lineBarsData: [
                    LineChartBarData(
                      spots: spots,
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
              );
            }),
          ),
        ],
      ),
    );
  }
}
