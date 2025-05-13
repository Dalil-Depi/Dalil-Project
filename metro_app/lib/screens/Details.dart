import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/TicketState.dart';
import '../cubit/ticket_cubit.dart';
import '../widgets/base_layout.dart';

class TripDetailsScreen extends StatelessWidget {
  const TripDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<TicketCubit>().state;

    // Debug: Print the stations order to the console
    // ignore: avoid_print
    print(
      'Stations order: \\n' + (state.stations?.join(' -> ') ?? 'No stations'),
    );

    final appBar = AppBar(
      title: const Text(
        'تفاصيل الرحلة',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontFamily: 'Montserrat-Arabic-Regular',
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_forward_ios, color: Colors.black),
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/');
        },
      ),
    );

    if (state.startStation == null ||
        state.endStation == null ||
        state.startStation == state.endStation) {
      return BaseLayout(
        currentIndex: 0,
        appBar: appBar,
        child: const Center(
          child: Text(
            'لا توجد بيانات للرحلة',
            style: TextStyle(fontFamily: 'Montserrat-Arabic-Regular'),
          ),
        ),
      );
    }

    return BaseLayout(
      currentIndex: 0,
      appBar: appBar,
      backgroundColor: const Color(0xFFF4F4F4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    state.startStation!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat-Arabic-Regular',
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Icon(Icons.arrow_forward, color: Colors.grey),
                ),
                Flexible(
                  child: Text(
                    state.endStation!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat-Arabic-Regular',
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF202F4B),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TripInfoItem(
                    icon: Icons.access_time,
                    label: 'الوقت',
                    value: '${state.duration} دقيقة',
                  ),
                  TripInfoItem(
                    icon: Icons.train,
                    label: 'محطات',
                    value: '${state.stationCount} محطة',
                  ),
                  TripInfoItem(
                    icon: Icons.monetization_on,
                    label: 'السعر',
                    value: '${state.price} جنيه',
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'تفاصيل مشوارك',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat-Arabic-Regular',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    state.interchangeStation == null
                        ? 'هتركب ${state.fromLine} ومفيش تحويلات'
                        : 'هتركب ${state.fromLine} وتحول عند ${state.interchangeStation} ل${state.toLine}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'Montserrat-Arabic-Regural',
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.flag_outlined),
                        SizedBox(width: 8),
                        Text(
                          'خط سير رحلتك',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat-Arabic-Regular',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(children: _buildStationList(state)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF202F4B),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  context.read<TicketCubit>().bookTicket();
                },
                child: const Text(
                  'احجز التذكرة',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat-Arabic-Regular',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildStationList(TicketState state) {
    if (state.stations == null) return [];

    final widgets = <Widget>[];
    final isSingleLine = state.interchangeStation == null;

    for (int i = 0; i < state.stations!.length; i++) {
      final station = state.stations![i];
      final isInterchange = station == state.interchangeStation;
      final isFirst = i == 0;
      final isLast = i == state.stations!.length - 1;

      widgets.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  if (isFirst)
                    const Icon(Icons.location_on, color: Colors.green, size: 20)
                  else if (isLast)
                    const Icon(Icons.location_on, color: Colors.red, size: 20)
                  else if (isInterchange)
                    const Icon(
                      Icons.change_circle,
                      color: Colors.orange,
                      size: 20,
                    )
                  else
                    const Icon(
                      Icons.circle,
                      color: Color.fromARGB(180, 137, 230, 224),
                      size: 12,
                    ),
                  if (i < state.stations!.length - 1 &&
                      !isLast &&
                      !isInterchange)
                    Container(
                      width: 1,
                      height: 20,
                      color: const Color.fromARGB(255, 158, 158, 158),
                      margin: const EdgeInsets.only(top: 2),
                    ),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      station,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight:
                            isFirst || isLast || isInterchange
                                ? FontWeight.bold
                                : FontWeight.normal,
                        fontFamily: 'Montserrat-Arabic-Regular',
                      ),
                    ),
                    if (isInterchange)
                      Text(
                        'محطة تحويل ل${state.toLine}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontFamily: 'Montserrat-Arabic-Regular',
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return widgets;
  }
}

class TripInfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const TripInfoItem({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 28),
        const SizedBox(height: 5),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
        const SizedBox(height: 3),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat-Arabic-Regular',
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}

List<String> _getPath(String from, String to, List<String> lineStations) {
  final fromIndex = lineStations.indexOf(from);
  final toIndex = lineStations.indexOf(to);

  if (fromIndex == -1 || toIndex == -1) return [];

  if (fromIndex <= toIndex) {
    return lineStations.sublist(fromIndex, toIndex + 1);
  } else {
    return lineStations.sublist(toIndex, fromIndex + 1).reversed.toList();
  }
}

String? _getBestInterchange(
  String from,
  String to,
  List<String> fromLineStations,
  List<String> toLineStations,
) {
  final commonStations =
      fromLineStations
          .where((station) => toLineStations.contains(station))
          .toList();
  if (commonStations.isEmpty) return null;

  int fromIndex = fromLineStations.indexOf(from);
  int toIndex = toLineStations.indexOf(to);

  String? bestStation;
  int minDistance = 99999;
  for (var station in commonStations) {
    int d1 = (fromLineStations.indexOf(station) - fromIndex).abs();
    int d2 = (toLineStations.indexOf(station) - toIndex).abs();
    int total = d1 + d2;
    if (total < minDistance) {
      minDistance = total;
      bestStation = station;
    }
  }

  print('Common stations: $commonStations');
  print('From: $from, To: $to');

  return bestStation;
}
