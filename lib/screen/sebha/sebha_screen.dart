import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../MainCubit/app_cubit.dart';

class SebhaScreen extends StatefulWidget {
  @override
  State<SebhaScreen> createState() => _SebhaScreenState();
}

class _SebhaScreenState extends State<SebhaScreen> {
  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
                child: Transform.rotate(
                  angle: AppCubit.get(context).currentAngle,
                  child: Image.asset(
                    'assets/images/sebha.png',
                    fit: BoxFit.cover,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.075,
                child: Center(
                  child: InkWell(
                    onTap: () {
                      if (cubit.duration == 0) {
                        setState(() {
                          cubit.taspeh = 0.0;
                          cubit.taspehWord = 'الحمد لله ';
                          cubit.duration++;
                        });
                      } else if (cubit.duration == 1) {
                        setState(() {
                          cubit.taspeh = 0.0;
                          cubit.taspehWord = ' الله اكبر';
                          cubit.duration++;
                        });
                      } else if (cubit.duration == 2) {
                        setState(() {
                          cubit.taspeh = 0.0;
                          cubit.taspehWord = 'لا اله الا الله';
                          cubit.duration++;
                        });
                      } else if (cubit.duration == 3) {
                        setState(() {
                          cubit.taspeh = 0.0;
                          cubit.taspehWord = 'سبحان الله';
                          cubit.duration = 0;
                        });
                      }
                    },
                    child: Text(
                      AppCubit.get(context).taspehWord.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Theme.of(context).canvasColor,
                          fontSize: AppCubit.get(context).isArabic ? 30 : 20,
                          fontFamily: 'myFont',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.040,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.60,
            height: MediaQuery.of(context).size.height * 0.075,
            child: Slider(
              min: 0.0,
              max: 33.0,
              value: AppCubit.get(context).taspeh,
              activeColor: Colors.purple,
              onChanged: null,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.025,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.25,
            height: MediaQuery.of(context).size.height * 0.055,
            child: ElevatedButton(
                onPressed: () {
                  reset();
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  primary: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  '${AppCubit.get(context).taspeh.toInt()}',
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      letterSpacing: 2,
                      fontSize: 15,
                      fontFamily: 'myFont'),
                )),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.045,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.75,
            height: MediaQuery.of(context).size.height * 0.075,
            child: ElevatedButton(
                onPressed: () {
                  onTasbeh();
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  primary: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  AppLocalizations.of(context)!.click,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    letterSpacing: 5,
                    fontSize: AppCubit.get(context).isArabic ? 25 : 20,
                    fontFamily: 'myFont',
                  ),
                )),
          ),
        ],
      ),
    );
  }

  void onTasbeh() {
    setState(() {
      AppCubit.get(context).taspeh++;
      AppCubit.get(context).currentAngle += 33;

      if (AppCubit.get(context).taspeh == 33 &&
          AppCubit.get(context).duration == 0) {
        setState(() {
          AppCubit.get(context).taspeh = 0.0;
          AppCubit.get(context).taspehWord = 'الحمد لله';
          AppCubit.get(context).duration++;
        });
      }
      if (AppCubit.get(context).taspeh == 33 &&
          AppCubit.get(context).duration == 1) {
        setState(() {
          AppCubit.get(context).taspeh = 0.0;
          AppCubit.get(context).taspehWord = 'لا إله إلا الله';
          AppCubit.get(context).duration++;
        });
      }
      if (AppCubit.get(context).taspeh == 33 &&
          AppCubit.get(context).duration == 2) {
        setState(() {
          AppCubit.get(context).taspeh = 0.0;
          AppCubit.get(context).taspehWord = 'الله أكبر';
          AppCubit.get(context).duration++;
        });
      }
      if (AppCubit.get(context).taspeh == 33 &&
          AppCubit.get(context).duration == 3) {
        setState(() {
          AppCubit.get(context).taspeh = 0.0;
          AppCubit.get(context).taspehWord = 'سبحان الله';
          AppCubit.get(context).duration = 0;
        });
      }
    });
  }

  void reset() {
    setState(() {
      AppCubit.get(context).taspeh = 0;
      AppCubit.get(context).taspehWord =
          AppLocalizations.of(context)!.subhanallah.toUpperCase();
      AppCubit.get(context).currentAngle = 0;
      AppCubit.get(context).duration = 0;
    });
  }
}
