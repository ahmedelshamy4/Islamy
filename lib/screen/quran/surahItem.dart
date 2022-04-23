import 'package:flutter/material.dart';
import 'package:quran/quran.dart' as quran;
import 'package:quran_app/MainCubit/app_cubit.dart';
import 'package:quran_app/screen/Quran/reading_screen.dart';
import 'package:quran_app/screen/Quran/reading_screen_basmala.dart';

class VerssModel {
  String verss;
  int versCount;
  VerssModel(this.verss, this.versCount);
}

Widget surahItem(context, index) {
  List<VerssModel> list = [];
  int surahnum = index + 1;
  return InkWell(
    onTap: () {
      for (int i = 1; i < quran.getVerseCount(surahnum) + 1; i++) {
        String verss = quran.getVerse(surahnum, i);
        VerssModel v = VerssModel(verss, i);
        list.add(v);
      }
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => surahnum == 9 || surahnum == 1
                ? ReadingScreenNoBasmala(list: list, lastSura: false)
                : ReadingScreen(
                    list: list,
                    lastSura: false,
                  )),
      );
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
                  const AssetImage('assets/images/star.png'),
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
                    AppCubit.get(context).isArabic
                        ? quran.getSurahNameArabic(surahnum) == 'اللهب'
                            ? 'المسد'
                            : quran.getSurahNameArabic(surahnum)
                        : quran.getSurahName(surahnum).toUpperCase(),
                    style: TextStyle(
                        fontFamily: 'myFont',
                        fontSize: AppCubit.get(context).isArabic ? 16 : 18,
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
                AppCubit.get(context).isArabic
                    ? quran.getSurahName(surahnum).toUpperCase()
                    : quran.getSurahNameArabic(surahnum) == 'اللهب'
                        ? 'المسد'
                        : quran.getSurahNameArabic(surahnum),
                style: TextStyle(
                    fontFamily: 'myFont',
                    fontSize: AppCubit.get(context).isArabic ? 13 : 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor),
                textAlign: AppCubit.get(context).isArabic
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

Widget JuzItem(context, index) {
  List<VerssModel> list = [];
  int juzNum = index + 1;
  return InkWell(
    onTap: () {
      for (int i = 1; i < quran.getVerseCount(juzNum) + 1; i++) {
        String verss = quran.getVerse(juzNum, i);
        VerssModel v = VerssModel(verss, i);
        list.add(v);
      }
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => juzNum == 9 || juzNum == 1
                  ? ReadingScreenNoBasmala(
                      list: list,
                      lastSura: false,
                    )
                  : ReadingScreen(
                      list: list,
                      lastSura: false,
                    )));
      AppCubit.get(context).currentSurahNumber = juzNum;
      AppCubit.get(context).currentSurahName = quran.getSurahNameArabic(juzNum);

      AppCubit.get(context).saveDataCache(
          context, AppCubit.get(context).currentSurahName, 'suraName');
      AppCubit.get(context)
          .saveInt(context, AppCubit.get(context).currentSurahNumber, 'suraID');
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
                  const AssetImage('assets/images/star.png'),
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
                    'الجزء ${juza[index]}',
                    style: TextStyle(
                      fontFamily: 'myFont',
                      fontSize: AppCubit.get(context).isArabic ? 13 : 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                    textAlign: AppCubit.get(context).isArabic
                        ? TextAlign.left
                        : TextAlign.right,
                  ),
                ),
                const SizedBox(height: 3),
              ],
            ),
          ),
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              child: Text(
                'الجزء ${juza[index]}',
                style: TextStyle(
                    fontFamily: 'myFont',
                    fontSize: AppCubit.get(context).isArabic ? 13 : 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor),
                textAlign: AppCubit.get(context).isArabic
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

List juza = [
  ' الاول',
  ' الثاني ',
  'الثالث ',
  'الرابع  ',
  'الخامس ',
  'السادس',
  'السابع ',
  'الثامن ',
  'التاسع ',
  'العاشر ',
  'الحادي عشر ',
  'الاثن عشر ',
  'الثالث عشر',
  'الرابع عشر ',
  'الخامس عشر ',
  'السادس عشر ',
  'السابع عشر ',
  'الثامن عشر ',
  'التاسع عشر ',
  'العشرون',
  'الواحد و اعلشرون ',
  'الثاني و العشرون ',
  'الثالث و العشرون ',
  'الرابع و العشرون ',
  'الخامس و العشرون ',
  'السادس و العشرون ',
  'السابع و العسرون ',
  'الثامن و العشرون ',
  'التاسع و العشرون ',
  'الثلاين'
];
