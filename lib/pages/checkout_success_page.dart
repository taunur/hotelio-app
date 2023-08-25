import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotelio_app/controller/c_home.dart';
import 'package:hotelio_app/models/hotel_model.dart';
import 'package:hotelio_app/pages/home_page.dart';
import 'package:hotelio_app/widgets/button_custom.dart';

class CheckoutSuccessPage extends StatelessWidget {
  const CheckoutSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cHome = Get.put(CHome());
    HotelModel hotel = ModalRoute.of(context)!.settings.arguments as HotelModel;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(width: 6, color: Colors.white),
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                hotel.cover,
                width: 190,
                height: 190,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 46),
          Text(
            "Payment Success",
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
          ),
          const SizedBox(height: 10),
          Text(
            "Enjoy your a whole new experience\nin this beautiful world",
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 46),
          ButtonCustom(
            label: "View My Booking",
            onTap: () {
              cHome.indexPage = 1;
              Get.offAll(() => HomePage());
            },
          )
        ],
      ),
    );
  }
}
