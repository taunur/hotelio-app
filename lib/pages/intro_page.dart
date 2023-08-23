import 'package:flutter/material.dart';
import 'package:hotelio_app/config/app.assets.dart';
import 'package:hotelio_app/config/app.route.dart';
import 'package:hotelio_app/widgets/buttom_custom.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          AppAssets.bgIntro,
          fit: BoxFit.cover,
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.4,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black,
                Colors.transparent,
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your Great Life\nStarts Here',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                "More than just a hotel",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
              ),
              const SizedBox(
                height: 30,
              ),
              ButtomCustom(
                label: 'Get Started',
                onTap: () {
                  Navigator.pushReplacementNamed(context, AppRoute.signin);
                },
                isExpanded: true,
              ),
            ],
          ),
        )
      ],
    ));
  }
}
