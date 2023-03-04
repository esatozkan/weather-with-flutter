import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather/UTİLS/weather.dart';
import 'package:weather/screens/mainScreen.dart';
import '../UTİLS/location.dart';

class LoadingScreen extends StatefulWidget {
  @override
  LoadingScreenState createState() => LoadingScreenState();
}

class LoadingScreenState extends State<LoadingScreen> {
  LocationHelper locationData = LocationHelper();

  Future<void> getLocationData() async {
    locationData = LocationHelper();
    await locationData.getCurrentLocation();

    if (locationData.latitude == null || locationData.longitude == null) {
      showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: const Text("location unreachable"),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context, "Cancel"),
                      child: const Text("Cancel")),
                  TextButton(
                      onPressed: () => Navigator.pop(context, "OK"),
                      child: const Text("OK")),
                ],
              ));
    }
  }

  void getWeatherData() async {
    await getLocationData();
    WeatherData weatherData = WeatherData(locationData: locationData);
    await weatherData.getCurrentTemprature();
    if (weatherData.currentTemprature == null ||
        weatherData.currentCondition == null) {
      showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title:
                    const Text("Temperature or status from API returns null"),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context, "Cancel"),
                      child: const Text("Cancel")),
                  TextButton(
                      onPressed: () => Navigator.pop(context, "OK"),
                      child: const Text("OK")),
                ],
              ));
    }

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return MainScreen(
        weatherData: weatherData,
      );
    }));
  }

  @override
  void initState() async {
    super.initState();
    getWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.purple, Colors.blue])),
          child: Center(
            child: SpinKitFadingCircle(
              color: Colors.white,
              size: 150.0,
              duration: Duration(milliseconds: 1200),
            ),
          )),
    );
  }
}
