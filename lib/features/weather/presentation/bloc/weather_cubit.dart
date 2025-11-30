import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:space_scutum/core/services/locator_service.dart';
import 'package:space_scutum/features/weather/domain/repository/weather_repository.dart';
import 'package:space_scutum/features/weather/presentation/bloc/weather_state.dart';

@injectable
class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit(this._weatherRepository, this._locationService)
    : super(const WeatherState(status: .initial));

  final WeatherRepository _weatherRepository;
  final LocationService _locationService;

  Future<void> loadWeather() async {
    emit(state.copyWith(status: .loading));
    try {
      final location = await _locationService.getCurrentLocation();
      final weather = await _weatherRepository.getCurrentWeather(
        lat: location.lat,
        lon: location.lon,
      );
      emit(state.copyWith(status: .success, weather: weather));
    } catch (e) {
      emit(state.copyWith(status: .failure, errorMessage: e.toString()));
    }
  }
}
