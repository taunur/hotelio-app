// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:hotelio_app/config/app.assets.dart';
import 'package:hotelio_app/config/app.color.dart';
import 'package:hotelio_app/config/app.format.dart';
import 'package:hotelio_app/config/app.route.dart';
import 'package:hotelio_app/controller/c_nearby.dart';
import 'package:hotelio_app/models/hotel_model.dart';

class NearbyPage extends StatelessWidget {
  NearbyPage({super.key});

  final cNearby = Get.put(CNearby());

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 24),
        header(context),
        const SizedBox(height: 20),
        searchField(),
        const SizedBox(height: 30),
        categories(),
        const SizedBox(height: 30),
        hotel(),
      ],
    );
  }

  GetBuilder<CNearby> hotel() {
    return GetBuilder<CNearby>(
      builder: (_) {
        List<HotelModel> list = _.category == "All Place"
            ? _.listHotel
            : _.listHotel.where((e) => e.category == _.category).toList();
        if (list.isEmpty) return const Center(child: Text("Empty"));
        return ListView.builder(
          itemCount: list.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            HotelModel hotel = list[index];
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, AppRoute.detail, arguments: hotel);
              },
              child: Container(
                margin: EdgeInsets.fromLTRB(
                  16,
                  index == 0 ? 0 : 8,
                  16,
                  index == list.length - 1 ? 16 : 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Image.network(
                          hotel.cover,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  hotel.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      "Start from ",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 13,
                                      ),
                                    ),
                                    Text(
                                      AppFormat.currency(
                                          hotel.price.toDouble()),
                                      style: const TextStyle(
                                        color: AppColor.secondary,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Text(
                                      "/night",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          RatingBar.builder(
                            initialRating: hotel.rate,
                            minRating: 0,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemBuilder: (context, _) => const Icon(
                              Icons.star_rate_rounded,
                              color: AppColor.starActive,
                            ),
                            itemSize: 18,
                            unratedColor: AppColor.starInActive,
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                            ignoreGestures: true,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  GetBuilder<CNearby> categories() {
    return GetBuilder<CNearby>(builder: (_) {
      return SizedBox(
        height: 45,
        child: ListView.builder(
          itemCount: _.categories.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            String category = _.categories[index];
            return Padding(
              padding: EdgeInsets.fromLTRB(
                index == 0 ? 16 : 8,
                0,
                index == cNearby.categories.length - 1 ? 16 : 8,
                0,
              ),
              child: Material(
                color: category == _.category ? AppColor.primary : Colors.white,
                borderRadius: BorderRadius.circular(20),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    _.category = category;
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      category,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }

  Container searchField() {
    return Container(
      height: 45,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        children: [
          Container(
            height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
            ),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                hintText: 'Search by name or city',
                hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Material(
              color: AppColor.secondary,
              borderRadius: BorderRadius.circular(45),
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(45),
                child: const SizedBox(
                  width: 45,
                  height: 45,
                  child: Center(
                    child: ImageIcon(
                      AssetImage(AppAssets.iconSearch),
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding header(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset(
              AppAssets.profile,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Near Me",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Obx(() {
                return Text(
                  "${cNearby.listHotel.length} hotels",
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}
