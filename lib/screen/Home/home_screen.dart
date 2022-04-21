import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:adhan/adhan.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/MainCubit/app_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:quran_app/MainCubit/bottom_navBar_cubit.dart';

import '../../MainCubit/bottom_navBar_states.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final myCoordinates = Coordinates(30.033333, 31.233334);
    final params = CalculationMethod.egyptian.getParameters();
    params.madhab = Madhab.hanafi;
    final prayerTimes = PrayerTimes.today(myCoordinates, params);
    List<String> titles = [
      AppCubit.get(context).IsArabic ? 'القرآن  الكريم' : 'Quran',
      AppLocalizations.of(context)!.sala,
      AppLocalizations.of(context)!.qbla,
      AppLocalizations.of(context)!.sebha,
    ];
    return BlocProvider(
      create: (BuildContext context) => bottomNavBarCubit(),
      child: BlocConsumer<bottomNavBarCubit, bottomNavBarStates>(
          builder: (context, index) {
            return Stack(
              alignment: Alignment.topCenter,
              children: [
                Image(
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.fill,
                  image: AppCubit.get(context).isDark
                      ? const AssetImage(
                          'assets/images/backgroundupperdraw.png')
                      : const AssetImage(''),
                ),
                Scaffold(
                  floatingActionButton: FloatingActionButton(
                    onPressed: AppCubit.get(context).changeListPattern,
                    child: Icon(Icons.wifi_protected_setup_outlined),
                  ),
                  backgroundColor: AppCubit.get(context).isDark
                      ? Colors.transparent
                      : Colors.white,
                  appBar: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    centerTitle: true,
                    leading: IconButton(
                      onPressed: () {
                        showCupertinoDialog(
                          context: context,
                          builder: LanguageDialog,
                        );
                      },
                      icon: Icon(
                        Icons.language,
                        color: AppCubit.get(context).isDark
                            ? Colors.white
                            : Colors.black,
                        size: 24,
                      ),
                    ),
                    actions: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            AppCubit.get(context).changeTheme(null);
                          });
                          print(AppCubit.get(context).isDark);
                        },
                        icon: ImageIcon(
                          AssetImage('assets/images/paintbrush.png'),
                          color: AppCubit.get(context).isDark
                              ? Colors.white
                              : Colors.black,
                          size: 21,
                        ),
                      )
                    ],
                    title: Text(
                      titles[bottomNavBarCubit.get(context).currentIndex],
                      style: TextStyle(
                          color: AppCubit.get(context).isDark
                              ? Colors.white
                              : Colors.black,
                          fontSize: 25,
                          fontFamily: 'myFont',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  body: bottomNavBarCubit
                      .get(context)
                      .screens[bottomNavBarCubit.get(context).currentIndex],
                  bottomNavigationBar: BottomNavigationBar(
                    currentIndex: bottomNavBarCubit.get(context).currentIndex,
                    onTap: (i){
                      bottomNavBarCubit.get(context).checkIndex(i);
                    },
                    type: BottomNavigationBarType.fixed,
                    backgroundColor: AppCubit.get(context).isDark?
                    const Color.fromARGB(255, 22, 31, 87):Colors.white,
                    unselectedIconTheme: IconThemeData(color:
                    AppCubit.get(context).isDark?
                    Colors.white:Colors.black),
                    selectedIconTheme: const IconThemeData(color: Colors.purple),
                    iconSize: 500,
                    items: [
                      BottomNavigationBarItem(
                        icon: SizedBox(
                          width: MediaQuery.of(context).size.width / 4,
                          height: MediaQuery.of(context).size.height * 0.04,
                          child: const Center(
                            child: ImageIcon(
                              AssetImage('assets/images/koran.png'),
                              size: 26,
                            ),
                          ),
                        ),
                        label: "",
                      ),
                      BottomNavigationBarItem(
                        icon: SizedBox(
                          width: MediaQuery.of(context).size.width / 4,
                          height: MediaQuery.of(context).size.height * 0.04,
                          child: const Center(
                            child: ImageIcon(
                              AssetImage('assets/images/mosque.png'),
                              size: 30,
                            ),
                          ),
                        ),
                        label: "",
                      ),
                      BottomNavigationBarItem(
                        icon: SizedBox(
                          width: MediaQuery.of(context).size.width / 4,
                          height: MediaQuery.of(context).size.height * 0.043,
                          child: const Center(
                            child: ImageIcon(
                              AssetImage('assets/images/compass.png'),
                            ),
                          ),
                        ),
                        label: "",
                      ),
                      BottomNavigationBarItem(
                        icon: SizedBox(
                          width: MediaQuery.of(context).size.width / 4,
                          height: MediaQuery.of(context).size.height * 0.04,
                          child: const Center(
                            child: ImageIcon(
                              AssetImage('assets/images/beads.png'),
                            ),
                          ),
                        ),
                        label: "",
                      ),
                    ],
                  ),
                )
              ],
            );
          },
          listener: (context, index) {}),
    );
  }

  Widget LanguageDialog(BuildContext context) => CupertinoAlertDialog(
        title: Text(
          AppCubit.get(context).IsArabic
              ? "اللغة ستتغير للإنجليزية !"
              : "The language will change to Arabic !",
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          CupertinoDialogAction(
            child: Text(AppCubit.get(context).IsArabic ? "لا" : "no"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CupertinoDialogAction(
            child: Text(AppCubit.get(context).IsArabic ? "أجل" : "yes"),
            onPressed: () {
              AppCubit.get(context).ChangeLocale(null);
              Navigator.pop(context);
            },
          )
        ],
      );
}
