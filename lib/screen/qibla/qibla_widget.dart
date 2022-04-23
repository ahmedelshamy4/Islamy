import 'dart:math' show pi;

import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../MainCubit/app_cubit.dart';

class QiblaWidget extends StatelessWidget {
  const QiblaWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   // var _platformBrightness = Theme.of(context).brightness;
    return StreamBuilder(
        stream: FlutterQiblah.qiblahStream,
        builder: (context, AsyncSnapshot<QiblahDirection> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(
              color: Colors.white,
            );
          }
          final qiblahDirection = snapshot.data;
          var _angle = ((qiblahDirection!.qiblah) * (pi / 180) * -1);

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.45,
                width: double.infinity,
                child: Center(
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      Transform.rotate(
                        angle: _angle,
                        child:
                            SvgPicture.asset('assets/images/5.svg', // compass
                                color: Theme.of(context).primaryColor),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: SvgPicture.asset('assets/images/3.svg',
                            fit: BoxFit.cover, //needle
                            color: Theme.of(context).primaryColor),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.5,
                          child: SvgPicture.asset(
                            'assets/images/4.svg',
                            fit: BoxFit.cover, //needle
                          )),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Text(
                AppLocalizations.of(context)!.qiblaBottomText,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Theme.of(context).canvasColor,
                    fontSize: AppCubit.get(context).isArabic ? 17 : 16,
                    fontFamily: 'myFont'),
              ),
            ],
          );
        });
  }
}
