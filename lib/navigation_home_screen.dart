import 'package:flutter/material.dart';
import 'package:my_ui_designs/app_theme.dart';
import 'package:my_ui_designs/custom_drawer/drawer_user_controller.dart';
import 'package:my_ui_designs/custom_drawer/home_drawer.dart';
import 'package:my_ui_designs/home_screen.dart';

class NavigationHomeScreen extends StatefulWidget {
  @override
  _NavigationHomeScreenState createState() => _NavigationHomeScreenState();
}

class _NavigationHomeScreenState extends State<NavigationHomeScreen> {

  Widget screenView;
  DrawerIndex drawerIndex;

  @override
  void initState() {
    drawerIndex = DrawerIndex.HOME;
    screenView =  MyHomePage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: DrawerUserController(
            screenIndex: drawerIndex,
            drawerWidth: MediaQuery.of(context).size.width * 0.75,
            onDrawerCall: (DrawerIndex drawerIndexdata){
              changeIndex(drawerIndexdata);
            },
            screenView: screenView,
          )
        ),
      ),
    );
  }


  void changeIndex(DrawerIndex drawerIndexData){
    if(drawerIndex == drawerIndexData){
      drawerIndex = drawerIndexData;
      if(drawerIndex == DrawerIndex.HOME){
          setState(() {
            screenView = const MyHomePage();
          });
      }
    }
  }
}
