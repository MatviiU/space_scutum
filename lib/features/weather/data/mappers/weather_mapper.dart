import 'package:space_scutum/features/weather/data/data_source/models/weather_model.dart';
import 'package:space_scutum/features/weather/domain/entities/weather_entity.dart';

extension WeatherModelToEntity on WeatherModel {
  WeatherEntity toEntity() {
    final iconCode = weather?.firstOrNull?.icon ?? '01d';
    final iconUrl = 'https://openweathermap.org/img/wn/$iconCode@4x.png';
    return WeatherEntity(
      cityName: name ?? 'Unknown City',
      temperature: main?.temp ?? 0.0,
      feelsLike: main?.feelsLike ?? 0.0,
      description: weather?.first.description ?? '',
      iconUrl: iconUrl,
      windSpeed: wind?.speed ?? 0.0,
      humidity: main?.humidity ?? 0,
    );
  }
}
