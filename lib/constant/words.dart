import 'dart:convert';

import '../screens/home/countries.dart';
import 'package:http/http.dart' as http;

const List<String> words = [
  'INDIA'
];

/*
Future<List<String>> getCountriesFromAPI() async {
  var response = await http.get(Uri.https('restcountries.com', 'v3.1/all'));
  var jsonData = jsonDecode(response.body);
  List<String> currentCountries = [];
  for(var u in jsonData) {
    Country country = Country(u['name']['common']);
    if(country.common.length < 11 && !country.common.contains(" ") && country.common != "CuraÃ§ao" && country.common != "RÃ©union") {
      currentCountries.add(country.common);
    }
  }
  return currentCountries;
}
 */