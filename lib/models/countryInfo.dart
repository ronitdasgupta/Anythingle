import 'dart:core';

class CountryStats {
  final int countryAttempted;
  final int countryCompleted;
  final int countryLeast;
  final String countryPercentage;
  final String countryTime;

  CountryStats({ required this.countryAttempted, required this.countryCompleted, required this.countryLeast, required this.countryPercentage, required this.countryTime});

  factory CountryStats.fromJson(Map<String, dynamic> json) {
    return CountryStats(
      countryAttempted: json['countryAttempted'],
      countryCompleted: json['countryCompleted'],
      countryLeast: json['countryLeast'],
      countryPercentage: json['countryPercentage'],
      countryTime: json['countryTime'],
    );
  }

  static List<CountryStats> fromJsonArray(List<dynamic> jsonArray) {
    List<CountryStats> arrayOfCountryStats = [];

    jsonArray.forEach((jsonData) {
      arrayOfCountryStats.add(CountryStats.fromJson(jsonData));
    });

    return arrayOfCountryStats;
  }

  Map<String, dynamic> toJson() {
    return {
      "countryAttempted": countryAttempted,
      "countryCompleted": countryCompleted,
      "countryLeast": countryLeast,
      "countryPercentage": countryPercentage,
      "countryTime": countryTime,
    };
  }
}

class CountryInfo{
  final List<dynamic> countryStatistics;
  final String username;

  CountryInfo({ required this.countryStatistics, required this.username});
}