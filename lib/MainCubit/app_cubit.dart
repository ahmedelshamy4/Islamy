import 'package:adhan/adhan.dart';
import 'package:flutter/animation.dart';
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

  bool IsArabic = false;
  void ChangeLocale(bool? fromCache) {
    if (fromCache != null) {
      emit(ChangeL10n());
      IsArabic = fromCache;
    }
    IsArabic = !IsArabic;
    emit(ChangeL10n());
    cacheHelper
        .saveData(key: 'ISARBICK', value: IsArabic)
        .then((value) => {emit(ChangeL10n())});
  }

  bool juzaPattern = false;
  void changeListPattern() {
    juzaPattern = !juzaPattern;
    emit(AppChangeListPattern());
  }

  int currentSurahNumber = 1;
  String currentSurahName = '';

  void saveDataCache(context, String value, String key) {
    cacheHelper.saveData(key: key, value: value);
    emit(saveDataState());
  }

  void saveInt(context, int value, String key) {
    cacheHelper.saveData(key: key, value: value);
    emit(saveDataState());
  }

  late PrayerTimes rayerTimes;
  void c() {
    final myCoordinates = Coordinates(30.033333, 31.233334);
    final params = CalculationMethod.egyptian.getParameters();
    params.madhab = Madhab.hanafi;
    final prayerTimes = PrayerTimes.today(myCoordinates, params);
    rayerTimes = PrayerTimes.today(myCoordinates, params);
  }
}
