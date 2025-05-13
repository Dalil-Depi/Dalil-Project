import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../cubit/ticket_cubit.dart';
import '../widgets/base_layout.dart';

class TicketQRCodeScreen extends StatelessWidget {
  const TicketQRCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<TicketCubit>().state;

    final appBar = AppBar(
      title: const Text('تذكرتك'),
      centerTitle: true,
      backgroundColor: const Color(0xFF202F4B),
    );

    if (state.startStation == null ||
        state.endStation == null ||
        state.stations == null) {
      return BaseLayout(
        currentIndex: 2,
        appBar: appBar,
        child: const Center(
          child: Text(
            'لا توجد بيانات للتذكرة',
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Montserrat-Arabic-Regular',
            ),
          ),
        ),
      );
    }

    final qrData =
        {
          'from': state.startStation,
          'to': state.endStation,
          'stations': state.stations,
          'count': state.stationCount,
          'price': state.price,
          'duration': state.duration,
          'fromLine': state.fromLine,
          'toLine': state.toLine,
          'interchange': state.interchangeStation,
        }.toString();

    return BaseLayout(
      currentIndex: 2,
      appBar: appBar,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    QrImageView(
                      data: qrData,
                      version: QrVersions.auto,
                      size: 200.0,
                      backgroundColor: Colors.white,
                    ),
                    const SizedBox(height: 20),
                    _buildInfoRow('من', state.startStation!),
                    _buildInfoRow('إلى', state.endStation!),
                    _buildInfoRow('المدة', '${state.duration} دقيقة'),
                    _buildInfoRow('عدد المحطات', '${state.stationCount} محطة'),
                    _buildInfoRow('السعر', '${state.price} جنيه'),
                    if (state.interchangeStation != null)
                      _buildInfoRow('محطة التحويل', state.interchangeStation!),
                    if (state.fromLine != null)
                      _buildInfoRow('خط البداية', state.fromLine!),
                    if (state.toLine != null)
                      _buildInfoRow('خط الوصول', state.toLine!),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: const Color(0xFF202F4B).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    const Text(
                      'مسار الرحلة',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat-Arabic-Regular',
                      ),
                    ),
                    const SizedBox(height: 10),
                    ...state.stations!.asMap().entries.map((entry) {
                      final index = entry.key;
                      final station = entry.value;
                      final isInterchange = station == state.interchangeStation;

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          children: [
                            Icon(
                              isInterchange
                                  ? Icons.change_circle
                                  : Icons.circle,
                              color:
                                  isInterchange ? Colors.orange : Colors.grey,
                              size: 16,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              station,
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'Montserrat-Arabic-Regular',
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat-Arabic-Regular',
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'Montserrat-Arabic-Regular',
            ),
          ),
        ],
      ),
    );
  }
}
