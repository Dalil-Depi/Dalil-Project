import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:metro/generated/intl/messages_all.dart';

class AppLocalizations {
  static Future<AppLocalizations> load(Locale locale) {
    final name =
        locale.countryCode?.isEmpty ?? true
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return AppLocalizations();
    });
  }

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  String get goodMorning => Intl.message('Good Morning', name: 'goodMorning');

  String get wishYouSafety =>
      Intl.message('Wish you safety', name: 'wishYouSafety');

  String remainingBalance(num amount) => Intl.message(
    'Remaining balance: $amount EGP',
    name: 'remainingBalance',
    args: [amount],
  );

  String get charge => Intl.message('Charge', name: 'charge');

  String get bookTicketNow =>
      Intl.message('Book your ticket now!', name: 'bookTicketNow');

  String get selectStations => Intl.message(
    'Select stations and know your trip details and ticket prices',
    name: 'selectStations',
  );

  String get selectDeparture =>
      Intl.message('Select departure station', name: 'selectDeparture');

  String get selectArrival =>
      Intl.message('Select arrival station', name: 'selectArrival');

  String get bookTicket => Intl.message('Book Ticket', name: 'bookTicket');

  String get tripDetails => Intl.message('Trip Details', name: 'tripDetails');

  String get metroLines => Intl.message('Metro Lines', name: 'metroLines');

  String get myTickets => Intl.message('My Tickets', name: 'myTickets');

  String get more => Intl.message('More', name: 'more');
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ar'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
