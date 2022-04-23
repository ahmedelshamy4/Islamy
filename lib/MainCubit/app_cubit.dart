import 'package:adhan/adhan.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/MainCubit/app_cubit_states.dart';
import 'package:quran_app/helper/cach_helper.dart';

class AppCubit extends Cubit<AppCubitStates> {
  AppCubit() : super(ThemeInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = false;
  void changeTheme(bool? fromCache) {
    if (fromCache != null) {
      emit(AppChangeThemeState());
    }
    isDark = !isDark;
    cacheHelper
        .saveData(key: 'isDark', value: isDark)
        .then((value) => {emit(AppChangeThemeState())});
  }

  final scrollController = ScrollController();
  goToLastAyaIndex() {
    double offset = cacheHelper.getdata(key: 'lastverss');
    scrollController.animateTo(offset,
        duration: const Duration(seconds: 1), curve: Curves.ease);
  }

  bool isArabic = false;
  void changeLocale(bool? fromCache) {
    if (fromCache != null) {
      emit(ChangeL10n());
      isArabic = fromCache;
    }
    isArabic = !isArabic;
    emit(ChangeL10n());
    cacheHelper
        .saveData(key: 'ISARBICK', value: isArabic)
        .then((value) => {emit(ChangeL10n())});
  }

  bool juzaPattern = false;
  void changeListPattern() {
    juzaPattern = !juzaPattern;
    emit(AppChangeListPattern());
  }

  int currentSurahNumber = 1;
  String currentSurahName = '';

  var currentAngle = 0.0;
  double taspeh = 0.0;
  String taspehWord = 'سبحان الله';
  int duration = 0;

  void saveDataCache(context, String value, String key) {
    cacheHelper.saveData(key: key, value: value);
    emit(saveDataState());
  }

  void saveInt(context, int value, String key) {
    cacheHelper.saveData(key: key, value: value);
    emit(saveDataState());
  }

  var locationLAT = 30.21035;
  var locationLON = 31.36812;

  // void getLocationLat() async {
  //   var x = await Geolocator.getCurrentPosition(
  //     desiredAccuracy: LocationAccuracy.best,);
  //   var lastPosition = await Geolocator.getLastKnownPosition();
  //   locationLAT =x.altitude;
  //   locationLON = x.longitude;
  // }
  late PrayerTimes prayerTimes;
  void c() {
    final myCoordinates = Coordinates(locationLAT, locationLON);
    final params = CalculationMethod.egyptian.getParameters();
    params.madhab = Madhab.hanafi;
    prayerTimes = PrayerTimes.today(myCoordinates, params);
  }
}
