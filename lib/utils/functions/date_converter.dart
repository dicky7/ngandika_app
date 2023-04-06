class DateConverter {
  //The purpose of this code is to provide a more user-friendly representation of the date and time of a chat message by returning a string indicating the
  // time elapsed since the message was sent.
  static String getChatContactTime(DateTime dateTime) {
    //The function first initializes the current date and time using DateTime.now() and calculates yesterday's date using now.subtract(const Duration(days: 1)).
    DateTime now = DateTime.now();
    DateTime yesterday = now.subtract(const Duration(days: 1));
    // then converts the input DateTime object to the local timezone using toLocal().
    DateTime localDateTime = dateTime.toLocal();

    //If the localDateTime occurred today, the function calls dateConverterHoursAmPmMode method to convert the time of the dateTime object into the
    // 12-hour clock format with the am/pm indicator and returns the resulting string.
    if (localDateTime.day == now.day &&
        localDateTime.month == now.month &&
        localDateTime.year == now.year) {
      return dateConverterHoursAmPmMode(dateTime);
    }
    //If the localDateTime occurred yesterday, the function returns the string 'Yesterday'.
    else if (localDateTime.day == yesterday.day &&
        localDateTime.month == yesterday.month &&
        localDateTime.year == yesterday.year) {
      return 'Yesterday';
    }
    //If the localDateTime occurred earlier than yesterday, the function calls the dateConverterMonthNum method to convert the dateTime object into a string
    // in the format "dd/mm" for the date and returns the resulting string.
    else {
      return dateConverterMonthNum(dateTime.toString());
    }
  }

  // This method takes two parameters DateTime objects, nowTime and previousTime, and returns a boolean value indicating whether these two date-time
  // values belong to the same day.
  static bool getIsSameDay(DateTime nowTime, DateTime previousTime) {
    //The function first converts both DateTime objects to the local time zone by calling the toLocal() method on each.
    DateTime now = nowTime.toLocal();
    DateTime previous = previousTime.toLocal();
    //It then compares the day, month, and year properties of the two DateTime objects to determine if they refer to the same day.
    //If they do, the function returns true. If they do not, the function returns false.
    if (now.day == previous.day &&
        now.month == previous.month &&
        now.year == previous.year) {
      return true;
    }
    return false;
  }

  //The getLastSeenDayTime method  takes a DateTime object and returns a string that represents the day when the object was last seen.
  // It checks if the object was last seen today, yesterday, or some other day, and returns the corresponding string
  static String getLastSeenDayTime(DateTime dateTime) {
    DateTime now = DateTime.now();
    DateTime yesterday = now.subtract(const Duration(days: 1));
    DateTime localDateTime = dateTime.toLocal();

    if (localDateTime.day == now.day &&
        localDateTime.month == now.month &&
        localDateTime.year == now.year) {
      return 'today';
    } else if (localDateTime.day == yesterday.day &&
        localDateTime.month == yesterday.month &&
        localDateTime.year == yesterday.year) {
      return 'yesterday';
    } else {
      return dateConverterMonthNum(dateTime.toString());
    }
  }

  //The dateConverterHoursAmPmMode method takes a DateTime object and returns a string that represents the time when the object was last seen in
  // the 12-hour clock format with the am/pm indicator. returns a string representation of the time in AM/PM mode, such as "03:30 pm".
  static String dateConverterHoursAmPmMode(DateTime dateTime) {
    int hour = dateTime.hour;
    String minute = dateTime.minute.toString().padLeft(2, '0');
    String period = hour < 12 ? 'am' : 'pm';
    hour = hour % 12;
    if (hour == 0) {
      hour = 12;
    }
    return '$hour:$minute $period';
  }

  //The dateConverterMonthNum method takes a string that represents a date in the format "yyyy-mm-dd hh:mm:ss" and
  // returns a string in the format "dd/mm" for the date.
  static String dateConverterMonthNum(String string) {
    int i = 0;
    String s = "";
    String monthNum = string.split('')[5] + string.split('')[6];
    String dayNum = string.split('')[8] + string.split('')[9];

    List<String> mN = [
      '01',
      '02',
      '03',
      '04',
      '05',
      '06',
      '07',
      '08',
      '09',
      '10',
      '11',
      '12'
    ];

    for (i = 0; i < 12; ++i) {
      if (monthNum == mN[i]) {
        s = '$dayNum/${mN[i]}/';
        break;
      }
    }
    for (i = 2; i < 4; ++i) {
      s += string.split('')[i];
    }
    return s;
  }
}
