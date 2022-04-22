import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/MainCubit/bottom_navBar_states.dart';

import '../screen/Qibla/qibla_screen.dart';
import '../screen/Quran/quran_screen.dart';
import '../screen/Sala/sala_time_screen.dart';
import '../screen/sebha/sebha_screen.dart';

class bottomNavBarCubit extends Cubit<bottomNavBarStates> {
  bottomNavBarCubit() : super(bottomNavBarInitial());

  static bottomNavBarCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> screens = [
    QuranScreen(),
    SalaTimesScreen(),
    QiblaScreen(),
    SebhaScreen(),
  ];
  void checkIndex(int i) {
    currentIndex = i;
    emit(AppChangeBottomNavBarState());
  }
}
