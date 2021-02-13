import 'package:flutter/material.dart';
import 'package:my_ui_designs/course_design/course_home_screen.dart';
import 'package:my_ui_designs/fitness/fitness_home_screen.dart';
import 'package:my_ui_designs/hotel_booking/hotel_screen.dart';

class HomeList{


    HomeList({this.navigationScreen, this.imagePath});
    Widget navigationScreen;
    String imagePath;

    static List<HomeList> homeList =[
      HomeList(
          imagePath: 'assets/hotel/hotel_booking.png',
          navigationScreen: HotelHomeScreen()
      ),

      HomeList(
        imagePath: 'assets/fitness_app/fitness_app.png',
        navigationScreen: FitnessHomeScreen()
      ),
      HomeList(
        imagePath: 'assets/design_course/webInterFace.png',
        navigationScreen: CourseDesignHomeScreen()
      )
    ];
}