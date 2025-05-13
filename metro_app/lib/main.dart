import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:metro/screens/SplashScreen.dart';
import 'package:metro/screens/TicketQrcode.dart';
import 'package:metro/screens/app_localizations.dart';
import 'package:metro/screens/lines.dart';
import 'package:metro/screens/more_ticket.dart';
import 'package:metro/screens/ticket_screen.dart';

import '../screens/Details.dart';
import './cubit/ticket_cubit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TicketCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          AppLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'), // English
          Locale('ar'), // Arabic
        ],
        locale: const Locale('ar'), // Default to Arabic
        initialRoute: '/splash',

        routes: {
          '/': (context) => const TicketScreen(),
          '/details': (context) => const TripDetailsScreen(),
          '/lines': (context) => MetroLines(),
          '/myTickets': (context) => const TicketQRCodeScreen(),
          '/more': (context) => MoreScreen(),
          '/splash': (context) => const SplashScreen(),
        },
      ),
    );
  }
}
