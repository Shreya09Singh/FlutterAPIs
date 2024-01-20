import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/Views/additionalinfo.dart';
import 'package:weather_app/Views/hourly_forcastitem.dart';
import 'package:weather_app/Views/secret.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late double temp = 0.0;

  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      String cityName = 'London';
      final response = await http.get(Uri.parse(
          "https://api.openweathermap.org/data/2.5/forecast?q=$cityName,uk&APPID=$openWeatherApiKey"));
      final data = jsonDecode(response.body);
      // print(data);
      // print("hii Shreya!");
      if (data['cod'] != '200') {
        throw 'An unexpected error occured';
      }
      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Color.fromARGB(255, 2, 78, 139),
              Color.fromARGB(255, 2, 78, 139),
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          ),
          title: Text(
            "Mausam",
            style: GoogleFonts.raleway(
              fontSize: 27,
              fontWeight: FontWeight.w800,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  onPressed: () {
                    setState(() {});
                  },
                  icon: Icon(
                    Icons.refresh,
                  )),
            )
          ],
          centerTitle: true,
        ),
        body: Container(
          height: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromARGB(255, 2, 78, 139),
            Color.fromARGB(255, 2, 78, 139),
            Color.fromARGB(255, 139, 178, 209),
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: FutureBuilder(
              future: getCurrentWeather(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                final data = snapshot.data!;
                final currWeatherdata = data['list'][0];
                final currTemp = currWeatherdata['main']['temp'];
                final temperature = currTemp - 273.15;
                final realTemp = temperature.round();
                final currSky = currWeatherdata['weather'][0]['main'];
                final CurrPressure = currWeatherdata['main']['pressure'];
                final CurrHumidity = currWeatherdata['main']['humidity'];
                final CurrWindSpeed = currWeatherdata['wind']['speed'];

                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Card(
                            color: Colors.blueGrey,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(39)),
                            elevation: 5,
                            child: ClipRRect(
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 3, sigmaY: 2),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        "$realTemp°C",
                                        style: GoogleFonts.tienne(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Icon(
                                        currSky == 'Clouds' || currSky == 'rain'
                                            ? Icons.cloud
                                            : Icons.sunny,
                                        size: 100,
                                      ),
                                      Text(
                                        "$currSky",
                                        style: GoogleFonts.raleway(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Weather Forecast",
                          style: GoogleFonts.raleway(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 11,
                        ),
                        SingleChildScrollView(
                          child: SizedBox(
                            height: 135,
                            child: Expanded(
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 5,
                                  itemBuilder: ((context, index) {
                                    final fourcastitem =
                                        data['list'][index + 1];
                                    final time =
                                        DateTime.parse(fourcastitem['dt_txt']);

                                    final hourlySky =
                                        fourcastitem['weather'][0]['main'];
                                    final hourlyTemp =
                                        fourcastitem['main']['temp'];
                                    final tempInfo =
                                        (hourlyTemp - 273.15).round();
                                    // final tt = int.parse(tempInfo);

                                    return Padding(
                                      padding: const EdgeInsets.only(right: 6),
                                      child: HourlyForcastItem(
                                          time: DateFormat.j().format(time),
                                          temperature: "$tempInfo°C",
                                          icon: hourlySky == 'Clouds' ||
                                                  hourlySky == 'Rain'
                                              ? Icons.cloud
                                              : Icons.sunny),
                                    );
                                  })),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Additional Information",
                          style: GoogleFonts.raleway(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              AdditionalInfo(
                                  icon: Icons.water_drop,
                                  text1: "Humidity",
                                  text2: "$CurrHumidity"),
                              AdditionalInfo(
                                  icon: Icons.air,
                                  text1: "Wind Speed",
                                  text2: "$CurrWindSpeed"),
                              AdditionalInfo(
                                  icon: Icons.beach_access,
                                  text1: "Pressure",
                                  text2: "$CurrPressure"),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
        ));
  }
}
