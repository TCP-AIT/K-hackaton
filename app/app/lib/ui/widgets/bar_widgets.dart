import 'package:flutter/material.dart';

import 'package:ice_d/theme.dart';

class TopBar extends StatefulWidget implements PreferredSizeWidget{
  const TopBar({super.key});

  @override
  State<TopBar> createState() => TopBarState();

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}

class TopBarState extends State<TopBar> {

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      foregroundColor: AppColors.accentColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const TextBlack(string: 'ICE-D', size: 32),
          IconButton(
              onPressed: (){print('ok');},
              icon: Image.asset(AppIcons.safeDrivingOff,)
          )
        ],
      ),
    );
  }
}

class BottomBar extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomBar({super.key, required this.currentIndex, required this.onTap});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: BottomNavigationBar(
        currentIndex: widget.currentIndex,
        onTap: widget.onTap,
        backgroundColor: AppColors.white,
        unselectedItemColor: AppColors.black,
        selectedItemColor: AppColors.mainColor,
        unselectedFontSize: 12,
        selectedFontSize: 12,
        items: [
          BottomNavigationBarItem(
              icon: Image.asset(AppIcons.alcoholTimerPageOff),
              activeIcon: Image.asset(AppIcons.alcoholTimerPageOn),
              label: '알코올 타이머'
          ),
          BottomNavigationBarItem(
              icon: Image.asset(AppIcons.navigationPageOff),
              activeIcon: Image.asset(AppIcons.navigationPageOn),
              label: '내비게이션'
          ),
          BottomNavigationBarItem(
              icon: Image.asset(AppIcons.settingPageOff),
              activeIcon: Image.asset(AppIcons.settingPageOn),
              label: '설정'
          )
        ],
      ),
    );
  }
}