import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:quran_app/MainCubit/app_cubit_states.dart';
import 'package:quran_app/screen/SalaTimes/salaItem.dart';

import '../../MainCubit/app_cubit.dart';

class SalaTimesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final myCoordinates = Coordinates(
      AppCubit.get(context).prayerTimes.coordinates.latitude,
      AppCubit.get(context).prayerTimes.coordinates.longitude,
    );
    final params = CalculationMethod.egyptian.getParameters();
    params.madhab = Madhab.hanafi;
    final prayerTimes = PrayerTimes.today(myCoordinates, params);
    String nextSala = prayerTimes.nextPrayer().toString();
    String Asr = DateFormat.jm().format(prayerTimes.asr);
    List NextSala = nextSala.split('.');
    List asr = Asr.split(':');
    int asrTime = int.parse(asr[0]);

    return BlocConsumer<AppCubit, AppCubitStates>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.21,
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: const Image(
                          image:
                              AssetImage('assets/images/M-design-rotated.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.21,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.14),
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.015,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Center(
                            child: Text(
                              '${AppCubit.get(context).isArabic ? 'الصلاه القادمة' : "Next pray"} : '
                              '${NextSala[1] == 'none' ? "fajr" : NextSala[1]}',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Theme.of(context).canvasColor,
                                fontFamily: 'myFont',
                                fontSize: 25,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 12,
                    width: double.infinity,
                  ),
                  salaItem(
                    context: context,
                    Enstring: 'Fajr',
                    Tstring: DateFormat.jm().format(prayerTimes.fajr),
                    Arstring: 'الفجر',
                  ),
                  const SizedBox(height: 19),
                  salaItem(
                    context: context,
                    Enstring: 'Sunrise',
                    Tstring: DateFormat.jm().format(prayerTimes.sunrise),
                    Arstring: 'الشروق',
                  ),
                  const SizedBox(height: 19),
                  salaItem(
                    context: context,
                    Enstring: 'Zuhr',
                    Tstring: DateFormat.jm().format(prayerTimes.dhuhr),
                    Arstring: 'الظهر',
                  ),
                  const SizedBox(height: 19),
                  salaItem(
                    context: context,
                    Enstring: 'Asr',
                    Tstring: '${asrTime - 1}:${asr[1]}',
                    Arstring: 'العصر',
                  ),
                  const SizedBox(height: 19),
                  salaItem(
                    context: context,
                    Enstring: 'Maghrib',
                    Tstring: DateFormat.jm().format(prayerTimes.maghrib),
                    Arstring: 'المغرب',
                  ),
                  const SizedBox(height: 19),
                  salaItem(
                    context: context,
                    Enstring: 'Isha',
                    Tstring: DateFormat.jm().format(prayerTimes.isha),
                    Arstring: 'العشاء',
                  ),
                ],
              )
            ],
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
