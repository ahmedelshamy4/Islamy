import 'package:flutter/material.dart';
import 'package:quran_app/helper/cach_helper.dart';
import 'package:quran_app/screen/Home/home_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BoardingModel {
  final String image, title, body;

  BoardingModel({
    required this.body,
    required this.image,
    required this.title,
  });
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var pageController = PageController();

  List<BoardingModel> model = [
    BoardingModel(
      image: 'assets/images/icon.png',
      title: "القرآن",
      body: "استمتع بجميع سور القرآن الكريم كاملة",
    ),
    BoardingModel(
      image: 'assets/images/iconm.png',
      title: "مواعيد الصلاة",
      body: "تحديد مواعيد الصلاة في مدينتك",
    ),
    BoardingModel(
      image: 'assets/images/icons.png',
      title: "القبلة",
      body: "قم بتحديد القبلة و اقم صلاتك في اي مكان",
    ),
  ];
  bool isLast = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 23, 21, 81),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: const Color.fromARGB(255, 23, 21, 81),
        actions: [
          TextButton(
              onPressed: () {
                submit();
              },
              child: const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  "تخطي",
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'myFont',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (index) {
                  if (index == model.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                controller: pageController,
                itemCount: 3,
                physics: const PageScrollPhysics(),
                itemBuilder: (context, i) => _buildBoardingItem(model[i]),
              ),
            ),
            const SizedBox(height: 40),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: pageController,
                  count: model.length,
                  effect: const ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    dotHeight: 10,
                    dotWidth: 10,
                    spacing: 5.0,
                    expansionFactor: 4.0,
                    activeDotColor: Colors.white,
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    isLast
                        ? submit()
                        : pageController.nextPage(
                            duration: const Duration(milliseconds: 1000),
                            curve: Curves.ease);
                  },
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    color: Color.fromARGB(255, 23, 21, 81),
                  ),
                  backgroundColor: Colors.white,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage(model.image),
            ),
          ),
          Text(
            model.title,
            style: const TextStyle(
                fontFamily: 'myFont',
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24.0),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            model.body,
            style: const TextStyle(
              fontFamily: 'myFont',
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
        ],
      );
  void submit() {
    cacheHelper.saveData(key: 'OnBoarding', value: true).then((value) => {
          if (value)
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
                (route) => false)
        });
  }
}
