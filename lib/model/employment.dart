import 'package:flutter/material.dart';
class Employment {
  late String startDate;
  late String endDate;
  late String title;
  late String occupation;
  late String numberYearInTheSector;
  late String annualIncome;
  late String incomeType;
  late String employmentType;
  late String employerName;
  late String employerPhone;
  late String employerAddress;
  late String employerPostalCode;
  late String employerCity;
  late String employerRegion;
  late String employerCountry;
  late String pathToFile;
  late String status;

  Employment(
      {
        required this.startDate,
        required this.endDate,
        required this.title,
        required this.occupation,
        required this.numberYearInTheSector,
        required this.annualIncome,
        required this.incomeType,
        required this.employmentType,
        required this.employerName,
        required this.employerPhone,
        required this.employerAddress,
        required this.employerPostalCode,
        required this.employerCity,
        required this.employerRegion,
        required this.employerCountry,
        required this.pathToFile,
        required this.status
      }
    );
}