import 'package:flutter/material.dart';
import 'package:weather/UTİLS/weather.dart';

class MainScreen extends StatefulWidget {
  final WeatherData weatherData;

  const MainScreen({super.key, required this.weatherData});

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int? temperature;
  Icon? weatherDisplayIcon;
  AssetImage? backgrounImage;
  String? city;

  void updateDisplayInfo(WeatherData weatherData) {
    setState(() {
      temperature = weatherData.currentTemprature?.round();
      city = weatherData.city;
      WeatherDisplayData weatherDisplayData =
          weatherData.getWeatherDisplayData();
      backgrounImage = weatherDisplayData.weatherImage;
      weatherDisplayIcon = weatherDisplayData.weatherIcon;
    });
  }

  @override
  void initState() {
    super.initState();
    updateDisplayInfo(widget.weatherData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(image: backgrounImage!, fit: BoxFit.cover),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 40,
            ),
            Container(child: weatherDisplayIcon),
            SizedBox(
              height: 15,
            ),
            Center(
              child: Text(
                "$temperature°",
                style: TextStyle(
                    color: Colors.white, fontSize: 80.0, letterSpacing: -5),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: Text(
                "$city",
                style: TextStyle(
                    color: Colors.white, fontSize: 50.0, letterSpacing: -5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
