import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotelio_app/models/booking_model.dart';

class BookingSource {
  static Future<BookingModel?> checkIsBooked(
      String userId, String hotelId) async {
    var result = await FirebaseFirestore.instance
        .collection('User')
        .doc(userId)
        .collection('Booking')
        .where('id_hotel')
        .where('is_done', isEqualTo: false)
        .get();
    if (result.size > 0) {
      return BookingModel.fromJson(
        result.docs.first.data(),
      );
    }
    return null;
  }

  static Future<bool> addBooking(String userId, BookingModel booking) async {
    var ref = FirebaseFirestore.instance
        .collection('User')
        .doc(userId)
        .collection('Booking');
    var docRef = await ref.add(booking.toJson());
    docRef.update({'id': docRef.id});
    return true;
  }
}
