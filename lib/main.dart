import 'package:flutter/material.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WeatherPage(),
    );
  }
}

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  List<Map<String, dynamic>> cityData = [
    {
      "city": "Bangkok",
      "country": "Thailand",
      "lastUpdated": "2023-10-25 19:45",
      "tempC": 30,
      "tempF": 86,
      "feelsLikeC": 38.1,
      "feelsLikeF": 100.5,
      "windKph": 6.8,
      "windMph": 4.3,
      "humidity": 70,
      "uv": 1,
      "condition": {
        "text": "Partly cloudy",
        "icon": "https://cdn.weatherapi.com/weather/128x128/night/116.png",
        "code": 1003
      },
    },
    {
      "city": "Nakhon Pathom",
      "country": "Thailand",
      "lastUpdated": "2023-10-26 09:00",
      "tempC": 27.8,
      "tempF": 82.1,
      "feelsLikeC": 32,
      "feelsLikeF": 89.5,
      "windKph": 5.8,
      "windMph": 3.6,
      "humidity": 80,
      "uv": 6,
      "condition": {
        "text": "Light rain shower",
        "icon": "https://cdn.weatherapi.com/weather/128x128/day/353.png",
        "code": 1240
      },
    },
  ];

  int selectedCityIndex = 0;
  bool isTemperatureInCelsius = true;

  double getTemperature() {
    return isTemperatureInCelsius
        ? cityData[selectedCityIndex]['tempC']
        : cityData[selectedCityIndex]['tempF'];
  }

  String getTemperatureUnit() {
    return isTemperatureInCelsius ? "°C" : "°F";
  }

  String getWindSpeedUnit() {
    return isTemperatureInCelsius ? "km/h" : "mph";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      backgroundColor: Colors.grey, // Set the background color to gray
      body: Container(
        color: Colors.grey[200], // Optionally set the color of the inner container if needed
        child: Column(
          children: <Widget>[
            SizedBox(height: 30),
            Align(
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: cityData.map((data) {
                  return ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedCityIndex = cityData.indexOf(data);
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      primary: selectedCityIndex == cityData.indexOf(data)
                          ? Colors.blue
                          : Colors.grey,
                      minimumSize: Size(150, 50), // Button size
                    ),
                    child: Text(
                      data['city'],
                      style: TextStyle(
                        fontSize: 24, // Font size
                        color: selectedCityIndex == cityData.indexOf(data)
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.bold, // Make it bold
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isTemperatureInCelsius = true;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: isTemperatureInCelsius ? Colors.blue : Colors.grey,
                    minimumSize: Size(70, 40), // Button size
                  ),
                  child: Text(
                    '°C',
                    style: TextStyle(
                      fontSize: 24, // Font size
                      color: isTemperatureInCelsius ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isTemperatureInCelsius = false;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: !isTemperatureInCelsius ? Colors.blue : Colors.grey,
                    minimumSize: Size(70, 40), // Button size
                  ),
                  child: Text(
                    '°F',
                    style: TextStyle(
                      fontSize: 24, // Font size
                      color: !isTemperatureInCelsius ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'City: ${cityData[selectedCityIndex]['city']}',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.blue[900]),
                  ),
                  Text('Country: ${cityData[selectedCityIndex]['country']}',
                    style: TextStyle(fontSize: 24, color: Colors.blue[900]),
                  ),
                  SizedBox(height: 20),
                  Text('Last Updated: ${cityData[selectedCityIndex]['lastUpdated']}',
                    style: TextStyle(fontSize: 24, color: Colors.blue[900]),
                  ),
                  Image.network(cityData[selectedCityIndex]['condition']['icon'], width: 100, height: 100), // Image size
                  Text('Temperature: ${getTemperature()} ${getTemperatureUnit()}',
                    style: TextStyle(fontSize: 28, color: Colors.blue[900]),
                  ),
                  Text('Feels Like: ${cityData[selectedCityIndex]['feelsLikeC']} °C',
                    style: TextStyle(fontSize: 26, color: Colors.blue[900]),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Text('Humidity', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                            Text('${cityData[selectedCityIndex]['humidity']}%', style: TextStyle(fontSize: 22, color: Colors.blue[900])),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Text('Wind', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                            Text('${cityData[selectedCityIndex]['windKph']} ${getWindSpeedUnit()}', style: TextStyle(fontSize: 22, color: Colors.blue[900])),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Text('UV', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                            Text('${cityData[selectedCityIndex]['uv']}', style: TextStyle(fontSize: 22, color: Colors.blue[900])),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
