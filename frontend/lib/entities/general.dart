import 'dart:convert';

class General {
  General({
    required this.description,
    required this.temp,
    required this.feels,
    required this.pressure,
    required this.humidity,
    required this.wind_speed,
  });

  final String description;
  final int temp;
  final double feels;
  final int pressure;
  final int humidity;
  final double wind_speed;

  factory General.fromJson(String str) => General.fromMap(json.decode(str));
  String toJson() => json.encode(toMap());

  factory General.fromMap(Map<String, dynamic> json) => General(
        description: json["description"],
        temp: json["temp"],
        feels: json["feels_like"],
        pressure: json["pressure"],
        humidity: json["humidity"],
        wind_speed: json["speed"],
      );

  Map<String, dynamic> toMap() => {
        "description": description,
        "temp": temp,
        "feels_like": feels,
        "pressure": pressure,
        "humidity": humidity,
        "speed": wind_speed,
      };
}
