import 'package:flutter/material.dart';
import 'package:quran/quran.dart' as quran;
import 'package:quran_app/MainCubit/app_cubit.dart';

class verssModel {
  String verss;
  int versCount;
  verssModel(this.verss, this.versCount);
}

Widget surahItem(context, index) {
  List<verssModel> list = [];
  int surahnum = index + 1;
  return InkWell(
    onTap: () {
      for (int i = 1; i < quran.getVerseCount(surahnum) + 1; i++) {
        String verss = quran.getVerse(surahnum, 1);
        verssModel v = verssModel(verss, 1);
        list.add(v);
      }
      AppCubit.get(context).currentSurahNumber = surahnum;
      AppCubit.get(context).currentSurahName =
          quran.getSurahNameArabic(surahnum);
      AppCubit.get(context).saveDataCache(
          context, AppCubit.get(context).currentSurahName, "suraName");
      AppCubit.get(context)
          .saveInt(context, AppCubit.get(context).currentSurahNumber, "suraID");
    },
    child: SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.125,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                ImageIcon(
                  AssetImage('assets/images/star.png'),
                  color: Theme.of(context).primaryColor,
                  size: 40,
                ),
                Text(
                  '${index + 1}',
                  style: TextStyle(
                    fontFamily: 'myFont',
                    fontWeight: FontWeight.w900,
                    color: Theme.of(context).canvasColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.47,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                  child: Text(
                    AppCubit.get(context).IsArabic
                        ? quran.getSurahNameArabic(surahnum) == 'اللهب'
                            ? 'المسد'
                            : quran.getSurahNameArabic(surahnum)
                        : quran.getSurahName(surahnum).toUpperCase(),
                    style: TextStyle(
                        fontFamily: 'myFont',
                        fontSize: AppCubit.get(context).IsArabic ? 16 : 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).canvasColor),
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  '${quran.getPlaceOfRevelation(surahnum).toUpperCase()} ● ${quran.getVerseCount(surahnum)} VERSES',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: AppCubit.get(context).isDark
                          ? Colors.white30
                          : Colors.black),
                ),
              ],
            ),
          ),
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              child: Text(
                AppCubit.get(context).IsArabic
                    ? quran.getSurahName(surahnum).toUpperCase()
                    : quran.getSurahNameArabic(surahnum) == 'اللهب'
                        ? 'المسد'
                        : quran.getSurahNameArabic(surahnum),
                style: TextStyle(
                    fontFamily: 'myFont',
                    fontSize: AppCubit.get(context).IsArabic ? 13 : 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor),
                textAlign: AppCubit.get(context).IsArabic
                    ? TextAlign.left
                    : TextAlign.right,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget JuzaItem(context, index) {
  List<verssModel> list = [];
  int surahnum = index + 1;
  return InkWell(
    onTap: () {},
  );
}
