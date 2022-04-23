import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/quran.dart' as quran;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:quran_app/MainCubit/app_cubit.dart';
import 'package:quran_app/screen/Quran/reading_screen.dart';
import 'package:quran_app/screen/Quran/reading_screen_basmala.dart';
import 'package:quran_app/screen/Quran/surahItem.dart';
import '../../MainCubit/app_cubit_states.dart';

class QuranScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppCubitStates>(
      builder: (context, state) {
        return Column(
          children: [
            InkWell(
              onTap: () {
                List<VerssModel> list = [];
                for (int i = 1;
                    i <
                        quran.getVerseCount(
                                AppCubit.get(context).currentSurahNumber) +
                            1;
                    i++) {
                  VerssModel v = VerssModel(
                      quran.getVerse(
                          AppCubit.get(context).currentSurahNumber, i),
                      i);
                  list.add(v);
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AppCubit.get(context).currentSurahNumber == 9 ||
                                AppCubit.get(context).currentSurahNumber == 1
                            ? ReadingScreenNoBasmala(
                                list: list,
                                lastSura: true,
                              )
                            : ReadingScreen(list: list, lastSura: true),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.27,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.transparent, //color of border
                        //width of border
                      ),
                      borderRadius: BorderRadius.circular(5)),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image(
                          image: AssetImage(
                            AppCubit.get(context).isArabic
                                ? 'assets/images/lastread_flipped.png'
                                : 'assets/images/lastread.png',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.001,
                            ),
                            Row(
                              children: [
                                const ImageIcon(
                                  AssetImage(
                                    'assets/images/bookmark.png',
                                  ),
                                  color: Colors.white,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 3.0),
                                  child: Text(
                                    AppLocalizations.of(context)!.lastRead,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'myFont',
                                        fontWeight:
                                            AppCubit.get(context).isArabic
                                                ? FontWeight.w800
                                                : FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: AppCubit.get(context).isArabic
                                  ? MediaQuery.of(context).size.height * 0.01
                                  : MediaQuery.of(context).size.height * 0.01,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 6.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(getLastRead(context).toUpperCase(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 18,
                                      )),
                                  Text(
                                    '${AppLocalizations.of(context)!.surahno} : ${AppCubit.get(context).currentSurahNumber == null ? '1' : AppCubit.get(context).currentSurahNumber}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: AppCubit.get(context).isArabic
                                          ? 'myFont'
                                          : '',
                                      fontSize: AppCubit.get(context).isArabic
                                          ? 16
                                          : 15,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            buildQuranScreen(context, AppCubit.get(context).juzaPattern)
          ],
        );
      },
      listener: (context, state) {},
    );
  }

  Widget buildQuranScreen(context, juzPattern) {
    if (juzPattern == true) {
      return Expanded(
          child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemCount: quran.totalJuzCount,
        itemBuilder: (context, index) {
          return JuzItem(context, index);
        },
        separatorBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Container(
              height: 1,
              color: const Color.fromARGB(255, 87, 89, 116),
            ),
          );
        },
      ));
    } else {
      return Expanded(
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemCount: quran.totalSurahCount,
          itemBuilder: (context, index) {
            return surahItem(context, index);
          },
          separatorBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Container(
                height: 1,
                color: const Color.fromARGB(255, 87, 89, 116),
              ),
            );
          },
        ),
      );
    }
  }
}

String getLastRead(context) {
  if (AppCubit.get(context).currentSurahName == null) {
    return 'الفاتحة';
  } else {
    return AppCubit.get(context).currentSurahName == 'اللهب'
        ? 'المسد'
        : AppCubit.get(context).currentSurahName;
  }
}
