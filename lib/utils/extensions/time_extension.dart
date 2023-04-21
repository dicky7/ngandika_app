import '../functions/date_converter.dart';

extension DateUtil on DateTime {
  //The getLastSeen  returns a string that represents the date and time when the instance of the DateTime class was last seen. The string is constructed
  // using two methods of the DateConverter class: getLastSeenDayTime and dateConverterHoursAmPmMode.
  String get getLastSeen {
    return 'last seen ${DateConverter.getLastSeenDayTime(this)} at ${DateConverter.dateConverterHoursAmPmMode(this)}';
  }

  String get getChatContactTime {
    return DateConverter.getChatContactTime(this);
  }

  //this extension using for text time sent
  String get getTimeSentAmPmMode {
    return DateConverter.dateConverterHoursAmPmMode(this);
  }

  //this extension using for status time createAt
  String get getStatusTime24HoursMode {
    return DateConverter.dateConverter24HoursMode(this);
  }

  //this extension using for Chat Time Card
  String get getChatDayTime {
    return DateConverter.getLastSeenDayTime(this);
  }

  //this one check is same day with time send
  bool getIsSameDay(DateTime previousTime) {
    return DateConverter.getIsSameDay(this, previousTime);
  }
}
