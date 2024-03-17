class Temperature {
  int? id;
  int? value;
  DateTime? date;

  Temperature({required this.id, required this.value, this.date});

  String condition() {
    List<String> statusCondition = [
      'Cool',
      'Cold',
      'Chilly',
      'Warm',
      'Hot',
      'Sweltering',
      'Freezing',
      'Subzero'
    ];

    if (value! <= -20) {
      return statusCondition[7];
    }

    if (value! <= -10) {
      return statusCondition[6];
    }

    if (value! < 5) {
      return statusCondition[2];
    }

    if (value! < 10) {
      return statusCondition[1];
    }

    if (value! <= 20 && value! >= 15) {
      return statusCondition[0];
    }

    if (value! < 30 && value! >= 20) {
      return statusCondition[3];
    }

    if (value! < 35 && value! >= 30) {
      return statusCondition[4];
    }

    return statusCondition[5];
  }
}
