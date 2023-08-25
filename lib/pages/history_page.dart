import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:hotelio_app/config/app.assets.dart';
import 'package:hotelio_app/config/app.color.dart';
import 'package:hotelio_app/config/app.format.dart';
import 'package:hotelio_app/config/app.route.dart';
import 'package:hotelio_app/controller/c_history.dart';
import 'package:hotelio_app/controller/c_user.dart';
import 'package:hotelio_app/models/booking_model.dart';
import 'package:intl/intl.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final cHistory = Get.put(CHistory());
  final cUser = Get.put(CUSer());

  @override
  void initState() {
    cHistory.getListBooking(cUser.data.id!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: [
          const SizedBox(height: 24),
          header(context),
          const SizedBox(height: 24),
          GetBuilder<CHistory>(builder: (_) {
            return GroupedListView<BookingModel, String>(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              elements: _.listBooking,
              groupBy: (element) => element.date,
              groupSeparatorBuilder: (String groupByValue) {
                String date = DateFormat('yyyy-MM-dd').format(DateTime.now()) ==
                        groupByValue
                    ? 'Today New'
                    : AppFormat.dateMonth(groupByValue);
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    date,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                );
              },
              itemBuilder: (context, dynamic element) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoute.detailBooking,
                        arguments: element,
                      );
                    },
                    child: item(context, element),
                  ),
                );
              },
              // untuk menyusun sorting mana dulu yang di urutkan
              itemComparator: (item1, item2) => item1.date.compareTo(
                item2.date,
              ),
              order: GroupedListOrder.DESC,
            );
          }),
        ],
      ),
    );
  }

  Widget item(BuildContext context, BookingModel booking) {
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
          const SizedBox(width: 16),
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
                  AppFormat.date(booking.date),
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: booking.status == 'PAID' ? AppColor.secondary : Colors.red,
              borderRadius: BorderRadius.circular(30),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 2,
            ),
            child: Text(
              booking.status,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          )
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
                "My Booking",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Obx(() {
                return Text(
                  "${cHistory.listBooking.length} transactions",
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
