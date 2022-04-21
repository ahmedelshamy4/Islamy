import 'package:flutter/material.dart';

import '../../MainCubit/app_cubit.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
          child: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Image.asset(
              "assets/images/ic.png",
              fit: BoxFit.fill,
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                'ISLAMY',
                style: TextStyle(
                  color: AppCubit.get(context).isDark
                      ? Colors.white
                      : Colors.black,
                  fontSize: 55,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'myFont',
                ),
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Made by',
              textAlign: TextAlign.end,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 8,
                fontFamily: 'myFont',
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            const Text(
              'Ahmed Elshamy ',
              textAlign: TextAlign.end,
              style: TextStyle(
                color: Colors.grey,
                fontFamily: 'myFont',
                fontSize: 8,
              ),
            )
          ],
        ),
      )),
    );
  }
}
