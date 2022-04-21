import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/MainCubit/app_cubit_states.dart';
import 'package:quran_app/helper/cach_helper.dart';
import 'package:quran_app/screen/Home/home_screen.dart';
import 'package:quran_app/screen/OnBording/onBording_screen.dart';
import 'package:quran_app/screen/splash/splash.dart';
import 'MainCubit/app_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await cacheHelper.init();

  String suraName = cacheHelper.getdata(key: 'suraName');
  int suraID = cacheHelper.getdata(key: 'suraID');

  bool onBoarding = cacheHelper.getdata(key: 'OnBoarding');
  bool isDark = cacheHelper.getdata(key: 'isDark');
  bool isarbic = cacheHelper.getdata(key: 'ISARBICK');
  runApp(MyApp(suraName, suraID, isDark, isarbic, onBoarding));
}

class MyApp extends StatelessWidget {
  final String suraName;
  final int suraID;
  final bool isDark;
  final bool isarabic;
  final bool onBoarding;
  MyApp(
    this.suraName,
    this.suraID,
    this.isDark,
    this.isarabic,
    this.onBoarding,
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()
        ..c()
        ..ChangeLocale(isarabic)
        ..changeTheme(isDark),
      child: BlocConsumer<AppCubit, AppCubitStates>(
        builder: (context, state) {
          AppCubit.get(context).currentSurahName = suraName;
          AppCubit.get(context).currentSurahNumber = suraID;
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
          ]);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: AppCubit.get(context).IsArabic
                ? Locale('ar', '')
                : Locale('en', ''),
            theme: ThemeData(
                primaryColor: Colors.black,
                canvasColor: Colors.black,
                scaffoldBackgroundColor: Colors.white,
                colorScheme:
                    ColorScheme.fromSwatch().copyWith(secondary: Colors.white)),
            darkTheme: ThemeData(
                primaryColor: const Color.fromARGB(255, 134, 48, 177),
                canvasColor: Colors.white,
                colorScheme: ColorScheme.fromSwatch().copyWith(
                    secondary: const Color.fromARGB(255, 22, 31, 87))),
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: AnimatedSplashScreen(
              duration: 5000,
              splashTransition: SplashTransition.fadeTransition,
              nextScreen:
                  onBoarding != true ? const OnBording() : const HomeScreen(),
              splash: const SplashScreen(),
              splashIconSize: 2000,
              backgroundColor: AppCubit.get(context).isDark
                  ? const Color.fromARGB(255, 23, 21, 81)
                  : Colors.white,
            ),
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
