import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';
import 'package:weatherapp/common/app_dimension.dart';
import 'package:weatherapp/common/commons.dart';
import 'package:weatherapp/common/my_logger.dart';
import 'package:weatherapp/common/show_notification.dart';
import 'package:weatherapp/constants/app_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weatherapp/constants/gaps.dart';
import 'package:weatherapp/statemanagement_layer/settings_state/change_theme_provider.dart';

class OpenUrl {
  static Future<void> openUrl({required String target}) async {
    try {
      final Uri url = Uri.parse(target);
      final bool canLuanch = await launchUrl(url);

      if (!canLuanch) {
        Log.log("Cannot launch the url...", color: LColor.red);
        return;
      }

      await launchUrl(url);
    } catch (error) {
      showToastification(
        title: "Cannot launch this url right now please try agian later",
        type: ToastificationType.error,
      );
      Log.log("Error while launching url");
    }
  }
}

class DevModel {
  final String title;
  final String target;
  final IconData icon;
  final Color? color;

  const DevModel({
    required this.icon,
    required this.target,
    required this.title,
    required this.color,
  });
}

const List<DevModel> devData = [
  DevModel(
    icon: FontAwesomeIcons.github,
    target: "https://github.com/Cisco0xf",
    title: "GitHub",
    color: null,
  ),
  DevModel(
    icon: FontAwesomeIcons.linkedin,
    target: "https://www.linkedin.com/in/mahmoud-al-shehyby/",
    title: "LinkedIn",
    color: Colors.blue,
  ),
  DevModel(
    icon: FontAwesomeIcons.stackOverflow,
    target: "https://stackoverflow.com/users/23598383/mahmoud-al-shehyby",
    title: "StackOverflow",
    color: Colors.amber,
  ),
];

class DevSection extends StatelessWidget {
  const DevSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: <Widget>[
        Divider(),
        ProjectGithub(),
        DevPlatforms(),
      ],
    );
  }
}

class ProjectGithub extends StatelessWidget {
  const ProjectGithub({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: padding(10.0),
      decoration: BoxDecoration(
        color: SwitchColors.mainColor,
        border: Border.all(
          color: SwitchColors.borderColor,
        ),
        borderRadius: borderRadius(10.0),
      ),
      child: Clicker(
        onClick: () async {
          await OpenUrl.openUrl(
            target: "https://github.com/Cisco0xf/SkyTrack-Weather-App.git",
          );
        },
        innerPadding: 10.0,
        child: Row(
          children: <Widget>[
            const Icon(FontAwesomeIcons.github),
            SizedBox(
              height: context.screenHeight * .06,
              child: const VerticalDivider(),
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Source Code",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Asscess the app source code on GitHub",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class DevPlatforms extends StatelessWidget {
  const DevPlatforms({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Text(
          "Developer",
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Gaps(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List<Widget>.generate(
            devData.length,
            (index) {
              return PlatFromCard(model: devData[index]);
            },
          ),
        ),
      ],
    );
  }
}

// assets/animations

class PlatFromCard extends StatelessWidget {
  const PlatFromCard({
    super.key,
    required this.model,
  });

  final DevModel model;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: context.screenHeight * .12,
      child: Container(
        decoration: BoxDecoration(
          color: !context.watch<ChangeThemeProvider>().isThirdTheme
              ? Colors.black45
              : Colors.white54,
          borderRadius: borderRadius(10.0),
          border: Border.all(color: SwitchColors.borderColor),
        ),
        child: Clicker(
          onClick: () async {
            await OpenUrl.openUrl(target: model.target);
          },
          innerPadding: 7.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                model.icon,
                color: model.color,
              ),
              const Gaps(height: 6.0),
              Text(
                model.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
