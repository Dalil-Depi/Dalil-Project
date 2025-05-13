import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metro/cubit/TicketState.dart';

class TicketCubit extends Cubit<TicketState> {
  final Map<String, List<String>> metroLines = {
    'Line1': [
      'المرج الجديدة',
      'المرج',
      'عزبة النخل',
      'عين شمس',
      'المطرية',
      'حدائق الزيتون',
      'حمامات القبة',
      'سراي القبة',
      'حدائق القبة',
      'الزيتون',
      'غمرة',
      'الشهداء',
      'أحمد عرابي',
      'جمال عبد الناصر',
      'أنور السادات',
      'سعد زغلول',
      'السيدة زينب',
      'الملك الصالح',
      'مار جرجس',
      'الزهراء',
      'دار السلام',
      'حدائق المعادي',
      'المعادي',
      'ثكنات المعادي',
      'طرة البلد',
      'كوتسيكا',
      'طرة الأسمنت',
      'المعصرة',
      'حدائق حلوان',
      'وادي حوف',
      'جامعة حلوان',
      'عين حلوان',
      'حلوان',
    ],
    'Line2': [
      'شبرا الخيمة',
      'كلية الزراعة',
      'المظلات',
      'الخلفاوي',
      'سانت تريزا',
      'روض الفرج',
      'مسرة',
      'الشهداء',
      'العتبة',
      'محمد نجيب',
      'أنور السادات',
      'الأوبرا',
      'الدقي',
      'البحوث',
      'جامعة القاهرة',
      'فيصل',
      'الجيزة',
      'ضواحي الجيزة',
      'ساقية مكي',
      'المنيب',
    ],
    'Line3': [
      'عدلي منصور',
      'الهايكستب',
      'عمر بن الخطاب',
      'قباء',
      'هشام بركات',
      'النزهة',
      'نادي الشمس',
      'ألف مسكن',
      'هليوبوليس',
      'هارون',
      'الأهرام',
      'كلية البنات',
      'الاستاد',
      'أرض المعارض',
      'العباسية',
      'عبده باشا',
      'الجيش',
      'باب الشعرية',
      'العتبة',
      'جمال عبد الناصر',
      'ماسبيرو',
      'صفاء حجازي',
      'الكيت كات',
      'السودان',
      'إمبابة',
      'البوهي',
      'القومية العربية',
      'الطريق الدائري',
      'محور روض الفرج',
      'التوفيقية',
      'وادي النيل',
      'جامعة الدول العربية',
      'بولاق الدكرور',
      'جامعة القاهرة',
    ],
  };

  final Map<String, String> lineDirections = {
    'Line1': 'حلوان ↔ المرج الجديدة',
    'Line2': 'المنيب ↔ شبرا الخيمة',
    'Line3': 'جامعة القاهرة ↔ عدلي منصور',
  };

  TicketCubit() : super(const TicketState());

  List<String> getAllStations() {
    return metroLines.values.expand((list) => list).toSet().toList();
  }

  void selectStartStation(String? station) {
    if (station == null) {
      emit(state.copyWith(startStation: null, errorMessage: null));
      return;
    }

    if (station == state.endStation) {
      emit(
        state.copyWith(
          errorMessage: 'لا يمكن اختيار نفس المحطة للبداية والوصول',
          startStation: null,
        ),
      );
    } else {
      emit(
        state.copyWith(
          startStation: station,
          errorMessage: null,
          stations: null,
          stationCount: null,
          price: null,
          duration: null,
        ),
      );
    }
  }

  void selectEndStation(String? station) {
    if (station == null) {
      emit(state.copyWith(endStation: null, errorMessage: null));
      return;
    }

    if (station == state.startStation) {
      emit(
        state.copyWith(
          errorMessage: 'لا يمكن اختيار نفس المحطة للبداية والوصول',
          endStation: null,
        ),
      );
    } else {
      emit(
        state.copyWith(
          endStation: station,
          errorMessage: null,
          stations: null,
          stationCount: null,
          price: null,
          duration: null,
        ),
      );
    }
  }

  void setErrorMessage(String message) {
    emit(state.copyWith(errorMessage: message));
  }

  Future<void> calculateTrip() async {
    if (state.startStation == null || state.endStation == null) {
      emit(state.copyWith(errorMessage: 'يجب اختيار محطتي البداية والوصول'));
      return;
    }

    if (state.startStation == state.endStation) {
      emit(
        state.copyWith(
          errorMessage: 'لا يمكن اختيار نفس المحطة للبداية والنهاية',
        ),
      );
      return;
    }

    final fromLine = _getLineForStation(state.startStation!);
    final toLine = _getLineForStation(state.endStation!);

    if (fromLine == null || toLine == null) {
      emit(state.copyWith(errorMessage: 'خطأ في تحديد خط المترو'));
      return;
    }

    List<String> stations = [];
    String? interchange;
    int stationCount = 0;
    int price = 0;
    int duration = 0;

    if (fromLine == toLine) {
      stations = _getPath(
        state.startStation!,
        state.endStation!,
        metroLines[fromLine]!,
      );
      stationCount = stations.length - 1;
    } else {
      interchange = _getBestInterchange(fromLine, toLine);
      if (interchange == null) {
        emit(state.copyWith(errorMessage: 'لا يوجد مسار مباشر بين المحطتين'));
        return;
      }

      final firstLeg = _getPath(
        state.startStation!,
        interchange,
        metroLines[fromLine]!,
      );
      final secondLeg = _getPath(
        interchange,
        state.endStation!,
        metroLines[toLine]!,
      );

      stations = [...firstLeg, ...secondLeg.skip(1)];
      stationCount = stations.length - 1;
    }

    price = stationCount <= 9 ? 5 : (stationCount <= 16 ? 7 : 10);
    duration = stationCount * 2 + (interchange != null ? 5 : 0);

    emit(
      state.copyWith(
        stations: stations,
        stationCount: stationCount,
        price: price,
        duration: duration,
        fromLine: lineDirections[fromLine],
        toLine: lineDirections[toLine],
        interchangeStation: interchange,
        errorMessage: null,
      ),
    );
  }

  void bookTicket() {
    if (state.startStation == null || state.endStation == null) {
      emit(
        state.copyWith(errorMessage: 'يجب اختيار محطتي البداية والوصول أولاً'),
      );
      return;
    }

    if (state.stations == null || state.stationCount == null) {
      emit(state.copyWith(errorMessage: 'يجب حساب الرحلة أولاً'));
      return;
    }

    emit(state.copyWith(bookingSuccess: true, errorMessage: null));
  }

  String? _getLineForStation(String station) {
    for (var entry in metroLines.entries) {
      if (entry.value.contains(station)) {
        return entry.key;
      }
    }
    return null;
  }

  String? _getBestInterchange(String line1, String line2) {
    final fromLineStations = metroLines[line1]!;
    final toLineStations = metroLines[line2]!;

    final commonStations =
        fromLineStations.where((s) => toLineStations.contains(s)).toList();
    if (commonStations.isEmpty) return null;

    final fromIndex = fromLineStations.indexOf(state.startStation!);
    final toIndex = toLineStations.indexOf(state.endStation!);

    String? bestStation;
    int minTotalDistance = 999999;

    for (var station in commonStations) {
      final stationIndexInFrom = fromLineStations.indexOf(station);
      final stationIndexInTo = toLineStations.indexOf(station);

      final distanceFromStart = (stationIndexInFrom - fromIndex).abs();
      final distanceToEnd = (stationIndexInTo - toIndex).abs();
      final totalDistance = distanceFromStart + distanceToEnd;

      if (totalDistance < minTotalDistance) {
        minTotalDistance = totalDistance;
        bestStation = station;
      }
    }

    return bestStation;
  }

  void clearErrorMessage() {
    emit(state.copyWith(errorMessage: null));
  }

  void resetErrorMessage() {
    emit(state.copyWith(errorMessage: null));
  }

  List<String> _getPath(String from, String to, List<String> lineStations) {
    final fromIndex = lineStations.indexOf(from);
    final toIndex = lineStations.indexOf(to);

    if (fromIndex == -1 || toIndex == -1) return [];

    if (fromIndex < toIndex) {
      return lineStations.sublist(fromIndex, toIndex + 1);
    } else {
      return lineStations.sublist(toIndex, fromIndex + 1).reversed.toList();
    }
  }
}
