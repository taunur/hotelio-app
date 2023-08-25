import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotelio_app/config/app.assets.dart';
import 'package:hotelio_app/config/app.color.dart';
import 'package:hotelio_app/config/app.format.dart';
import 'package:hotelio_app/controller/c_user.dart';
import 'package:hotelio_app/models/booking_model.dart';

class DetailBookingPage extends StatelessWidget {
  DetailBookingPage({super.key});

  final cUser = Get.put(CUSer());

  @override
  Widget build(BuildContext context) {
    BookingModel booking =
        ModalRoute.of(context)!.settings.arguments as BookingModel;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: const Text(
          "Detail Booking",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          header(booking, context),
          const SizedBox(height: 16),
          roomDetails(context, booking),
          const SizedBox(height: 16),
          paymentMethod(context),
          const SizedBox(height: 20),
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

  Container roomDetails(BuildContext context, BookingModel booking) {
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
              booking.date,
            ),
            itemRoomDetails(
              context,
              "Guest",
              "${booking.guest} Guest",
            ),
            itemRoomDetails(
              context,
              "Breakfast",
              booking.breakfast,
            ),
            itemRoomDetails(
              context,
              "Check-in Time",
              booking.checkInTime,
            ),
            itemRoomDetails(
              context,
              "${booking.night} night",
              AppFormat.currency(1250000),
            ),
            itemRoomDetails(
              context,
              "Service Fee",
              AppFormat.currency(booking.serviceFee.toDouble()),
            ),
            itemRoomDetails(
              context,
              "Activities",
              AppFormat.currency(booking.activities.toDouble()),
            ),
            itemRoomDetails(
              context,
              "Total Payment",
              AppFormat.currency(booking.totalPayment.toDouble()),
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

  Container header(BookingModel booking, BuildContext context) {
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
              booking.cover,
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
                  booking.name,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  booking.location,
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
