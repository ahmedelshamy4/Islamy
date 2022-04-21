import 'package:flutter/material.dart';
import 'package:quran_app/helper/cach_helper.dart';
import 'package:quran_app/screen/Quran/readingItem.dart';
import 'package:quran_app/screen/Quran/surahItem.dart';

import '../../MainCubit/app_cubit.dart';

class ReadingScreenNoBasmala extends StatelessWidget {
  List<verssModel> list;
  bool lastSura = false;
  ReadingScreenNoBasmala({Key? key, required this.list, required this.lastSura})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit.get(context).currentSurahName =
        cacheHelper.getdata(key: 'suraName');
    AppCubit.get(context).currentSurahNumber =
        cacheHelper.getdata(key: 'suraID');
    lastSura
        ? WidgetsBinding.instance!.addPostFrameCallback(
            (_) => AppCubit.get(context).GoToLastAyaIndex())
        : () {};
    return Scaffold(
      body: Stack(alignment: Alignment.center, children: [
        Image(
          image: AppCubit.get(context).isDark
              ? const AssetImage('assets/images/backgroundupperdraw.png')
              : const AssetImage('assets/images/light.jpg'),
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.fill,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12, right: 12, top: 25),
          child: Center(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.85,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: AppCubit.get(context).isDark
                    ? const Color.fromARGB(255, 16, 15, 54)
                    : Colors.grey[350],
              ),
              child: Column(children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Expanded(
                  child: buildReadingScreen(context, list),
                ),
              ]),
            ),
          ),
        )
      ]),
    );
  }
}

Widget buildReadingScreen(context, List<verssModel> list) {
  return Padding(
    padding: const EdgeInsets.only(right: 12, left: 12, bottom: 15),
    child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Column(
            children: [
              readingItem(
                  AppCubit.get(context).isDark ? Colors.white : Colors.black,
                  list,
                  index),
            ],
          );
        },
        itemCount: list.length),
  );
}
