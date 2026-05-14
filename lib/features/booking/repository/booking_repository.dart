import 'package:app/core/repository/generic_api_reposotory.dart';
import 'package:app/features/booking/model/booking.dart';

final bookingRepo = GenericApiRepository<Booking>(
  // для реального устройства  айпишка
  // baseUrl: 'http://192.168.5.49:8080/api/booking',
  baseUrl: 'http://localhost:8080/api/booking',
  fromJson: (json) => Booking.fromJson(json),
  toJson: (b) => b.toJson(),
);
