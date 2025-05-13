import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metro/screens/Details.dart';
import 'package:metro/screens/payment_page.dart';

import '../cubit/TicketState.dart';
import '../cubit/ticket_cubit.dart';
import '../widgets/base_layout.dart';

class TicketScreen extends StatefulWidget {
  const TicketScreen({super.key});
  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  String? _selectedDeparture;
  String? _selectedArrival;
  double currentMony = 0.0;
  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      currentIndex: 0,
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.28,
            color: const Color.fromRGBO(32, 47, 75, 1.0),
            child: Stack(
              children: [
                Positioned(
                  top: 38,
                  left: -50,
                  child: Image.asset(
                    'images/station.png',
                    width: 270,
                    height: 215,
                  ),
                ),
                Positioned(
                  top: 25,
                  right: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Image.asset('images/dalilW.png', width: 100, height: 90),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text(
                            'صباح الخير',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat-Arabic-Regular',
                            ),
                            textDirection: TextDirection.rtl,
                          ),
                          SizedBox(width: 8),

                          Icon(Icons.wb_sunny, color: Colors.yellow, size: 30),
                        ],
                      ),
                      const SizedBox(height: 3),
                      const Text(
                        'نتمنى لكم السلامة',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Montserrat-Arabic-Regular',
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.account_balance_wallet,
                              color: Colors.green,
                            ),
                            const SizedBox(width: 8),
                            // Text(
                            //   'الرصيد المتبقي : $currentMony جنيه',
                            //   style: TextStyle(
                            //     fontSize: 16,
                            //     fontFamily: 'Montserrat-Arabic-Regular',
                            //     color: Colors.black,
                            //   ),
                            // ),
                            Text(
                              'الرصيد المتبقي : ${currentMony.toStringAsFixed(2)} جنيه',
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Montserrat-Arabic-Regular',
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                          ),
                          onPressed: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) =>
                                        PaymentPage(currentAmount: currentMony),
                              ),
                            );

                            if (result != null && result is double) {
                              setState(() {
                                currentMony += result;
                              });
                            }
                          },
                          child: const Text(
                            'اشحن',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Montserrat-Arabic-Regular',
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8F8F8),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 15),
                        const Text(
                          '! احجز تذكرتك دلوقتي',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat-Arabic-Regular',
                            color: Color.fromRGBO(32, 47, 75, 1.0),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            'اختر المحطات واعرف تفاصيل رحلتك وأسعار التذاكر',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              fontFamily: 'Montserrat-Arabic-Regular',
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildStationDropdown(
                          context,
                          hint: 'اختر محطة القيام',
                          isDeparture: true,
                          value: _selectedDeparture,
                        ),
                        const SizedBox(height: 20),
                        _buildStationDropdown(
                          context,
                          hint: 'اختر محطة الوصول',
                          isDeparture: false,
                          value: _selectedArrival,
                        ),
                        BlocConsumer<TicketCubit, TicketState>(
                          listener: (context, state) {
                            setState(() {
                              _selectedDeparture = state.startStation;
                              _selectedArrival = state.endStation;
                            });
                          },
                          builder: (context, state) {
                            if (state.errorMessage != null) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Text(
                                  state.errorMessage!,
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 13,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              );
                            }
                            return const SizedBox();
                          },
                        ),
                        const SizedBox(height: 30),
                        Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromRGBO(
                                    32,
                                    47,
                                    75,
                                    1.0,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 15,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  elevation: 2,
                                ),
                                onPressed: () {},
                                child: const Text(
                                  'احجز تذكرتك',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Montserrat-Arabic-Regular',
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 15,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: const BorderSide(
                                      color: Color.fromRGBO(32, 47, 75, 1.0),
                                    ),
                                  ),
                                  elevation: 1,
                                ),
                                onPressed: () {
                                  final cubit = context.read<TicketCubit>();
                                  final start = cubit.state.startStation;
                                  final end = cubit.state.endStation;

                                  if (start == null || end == null) {
                                    cubit.setErrorMessage(
                                      'يجب اختيار محطتي البداية والوصول أولاً',
                                    );
                                    return;
                                  }

                                  if (start == end) {
                                    cubit.setErrorMessage(
                                      'لا يمكن اختيار نفس المحطة للبداية والنهاية',
                                    );
                                    return;
                                  }

                                  cubit.calculateTrip().then((_) {
                                    if (cubit.state.errorMessage == null) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) =>
                                                  const TripDetailsScreen(),
                                        ),
                                      );
                                    }
                                  });
                                },
                                child: const Text(
                                  'تفاصيل رحلتك',
                                  style: TextStyle(
                                    color: Color.fromRGBO(32, 47, 75, 1.0),
                                    fontFamily: 'Montserrat-Arabic-Regular',
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStationDropdown(
    BuildContext context, {
    required String hint,
    required bool isDeparture,
    required String? value,
  }) {
    final cubit = context.read<TicketCubit>();
    final stations = cubit.getAllStations();

    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
      items:
          stations
              .map(
                (station) => DropdownMenuItem<String>(
                  value: station,
                  child: Text(
                    station,
                    style: const TextStyle(
                      fontFamily: 'Montserrat-Arabic-Regular',
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                ),
              )
              .toList(),
      onChanged: (value) {
        if (value == null) return;

        if (isDeparture) {
          cubit.selectStartStation(value);
        } else {
          cubit.selectEndStation(value);
        }

        final start = cubit.state.startStation;
        final end = cubit.state.endStation;

        if (start != null && end != null) {
          if (start == end) {
            cubit.setErrorMessage('لا يمكن اختيار نفس المحطة للبداية والنهاية');
          } else {
            cubit.clearErrorMessage();
          }
        }
      },
      validator: (value) {
        if (value == null) {
          return 'الرجاء اختيار $hint';
        }
        return null;
      },
      style: const TextStyle(
        color: Colors.black,
        fontFamily: 'Montserrat-Arabic-Regular',
      ),
      dropdownColor: Colors.white,
      icon: const Icon(Icons.arrow_drop_down),
      isExpanded: true,
      hint: Text(
        hint,
        style: const TextStyle(
          color: Colors.grey,
          fontFamily: 'Montserrat-Arabic-Regular',
        ),
        textDirection: TextDirection.rtl,
      ),
    );
  }
}
