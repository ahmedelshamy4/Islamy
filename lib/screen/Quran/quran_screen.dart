import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/quran.dart' as quran;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:quran_app/MainCubit/app_cubit.dart';
import 'package:quran_app/screen/Quran/surahItem.dart';

import '../../MainCubit/app_cubit_states.dart';

class QuranScreen extends StatelessWidget {
  const QuranScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppCubitStates>(
      builder: (context, state) {
        return Column(children: [
          InkWell(
            onTap: () {
              List<verssModel> list = [];
              for (int i = 1;
                  i <
                      quran.getVerseCount(
                              AppCubit.get(context).currentSurahNumber) +
                          1;
                  i++) {
                verssModel v = verssModel(
                    quran.getVerse(AppCubit.get(context).currentSurahNumber, i),
                    i);
                list.add(v);
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(
                left: 12.0,
                right: 12,
              ),
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
                          AppCubit.get(context).IsArabic
                              ? 'assets/images/lastread_flipped.png'
                              : 'assets/images/lastread.png',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          buildQuranScreen(context, AppCubit.get(context).juzaPattern)
        ]);
      },
      listener: (context, state) {},
    );
  }

  Widget buildQuranScreen(context, juzaPattern) {
    if (juzaPattern == true) {
      return Expanded(
          child: ListView.separated(
              itemBuilder: (context, index) {
                return JuzaItem(context, index);
              },
              separatorBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Container(
                    height: 1,
                    color: Color.fromARGB(255, 87, 89, 116),
                  ),
                );
              },
              itemCount: quran.totalJuzCount));
    } else {
      return Expanded(
        child: ListView.separated(
            physics: const BouncingScrollPhysics(),
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
            itemCount: quran.totalSurahCount),
      );
    }
  }
}
