import 'package:app/core/bloc/generic_bloc.dart';
import 'package:app/features/booking/model/booking.dart';
import 'package:app/features/booking/repository/booking_repository.dart';

final bookingBloc = GenericBloc<Booking>(repository: bookingRepo);
