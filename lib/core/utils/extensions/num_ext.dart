extension NumExt on num {
  String get formattedFromSecondTime {
    String ellapsed = '';
    int hours = this ~/ (60 * 60);
    int minutes = this ~/ 60;
    int seconds = (this % 60).toInt();
    if (hours > 0) ellapsed = '${hours}h';
    if (minutes > 0) {
      ellapsed = '$ellapsed ${minutes}m';
    }
    if (seconds > 0) {
      ellapsed = '$ellapsed ${seconds.toString().padLeft(2, '0')}s';
    }
    return ellapsed;
  }

  String get formattedFromMinuteTimeNoPadding {
    String ellapsed = '';

    int hours = this ~/ 60;
    int minutes = (this % 60).toInt();
    int seconds = ((this * 60) % 60).toInt();

    if (hours > 0) ellapsed = '${hours}h';
    if (minutes > 0) {
      ellapsed = '$ellapsed ${minutes}m';
    }
    if (seconds > 0) {
      ellapsed = '$ellapsed ${seconds}s';
    }
    return ellapsed;
  }
}
