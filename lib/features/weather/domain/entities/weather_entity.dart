class WeatherEntity {
  const WeatherEntity({
    required this.cityName,
    required this.temperature,
    required this.feelsLike,
    required this.description,
    required this.iconUrl,
    required this.windSpeed,
    required this.humidity,
  });

  final String cityName;
  final double temperature;
  final double feelsLike;
  final String description;
  final String iconUrl;
  final double windSpeed;
  final int humidity;
}
