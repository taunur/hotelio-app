import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotelio_app/config/app.assets.dart';
import 'package:hotelio_app/config/app.color.dart';
import 'package:hotelio_app/config/app.format.dart';
import 'package:hotelio_app/config/app.route.dart';
import 'package:hotelio_app/controller/c_user.dart';
import 'package:hotelio_app/models/booking_model.dart';
import 'package:hotelio_app/models/hotel_model.dart';
import 'package:hotelio_app/source/booking_source.dart';
import 'package:hotelio_app/widgets/button_custom.dart';

class DetailPage extends StatelessWidget {
  DetailPage({super.key});

  final List facilities = [
    {
      'icon': AppAssets.iconCoffee,
      'label': 'Lounge',
    },
    {
      'icon': AppAssets.iconOffice,
      'label': 'Office',
    },
    {
      'icon': AppAssets.iconWifi,
      'label': 'Wi-Fi',
    },
    {
      'icon': AppAssets.iconStore,
      'label': 'Store',
    },
  ];

  // booking
  final cUser = Get.put(CUSer());
  final Rx<BookingModel> _bookedData = initBooking.obs;
  BookingModel get bookedData => _bookedData.value;
  set bookedData(BookingModel n) => _bookedData.value = n;

  @override
  Widget build(BuildContext context) {
    HotelModel hotel = ModalRoute.of(context)!.settings.arguments as HotelModel;
    BookingSource.checkIsBooked(cUser.data.id!, hotel.id).then((bookingValue) {
      bookedData = bookingValue ?? initBooking;
    });

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
      bottomNavigationBar: Obx(() {
        if (bookedData.id == '') return bookingNow(hotel, context);
        return viewReceipt();
      }),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: ListView(
          children: [
            const SizedBox(height: 24),
            images(hotel),
            const SizedBox(height: 16),
            name(hotel, context),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                hotel.description,
                textAlign: TextAlign.justify,
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                "Facilities",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            gridFacilities(),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                "Activities",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            const SizedBox(height: 8),
            activities(hotel),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Container viewReceipt() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey[100]!, width: 1.5),
        ),
      ),
      height: 80,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "You booked this.",
            style: TextStyle(color: Colors.grey),
          ),
          Material(
            color: AppColor.secondary,
            borderRadius: BorderRadius.circular(20),
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {},
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 36,
                  vertical: 14,
                ),
                child: Text(
                  'View Receipt',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  SizedBox activities(HotelModel hotel) {
    return SizedBox(
      height: 105,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: hotel.activities.length,
        itemBuilder: (context, index) {
          Map activicty = hotel.activities[index];
          return Padding(
            padding: EdgeInsets.fromLTRB(
              index == 0 ? 16 : 8,
              0,
              index == hotel.images.length - 1 ? 16 : 8,
              0,
            ),
            child: Column(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      activicty['image'],
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  activicty['name'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Container bookingNow(HotelModel hotel, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey[100]!, width: 1.5),
        ),
      ),
      height: 80,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppFormat.currency(
                  hotel.price.toDouble(),
                ),
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: AppColor.secondary,
                      fontWeight: FontWeight.w900,
                    ),
              ),
              const Text(
                'per night',
                style: TextStyle(color: Colors.grey),
              )
            ],
          ),
          ButtonCustom(
            label: "Booking Now",
            onTap: () {
              Navigator.pushNamed(context, AppRoute.checkout, arguments: hotel);
            },
          )
        ],
      ),
    );
  }

  GridView gridFacilities() {
    return GridView.builder(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
        itemCount: facilities.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[200]!),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ImageIcon(
                  AssetImage(
                    facilities[index]['icon'],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  facilities[index]['label'],
                  style: const TextStyle(fontSize: 13),
                )
              ],
            ),
          );
        });
  }

  Padding name(HotelModel hotel, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hotel.name,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                Text(
                  hotel.location,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.star_rate_rounded,
            color: AppColor.starActive,
          ),
          const SizedBox(width: 4),
          Text(
            hotel.rate.toString(),
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          )
        ],
      ),
    );
  }

  SizedBox images(HotelModel hotel) {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        itemCount: hotel.images.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.fromLTRB(
              index == 0 ? 16 : 8,
              0,
              index == hotel.images.length - 1 ? 16 : 8,
              0,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                hotel.images[index],
                fit: BoxFit.cover,
                height: 180,
                width: 240,
              ),
            ),
          );
        },
      ),
    );
  }
}
