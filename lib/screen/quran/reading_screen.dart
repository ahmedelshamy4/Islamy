import 'package:flutter/material.dart';
import 'package:quran_app/screen/Quran/readingItem.dart';
import 'package:quran_app/screen/Quran/surahItem.dart';
import 'package:quran_app/helper/cach_helper.dart';

import '../../MainCubit/app_cubit.dart';

class ReadingScreen extends StatefulWidget {
  List<VerssModel> list;
  bool lastSura = false;

  ReadingScreen({Key? key, required this.list, required this.lastSura})
      : super(key: key);

  @override
  State<ReadingScreen> createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> {
  @override
  Widget build(BuildContext context) {
    double suraOffset;

    AppCubit.get(context).currentSurahName =
        cacheHelper.getdata(key: 'suraName');
    AppCubit.get(context).currentSurahNumber =
        cacheHelper.getdata(key: 'suraID');
    widget.lastSura
        ? WidgetsBinding.instance!.addPostFrameCallback(
            (_) => AppCubit.get(context).goToLastAyaIndex())
        : () {
            print('');
          };
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
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
            child: Container(
              height: MediaQuery.of(context).size.height * 0.85,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: AppCubit.get(context).isDark
                    ? const Color.fromARGB(255, 16, 15, 54)
                    : Colors.grey[350],
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.095,
                    child: Center(
                      child: Image.asset(
                        'assets/images/basmala.png',
                        fit: BoxFit.fill,
                        color: AppCubit.get(context).isDark
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 12, left: 12, bottom: 15),
                      child: ListView.builder(
                        controller: AppCubit.get(context).scrollController,
                        physics: const BouncingScrollPhysics(),
                        itemCount: widget.list.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              readingItem(
                                AppCubit.get(context).isDark
                                    ? Colors.white
                                    : Colors.black,
                                widget.list,
                                index,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  FloatingActionButton(
                      child: const Icon(
                        Icons.save,
                        color: Color.fromARGB(255, 134, 48, 177),
                      ),
                      onPressed: () {
                        suraOffset =
                            AppCubit.get(context).scrollController.offset;
                        cacheHelper.saveData(
                            key: 'lastverss', value: suraOffset);
                      })
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
