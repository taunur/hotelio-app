import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotelio_app/config/app.assets.dart';
import 'package:hotelio_app/config/app.color.dart';
import 'package:hotelio_app/config/app.format.dart';
import 'package:hotelio_app/controller/c_user.dart';
import 'package:hotelio_app/models/booking_model.dart';
import 'package:hotelio_app/models/hotel_model.dart';
import 'package:hotelio_app/source/booking_source.dart';
import 'package:hotelio_app/widgets/button_custom.dart';
import 'package:intl/intl.dart';

import '../config/app.route.dart';

class CheckoutPage extends StatelessWidget {
  CheckoutPage({super.key});

  final cUser = Get.put(CUSer());

  @override
  Widget build(BuildContext context) {
    HotelModel hotel = ModalRoute.of(context)!.settings.arguments as HotelModel;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: const Text(
          "Hotel Details",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          header(hotel, context),
          const SizedBox(height: 16),
          roomDetails(context, hotel),
          const SizedBox(height: 16),
          paymentMethod(context),
          const SizedBox(height: 20),
          ButtonCustom(
            label: "Proceed to Payment",
            isExpanded: true,
            onTap: () {
              BookingSource.addBooking(
                cUser.data.id!,
                BookingModel(
                  id: '',
                  idHotel: hotel.id,
                  cover: hotel.cover,
                  name: hotel.name,
                  location: hotel.location,
                  date: DateFormat.ABBR_MONTH_DAY,
                  guest: 1,
                  breakfast: 'Include',
                  checkInTime: DateFormat.HOUR,
                  night: 2,
                  serviceFee: 150000,
                  activities: 350000,
                  totalPayment: hotel.price + 2 + 150000 + 350000,
                  status: 'PAID',
                  isDone: false,
                ),
              );
              Navigator.pushNamed(
                context,
                AppRoute.checkoutSuccess,
                arguments: hotel,
              );
            },
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Container paymentMethod(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Payment Method",
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey[300]!),
            ),
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  AppAssets.iconMasterCard,
                  width: 50,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Elliot York Owell",
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                      ),
                      const Text(
                        "Balance Rp. 5.0000.000",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.check_circle,
                  color: AppColor.secondary,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Container roomDetails(BuildContext context, HotelModel hotel) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Room Details",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
            ),
            const SizedBox(height: 16),
            itemRoomDetails(
              context,
              "Date",
              AppFormat.date(DateTime.now().toString()),
            ),
            itemRoomDetails(
              context,
              "Guest",
              "2 Guest",
            ),
            itemRoomDetails(
              context,
              "Breakfast",
              "Included",
            ),
            itemRoomDetails(
              context,
              "Check-in Time",
              "14:00 WIB",
            ),
            itemRoomDetails(
              context,
              "1 night",
              AppFormat.currency(hotel.price.toDouble()),
            ),
            itemRoomDetails(
              context,
              "Service Fee",
              AppFormat.currency(150000),
            ),
            itemRoomDetails(
              context,
              "Activities",
              AppFormat.currency(350000),
            ),
            itemRoomDetails(
              context,
              "Total Payment",
              AppFormat.currency(1750000),
            ),
          ],
        ));
  }

  Padding itemRoomDetails(BuildContext context, String title, String data) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontSize: 16,
                ),
          ),
          Text(
            data,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }

  Container header(HotelModel hotel, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              hotel.cover,
              fit: BoxFit.cover,
              height: 70,
              width: 90,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hotel.name,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  hotel.location,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
