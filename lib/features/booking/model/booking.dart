import 'package:app/core/model/base_model.dart';

class Booking extends BaseModel {
  @override
  final String id;
  final String clientId;
  final String? clientName;
  final String? clientPhone;
  final List<String> serviceIds;
  final List<String>? servicesNames;
  final DateTime date;
  final double price;
  final String? comment;

  Booking({
    required this.id,
    required this.clientId,
    this.clientName,
    this.clientPhone,

    required this.serviceIds,
    this.servicesNames,
    required this.date,
    required this.price,
    this.comment,
  });

  Booking copyWith({
    String? id,
    String? clientId,
    String? clientName,
    String? clientPhone,
    List<String>? serviceIds,
    List<String>? servicesNames,
    DateTime? date,
    double? price,
    String? comment,
  }) {
    return Booking(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      clientName: clientName ?? this.clientName,
      clientPhone: clientPhone ?? this.clientPhone,
      serviceIds: serviceIds ?? this.serviceIds,
      servicesNames: servicesNames ?? this.servicesNames,
      date: date ?? this.date,
      price: price ?? this.price,
      comment: comment ?? this.comment,
    );
  }

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'] as String,
      clientId: json['client_id'] as String,
      clientName: json['client_name'] as String,
      clientPhone: json['client_phone'].toString(),
      serviceIds: (json['service_ids'] as List<dynamic>)
          .map((e) => e.toString())
          .toList(),
      servicesNames: (json['services_names'] as List<dynamic>)
          .map((e) => e.toString())
          .toList(),
      date: DateTime.parse(json['booking_date'] as String),

      price: (json['price'] as num).toDouble(),
      comment: json['comment'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'clientId': clientId,
      'serviceIds': serviceIds,
      'date': date.toIso8601String(),
      'price': price,
      'comment': comment,
    };
  }
}
