import 'package:get/get.dart';
import 'package:hotelio_app/models/booking_model.dart';
import 'package:hotelio_app/source/booking_source.dart';

class CHistory extends GetxController {
  final _listBooking = <BookingModel>[].obs;
  List<BookingModel> get listBooking => _listBooking;

  getListBooking(String id) async {
    _listBooking.value = await BookingSource.getHistory(id);
    update();
  }
}
