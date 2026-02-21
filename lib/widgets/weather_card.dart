import 'package:castle_weather/models/weather_model.dart';
import 'package:castle_weather/providers/weather_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WeatherCard extends StatefulWidget {
  const WeatherCard({super.key, required this.weatherModel});

  final WeatherModel weatherModel;

  @override
  State<WeatherCard> createState() => _WeatherCardState();
}

class _WeatherCardState extends State<WeatherCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slide;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );

    _slide = Tween(
      begin: Offset(0, 0.5),
      end: Offset(0, 0),
    ).animate(_controller);

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<WeatherProvider>();
    return SlideTransition(
      position: _slide,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(widget.weatherModel.cityName),
              Text('${widget.weatherModel.temperature} C'),
              Image.network(
                'https://openweathermap.org/img/wn/${widget.weatherModel.icon}@2x.png',
              ),
              Text(widget.weatherModel.description),
              Text('Влажность: ${widget.weatherModel.humidity}'),
              Text('Скорость ветра: ${widget.weatherModel.windSpeed}'),

              SizedBox(height: 20),
              Text('Прогноз на 3 дня'),
              SizedBox(height: 10),
              SizedBox(
                height: 180,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: provider.forecast.length,
                  itemBuilder: (context, index) {
                    final day = provider.forecast[index];
                    return Container(
                      margin: EdgeInsets.all(8),
                      padding: EdgeInsets.all(12),
                      color: Colors.white,
                      child: Column(
                        children: [
                          Text(day.date.substring(5, 10)),
                          Image.network(
                            'https://openweathermap.org/img/wn/${widget.weatherModel.icon}@2x.png',
                          ),
                          Text('${day.temperature.toStringAsFixed(0)} C'),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
