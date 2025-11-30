import 'package:equatable/equatable.dart';
import 'package:space_scutum/features/weather/domain/entities/weather_entity.dart';

enum WeatherStatus { initial, loading, success, failure }

class WeatherState extends Equatable {
  const WeatherState({required this.status, this.weather, this.errorMessage});

  final WeatherStatus status;
  final WeatherEntity? weather;
  final String? errorMessage;

  WeatherState copyWith({
    WeatherStatus? status,
    WeatherEntity? weather,
    String? errorMessage,
  }) {
    return WeatherState(
      status: status ?? this.status,
      weather: weather ?? this.weather,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, weather, errorMessage];
}
