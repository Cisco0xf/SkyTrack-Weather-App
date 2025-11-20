import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/common/app_dimension.dart';
import 'package:weatherapp/common/celsius_convertor.dart';
import 'package:weatherapp/common/date_foramt.dart';
import 'package:weatherapp/common/glass_layer.dart';
import 'package:weatherapp/constants/app_colors.dart';
import 'package:weatherapp/statemanagement_layer/get_each_day_data/each_day_data_provider.dart';
import 'package:weatherapp/statemanagement_layer/settings_state/temp_convertor_provider.dart';

class ForcecaseTempretureChartWidget extends StatelessWidget {
  const ForcecaseTempretureChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<EachDayDataProvider>(
      builder: (context, dayData, _) {
        return Glassmorphisim(
          radius: 15.0,
          child: Container(
            height: context.screenHeight * .34,
            width: context.screenWidth * .95,
            /*  padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ), */
            margin: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10.0,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              //color: Colors.amber,
              color: const Color(0xFF5A639C).withOpacity(0.3),
              border: Border.all(color: SwitchColors.borderColor),
            ),
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Opacity(
                    opacity: 0.4,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.asset(
                        "assets/images/png_images/chart_bg.webp",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: BarChart(
                    BarChartData(
                      maxY: 45,
                      minY: 0,
                      titlesData: const FlTitlesData(
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: false,
                          ),
                        ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: false,
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: false,
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 30,
                            getTitlesWidget: bottomTitlesSideWidget,
                          ),
                        ),
                      ),
                      borderData: FlBorderData(
                        show: true,
                        border: const Border(
                          bottom: BorderSide(
                            color: Color(0xFFFFF6E9),
                          ),
                        ),
                      ),
                      gridData: const FlGridData(
                        drawHorizontalLine: true,
                        drawVerticalLine: true,
                        show: true,
                      ),
                      barTouchData: BarTouchData(
                        touchTooltipData: BarTouchTooltipData(
                          tooltipBorder: const BorderSide(
                            color: Color(0xFFFFF6E9),
                            width: 1.3,
                          ),
                          getTooltipColor: (group) {
                            return const Color(0xFF5A639C).withOpacity(0.7);
                          },
                          tooltipRoundedRadius: 16,
                          //rotateAngle: 60,
                          getTooltipItem: (group, groupIndex, rod, rodIndex) {
                            return BarTooltipItem(
                              (rod.toY.toInt() == 0)
                                  ? "Not available"
                                  : "${dayData.dailyTimesTemp[group.x].formateTimeTemps.formatedDate(format: "MMM d")} \nAvg Temp\n${rod.toY.toInt().tempConvertor} $currentTempUnite",
                              const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          },
                        ),
                      ),
                      alignment: BarChartAlignment.spaceAround,
                      backgroundColor: Colors.transparent,
                      barGroups: <BarChartGroupData>[
                        for (int index = 0;
                            index < dayData.daysAvargeTemp.length;
                            index++) ...{
                          BarChartGroupData(
                            x: index,
                            barRods: <BarChartRodData>[
                              BarChartRodData(
                                toY: dayData.daysAvargeTemp[index] == 0.0
                                    ? 0.0
                                    : dayData
                                        .daysAvargeTemp[index].celsiusConvertor
                                        .toDouble(),
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                ),
                                color: dayData.daysAvargeTemp[index] == 0.0
                                    ? const Color(0xFF2E236C)
                                    : isChartDayToday(
                                        day: dayData.daysTitlesList[index],
                                      )
                                        ? const Color(0xFF7986cb)
                                        : const Color(0xFFF2AFEF),
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(10),
                                ),
                                width: 12,
                              ),
                            ],
                          ),
                        },
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget bottomTitlesSideWidget(double index, TitleMeta meta) {
  return SideTitleWidget(
    axisSide: meta.axisSide,
    child: BottomTitleWidget(
      index: index.toInt(),
    ),
  );
}

class BottomTitleWidget extends StatelessWidget {
  const BottomTitleWidget({
    super.key,
    required this.index,
  });
  final int index;

  @override
  Widget build(BuildContext context) {
    return Consumer<EachDayDataProvider>(
      builder: (context, dayData, _) {
        return Text(
          dayData.daysTitlesList[index].substring(0, 3),
          style: TextStyle(
            fontSize: 16,
            color: isChartDayToday(day: dayData.daysTitlesList[index])
                ? const Color(0xFF7986cb)
                : null,
            fontWeight: FontWeight.bold,
          ),
        );
      },
    );
  }
}

bool isChartDayToday({
  required String day,
}) {
  final DateTime currentDate = DateTime.now();

  String currentDay = DateFormat("EEEE").format(currentDate);

  String chartDay = currentDay;

  bool isDayToday = chartDay == day;

  return isDayToday;
}
