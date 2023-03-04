import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'location.dart';

const apiKey = "b1ecc58a5bd3a7d40f9924a56162dcf5";

class WeatherDisplayData {
  Icon weatherIcon;
  AssetImage weatherImage;
  WeatherDisplayData({
    required this.weatherIcon,
    required this.weatherImage,
  });
}

class WeatherData {
  WeatherData({required this.locationData});

  LocationHelper? locationData;
  double? currentTemprature;
  int? currentCondition;
  String? city;

  Future<void> getCurrentTemprature() async {
    Response response = await get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=${locationData!.latitude}&lon=${locationData!.longitude}&appid=${apiKey!}&units=metric'));

    if (response.statusCode == 200) {
      String data = response.body;
      var currentWeather = jsonDecode(data);

      try {
        currentTemprature = currentWeather['main']['temp'];
        currentCondition = currentWeather['weather'][0]['id'];
        city = currentWeather["name"];
      } catch (e) {
        print(e);
      }
    } else {
      print("apiden değer gelmiyor");
    }
  }

  WeatherDisplayData getWeatherDisplayData() {
    if (currentCondition! < 600) {
      return WeatherDisplayData(
          weatherIcon: Icon(
            FontAwesomeIcons.cloud,
            size: 75.0,
            color: Colors.white,
          ),
          weatherImage: AssetImage('assets/cloudy.png'));
    } else {
      var now = new DateTime.now();
      if (now.hour >= 19) {
        return WeatherDisplayData(
            weatherIcon: Icon(
              FontAwesomeIcons.moon,
              size: 75.0,
              color: Colors.white,
            ),
            weatherImage: AssetImage('assets/night.png'));
      } else {
        return WeatherDisplayData(
            weatherIcon: Icon(
              FontAwesomeIcons.sun,
              size: 75.0,
              color: Colors.white,
            ),
            weatherImage: AssetImage('assets/sunny.png'));
      }
    }
  }
}
