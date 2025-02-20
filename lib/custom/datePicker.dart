import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class DatePickerCustom extends CommonPickerModel {
  String digits(int value, int length) {
    return '$value'.padLeft(length, "0");
  }

  DatePickerCustom({DateTime currentTime, LocaleType locale})
      : super(locale: locale) {
    this.currentTime = currentTime ?? DateTime.now();
    this.setLeftIndex(this.currentTime.day);
    this.setMiddleIndex(this.currentTime.month);
    this.setRightIndex(this.currentTime.year);
  }

  @override
  String rightStringAtIndex(int index) {
    if (index >= 2000 && index < 2040) {
      return this.digits(index, 4);
    } else {
      return null;
    }
  }

  @override
  String middleStringAtIndex(int index) {
    if (index > 0 && index <= 12) {
      return this.digits(index, 2);
    } else {
      return null;
    }
  }

  @override
  String leftStringAtIndex(int index) {
    if (index > 0 && index <= 31) {
      return this.digits(index, 2);
    } else {
      return null;
    }
  }

  @override
  String leftDivider() {
    return "/";
  }

  @override
  String rightDivider() {
    return "/";
  }

  @override
  List<int> layoutProportions() {
    return [1, 1, 1];
  }

  @override
  DateTime finalTime() {
    return currentTime.isUtc
        ? DateTime.utc(
            currentTime.year,
            currentTime.month,
            currentTime.day,
            this.currentLeftIndex(),
            this.currentMiddleIndex(),
            this.currentRightIndex())
        : DateTime(
            currentTime.year,
            currentTime.month,
            currentTime.day,
            this.currentLeftIndex(),
            this.currentMiddleIndex(),
            this.currentRightIndex());
  }
}
