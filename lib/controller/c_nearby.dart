import 'package:get/get.dart';
import 'package:hotelio_app/models/hotel_model.dart';
import 'package:hotelio_app/source/hotel_source.dart';

class CNearby extends GetxController {
  final _category = "All Place".obs;
  String get category => _category.value;
  set category(String n) {
    _category.value = n;
    update();
  }

  List<String> get categories => [
        'All Place',
        'Industrial',
        'Village',
      ];

  final _listHotel = <HotelModel>[].obs;
  List<HotelModel> get listHotel => _listHotel;

  getListHotel() async {
    _listHotel.value = await HotelSource.getHotel();
    update();
  }

  @override
  void onInit() {
    getListHotel();
    super.onInit();
  }
}
