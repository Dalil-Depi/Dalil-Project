import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/ticket_cubit.dart';
import '../widgets/base_layout.dart';

class MetroLines extends StatelessWidget {
  const MetroLines({super.key});

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: const Text(
        'خطوط المترو',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontFamily: 'Montserrat-Arabic-Regular',
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
    );

    return BaseLayout(
      currentIndex: 1,
      appBar: appBar,
      backgroundColor: const Color(0xFFF2F2F2),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              buildLineContainer(
                context: context,
                start: "المرج الجديدة",
                end: "حلوان",
                title: "الخط الأول",
                description:
                    "يتكون الخط الأول من ٣٥ محطة\nالسادات - محطة تبادلية مع الخط الثانى\nناصر - محطة تبادلية مع الخط الثالث\nالشهداء - محطة تبادلية مع الخط الثانى",
                lineColor: const Color(0xFF0813DD), // أزرق
              ),
              const SizedBox(height: 24),
              buildLineContainer(
                context: context,
                start: "شبرا الخيمة",
                end: "المنيب",
                title: "الخط الثاني",
                description:
                    "يتكون الخط الثاني من ٢٠ محطة\nجامعة القاهرة - محطة تبادلية مع الخط الثالث\nالعنّاية - محطة تبادلية مع الخط الأول\nالشهداء - محطة تبادلية مع الخط الثاني",
                lineColor: const Color(0xFFDD0808),
                // أحمر
              ),
              const SizedBox(height: 24),
              buildLineContainer(
                context: context,
                start: "عدلي منصور",
                end: "روض الفرج",
                title: "الخط الثالث",
                description:
                    "يتكون الخط الثالث من ٣٣ محطة\nيوجد بها قطارات محددة إلى جامعة القاهرة\nناصر - محطة تبادلية مع الخط الثاني\nالشهداء - محطة تبادلية مع الخط الأول",
                lineColor: const Color(0xFF20C212),
                // أخضر
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLineContainer({
    required BuildContext context,
    required String start,
    required String end,
    required String title,
    required String description,
    required Color lineColor,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // المحطات
                Column(
                  children: [
                    Text(
                      start,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Montserrat-Arabic-Regular',
                      ),
                    ),
                    const SizedBox(height: 6),
                    Column(
                      children: [
                        const Icon(
                          Icons.circle,
                          size: 10,
                          color: Color(0xFF767676),
                        ),
                        Container(width: 2, height: 16, color: lineColor),
                        const Icon(
                          Icons.circle,
                          size: 10,
                          color: Color(0xFF767676),
                        ),
                        Container(width: 2, height: 16, color: lineColor),
                        const Icon(
                          Icons.circle,
                          size: 10,
                          color: Color(0xFF767676),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      end,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Montserrat-Arabic-Regular',
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 14),
                // النصوص
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat-Arabic-Regular',
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 13.5,
                          height: 1.5,
                          color: Colors.grey[700],
                          fontFamily: 'Montserrat-Arabic-Regular',
                        ),
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF192C4D),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                          ),
                          onPressed: () {
                            final ticketCubit = context.read<TicketCubit>();
                            if (ticketCubit.state.startStation != null &&
                                ticketCubit.state.endStation != null &&
                                ticketCubit.state.startStation !=
                                    ticketCubit.state.endStation) {
                              Navigator.pushNamed(context, '/details');
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'الرجاء اختيار محطتين مختلفتين',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat-Arabic-Regular',
                                    ),
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                          child: const Text(
                            'تفاصيل الرحلة',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // الجزء السفلي الملون
          Container(
            width: double.infinity,
            height: 18,
            decoration: BoxDecoration(
              color: lineColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
