import 'package:json_annotation/json_annotation.dart';

part 'weather_model.g.dart';

@JsonSerializable(createToJson: false)
class WeatherModel {
  const WeatherModel({this.weather, this.main, this.wind, this.name});

  factory WeatherModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherModelFromJson(json);
  final List<WeatherDescription>? weather;
  final WeatherMain? main;
  final WeatherWind? wind;
  final String? name;
}

@JsonSerializable(createToJson: false)
class WeatherDescription {
  const WeatherDescription({this.main, this.description, this.icon});

  factory WeatherDescription.fromJson(Map<String, dynamic> json) =>
      _$WeatherDescriptionFromJson(json);
  final String? main;
  final String? description;
  final String? icon;
}

@JsonSerializable(createToJson: false)
class WeatherMain {
  const WeatherMain({this.temp, this.feelsLike, this.humidity});

  factory WeatherMain.fromJson(Map<String, dynamic> json) =>
      _$WeatherMainFromJson(json);
  final double? temp;
  @JsonKey(name: 'feels_like')
  final double? feelsLike;
  final int? humidity;
}

@JsonSerializable(createToJson: false)
class WeatherWind {
  const WeatherWind({this.speed});

  factory WeatherWind.fromJson(Map<String, dynamic> json) =>
      _$WeatherWindFromJson(json);
  final double? speed;
}
