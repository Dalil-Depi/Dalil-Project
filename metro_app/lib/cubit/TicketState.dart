import 'package:equatable/equatable.dart';

class TicketState extends Equatable {
  final String? startStation;
  final String? endStation;
  final String? errorMessage;
  final bool bookingSuccess;
  final List<String>? stations;
  final int? stationCount;
  final int? price;
  final int? duration;
  final String? fromLine;
  final String? toLine;
  final String? interchangeStation;

  const TicketState({
    this.startStation,
    this.endStation,
    this.errorMessage,
    this.bookingSuccess = false,
    this.stations,
    this.stationCount,
    this.price,
    this.duration,
    this.fromLine,
    this.toLine,
    this.interchangeStation,
  });

  TicketState copyWith({
    String? startStation,
    String? endStation,
    String? errorMessage,
    bool? bookingSuccess,
    List<String>? stations,
    int? stationCount,
    int? price,
    int? duration,
    String? fromLine,
    String? toLine,
    String? interchangeStation,
  }) {
    return TicketState(
      startStation: startStation ?? this.startStation,
      endStation: endStation ?? this.endStation,
      errorMessage: errorMessage ?? this.errorMessage,
      bookingSuccess: bookingSuccess ?? this.bookingSuccess,
      stations: stations ?? this.stations,
      stationCount: stationCount ?? this.stationCount,
      price: price ?? this.price,
      duration: duration ?? this.duration,
      fromLine: fromLine ?? this.fromLine,
      toLine: toLine ?? this.toLine,
      interchangeStation: interchangeStation ?? this.interchangeStation,
    );
  }

  @override
  List<Object?> get props => [
    startStation,
    endStation,
    errorMessage,
    bookingSuccess,
    stations,
    stationCount,
    price,
    duration,
    fromLine,
    toLine,
    interchangeStation,
  ];
}
