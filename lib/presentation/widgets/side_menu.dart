import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'language_switcher.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Drawer(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  DrawerHeader(
                    padding: const EdgeInsets.all(32),
                    child: SvgPicture.asset(
                      'res/images/logo.svg',
                    ),
                  ),
                  _buildListTile(
                    titleText: tr('menu_dashboard'),
                    iconData: Icons.dashboard_outlined,
                    onPressed: () {
                      // TODO
                    },
                  ),
                  _buildListTile(
                    titleText: tr('menu_profile'),
                    iconData: Icons.person_outline_rounded,
                    onPressed: () {
                      // TODO
                    },
                  ),
                  _buildListTile(
                    titleText: 'Settings',
                    iconData: Icons.settings,
                    onPressed: () {
                      // TODO
                    },
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8),
              child: LanguageSwitcher(),
            ),
          ],
        ),
      );

  Widget _buildListTile({
    required String titleText,
    required IconData iconData,
    required VoidCallback onPressed,
  }) =>
      ListTile(
        onTap: onPressed,
        horizontalTitleGap: 0.0,
        leading: Icon(
          iconData,
          color: Colors.white54,
          size: 22,
        ),
        title: Text(
          titleText,
          style: const TextStyle(color: Colors.white54),
        ),
      );
}
