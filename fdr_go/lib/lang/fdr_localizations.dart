import 'dart:async';

import 'package:fdr_go/l10n/messages_all.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FdrLocalizations {
  /// Initialize localization systems and messages
  static Future<FdrLocalizations> load(Locale locale) async {
    // If we're given "en_US", we'll use it as-is. If we're
    // given "en", we extract it and use it.
    final String localeName =
        locale.countryCode == null || locale.countryCode.isEmpty
            ? locale.languageCode
            : locale.toString();

    // We make sure the locale name is in the right format e.g.
    // converting "en-US" to "en_US".
    final String canonicalLocaleName = Intl.canonicalizedLocale(localeName);

    // Load localized messages for the current locale.
    await initializeMessages(canonicalLocaleName);
    // We'll uncomment the above line after we've built our messages file

    // Force the locale in Intl.
    Intl.defaultLocale = canonicalLocaleName;

    return FdrLocalizations();
  }

  /// Retrieve localization resources for the widget tree
  /// corresponding to the given `context`
  static FdrLocalizations of(BuildContext context) =>
      Localizations.of<FdrLocalizations>(context, FdrLocalizations);

  String get signInLoginButton => Intl.message(
        'Enter',
        name: 'signInLoginButton',
      );

  String get signInEmailHint => Intl.message(
        'Email',
        name: 'signInEmailHint',
      );

  String get signInPasswordHint => Intl.message(
        'Password',
        name: 'signInPasswordHint',
      );

  String get signInForgotPassword => Intl.message(
        'Forgot your password?',
        name: 'signInForgotPassword',
      );

  String get signInAddAccount => Intl.message(
        'Add account',
        name: 'signInAddAccount',
      );

  String get signInSelectLanguage => Intl.message(
        'Select Language',
        name: 'signInSelectLanguage',
      );

  String get createAccountTitle => Intl.message(
        'Add Account',
        name: 'createAccountTitle',
      );

  String get createAccountEmailHint => Intl.message(
        'Email',
        name: 'createAccountEmailHint',
      );

  String get forgotPasswordTitle => Intl.message(
        'Recover Password',
        name: 'forgotPasswordTitle',
      );

  String get landingBusTitle => Intl.message(
        'Bus Service',
        name: 'landingBusTitle',
      );

  String get landingAsaTitle => Intl.message(
        'ASA Activities',
        name: 'landingAsaTitle',
      );

  String get menuStudents => Intl.message(
        'Students',
        name: 'menuStudents',
      );

  String get menuNotifications => Intl.message(
        'Notifications',
        name: 'menuNotifications',
      );

  String get menuLogOut => Intl.message(
        'Log Out',
        name: 'menuLogout',
      );

  String get notificationsTitle => Intl.message(
        'Notifications',
        name: 'notificationsTitle',
      );

  String get notificationDetailGrade => Intl.message(
        'Grade: ',
        name: 'notificationDetailGrade',
      );

  String get notificationDetailAcademicPeriod => Intl.message(
        'Academic Year',
        name: 'notificationDetailAcademicPeriod',
      );

  String get notificationDetailSession => Intl.message(
        'Session',
        name: 'notificationDetailSession',
      );

  String get notificationDetailActivity => Intl.message(
        'Activity',
        name: 'notificationDetailActivity',
      );

  String get notificationDetailCoach => Intl.message(
        'Coach',
        name: 'notificationDetailCoach',
      );

  String get notificationDetailMessage => Intl.message(
        'Message',
        name: 'notificationDetailMessage',
      );

  String get absenceTitle => Intl.message(
        'Absence Note',
        name: 'absenceTitle',
      );

  String get absenceReason => Intl.message(
        'Reason of the absence *',
        name: 'absenceReason',
      );

  String get absenceDateFrom => Intl.message(
        'From *',
        name: 'absenceDateFrom',
      );

  String get absenceDateTo => Intl.message(
        'Date up to *',
        name: 'absenceDateTo',
      );

  String get busServicesBusStop => Intl.message(
        'Bus stop',
        name: 'busServicesBusStop',
      );

  String get busServicesOnTheWay => Intl.message(
        'In route',
        name: 'busServicesOnTheWay',
      );

  String get busServicesSchool => Intl.message(
        'School',
        name: 'busServicesSchool',
      );

  String get busServicesAskBus => Intl.message(
        'Sign up for bus service',
        name: 'busServicesAskBus',
      );

  String get busServicesInReview => Intl.message(
        'In Review',
        name: 'busServicesInReview',
      );

  String get busServicesAbsenceButton => Intl.message(
        'Absent',
        name: 'busServicesAbsenceButton',
      );

  String get busServicesAbsence => Intl.message(
        'Absence',
        name: 'busServicesAbsence',
      );

  String get busServicesInProcess => Intl.message(
        'In Process',
        name: 'busServicesInProcess',
      );

  String get requestBusServiceTitle => Intl.message(
    'Bus Service Request',
    name: 'requestBusServiceTitle',
  );

  String get requestBusServiceRequestedBy => Intl.message(
    'Requested by',
    name: 'requestBusServiceRequestedBy',
  );

  String get requestBusServiceAddress => Intl.message(
    'Bus Service Request',
    name: 'requestBusServiceAddress',
  );

  String get requestBusServiceAddressDisclaimer => Intl.message(
    'Bus Service Request',
    name: 'requestBusServiceAddressDisclaimer',
  );

  String get requestBusServiceMode => Intl.message(
    'Bus Service Request',
    name: 'requestBusServiceMode',
  );

  String get requestBusServiceRequestDate => Intl.message(
    'Bus Service Request',
    name: 'requestBusServiceRequestDate',
  );

  String get requestBusServiceRequiredDate => Intl.message(
    'Fecha Requerida *',
    name: 'requestBusServiceRequiredDate',
  );

  String get termsTitle => Intl.message(
        'Contract',
        name: 'termsTitle',
      );

  String get busServiceChooseMode => Intl.message(
        'Type',
        name: 'busServiceChooseMode',
      );

  String get termsReject => Intl.message(
        'Reject',
        name: 'termsReject',
      );

  String get changeAsaTitle => Intl.message(
        'Change ASA',
        name: 'changeAsaTitle',
      );

  String get asaServicesSelectionButton => Intl.message(
        'Selection of ASA',
        name: 'asaServicesSelectionButton',
      );

  String get asaServicesChangeButton => Intl.message(
        'Change',
        name: 'asaServicesChangeButton',
      );

  String get asaServicesSuccessSave => Intl.message(
        'ASA activities saved successfully',
        name: 'asaServicesSuccessSave',
      );

  String get asaApplicationTitle => Intl.message(
        'Selection of ASA',
        name: 'asaApplicationTitle',
      );

  String get asaApplicationPreferenceDisclaimer => Intl.message(
        'The preference will be assigned according to the order of the clicks you make on the activities',
        name: 'asaApplicationPreferenceDisclaimer',
      );

  String get mon_thur => Intl.message(
        'Monday - Thursday',
        name: 'mon_thur',
      );

  String get tue_fri => Intl.message(
        'Tuesday - Friday',
        name: 'tue_fri',
      );

  String get asaApplicationBusRequired => Intl.message(
        'Required Bus',
        name: 'asaApplicationBusRequired',
      );

  String get monday => Intl.message(
        'Monday',
        name: 'monday',
      );

  String get tuesday => Intl.message(
        'Tuesday',
        name: 'tuesday',
      );

  String get thursday => Intl.message(
        'Thursday',
        name: 'thursday',
      );

  String get friday => Intl.message(
        'Friday',
        name: 'friday',
      );

  String get next => Intl.message(
        'Next',
        name: 'next',
      );

  String get accept => Intl.message(
        'Accept',
        name: 'accept',
      );

  String get confirm => Intl.message(
        'Confirm',
        name: 'confirm',
      );

  String get cancel => Intl.message(
        'Cancel',
        name: 'cancel',
      );

  String get close => Intl.message(
        'Close',
        name: 'close',
      );

  String get ok => Intl.message(
        'Ok',
        name: 'ok',
      );

  String get send => Intl.message(
        'Send',
        name: 'send',
      );

  String get invalidEmailValidation => Intl.message(
        'Invalid Email',
        name: 'invalidEmailValidation',
      );
}
