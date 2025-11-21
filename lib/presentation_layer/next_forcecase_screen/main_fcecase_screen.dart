import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/common/app_dimension.dart';
import 'package:weatherapp/common/celsius_convertor.dart';
import 'package:weatherapp/common/commons.dart';
import 'package:weatherapp/common/date_foramt.dart';
import 'package:weatherapp/common/glass_layer.dart';
import 'package:weatherapp/common/navigat_to.dart';
import 'package:weatherapp/constants/app_colors.dart';
import 'package:weatherapp/constants/assets.dart';
import 'package:weatherapp/constants/gaps.dart';
import 'package:weatherapp/presentation_layer/next_forcecase_screen/daily_forcecase_details/forcecase_details_screen.dart';
import 'package:weatherapp/presentation_layer/next_forcecase_screen/forcecase_tempreture_chart.dart';
import 'package:weatherapp/statemanagement_layer/get_each_day_data/each_day_data_provider.dart';
import 'package:weatherapp/statemanagement_layer/settings_state/temp_convertor_provider.dart';

class MainForcecaseScreen extends StatefulWidget {
  const MainForcecaseScreen({super.key});

  @override
  State<MainForcecaseScreen> createState() => _MainForcecaseScreenState();
}

class _MainForcecaseScreenState extends State<MainForcecaseScreen> {
  late final EachDayDataProvider dailyData;
  @override
  void initState() {
    dailyData = Provider.of<EachDayDataProvider>(
      context,
      listen: false,
    );

    dailyData.sortEachDayData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EachDayDataProvider>(
      builder: (context, dayData, _) {
        return Column(
          children: <Widget>[
            const Gaps(hRatio: 0.05),
            const Row(
              children: <Widget>[
                Gaps(wRatio: 0.05),
                Text(
                  "Next Forcecase",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  top: 10,
                  bottom: context.screenHeight * .12,
                ),
                child: Column(
                  children: <Widget>[
                    const ForcecaseTempretureChartWidget(),
                    ...List.generate(
                      dayData.daysAvargeTemp.length,
                      (index) {
                        index = index;
                        if (!(dayData.daysAvargeTemp[index] == 0.0)) {
                          return Glassmorphisim(
                            radius: 15.0,
                            child: Container(
                              margin: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                borderRadius: borderRadius(15.0),
                                color: SwitchColors.mainColor,
                                border:
                                    Border.all(color: SwitchColors.borderColor),
                              ),
                              child: Clicker(
                                radius: 15.0,
                                onClick: () {
                                  navigatTo(
                                    rout: ForcecaseDetailsScreen(
                                      dayTitle: dayData.daysTitlesList[index],
                                      forcecaseDailyData:
                                          dayData.forcecaseDailyData[index],
                                    ),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    SizedBox(
                                      width: context.screenWidth * .28,
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                            dayData.daysTitlesList[index],
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            dayData.dailyTimesTemp[index]
                                                .formateTimeTemps
                                                .formatedDate(format: "MMM d"),
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: context.screenWidth * .4,
                                      height: context.screenHeight * .1,
                                      child: Lottie.asset(Assets.cloudState),
                                    ),
                                    Text(
                                      "${dayData.daysAvargeTemp[index].celsiusConvertor.tempConvertor} $currentTempUnite",
                                      style: const TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
