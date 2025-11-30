import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_scutum/di/injection_container.dart';
import 'package:space_scutum/features/weather/presentation/bloc/weather_cubit.dart';
import 'package:space_scutum/features/weather/presentation/bloc/weather_state.dart';

class CurrentWeatherWidget extends StatelessWidget {
  const CurrentWeatherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<WeatherCubit>()..loadWeather(),
      child: const _WeatherView(),
    );
  }
}

class _WeatherView extends StatelessWidget {
  const _WeatherView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        if (state.status == .loading) {
          return const Center(
            child: Padding(
              padding: .all(16.0),
              child: SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          );
        }
        if (state.status == .failure) {
          return Text(state.errorMessage ?? 'Unknown error');
        }
        final weather = state.weather;
        if (weather == null) return const SizedBox.shrink();
        return Container(
          margin: const .fromLTRB(16, 0, 16, 16),
          padding: const .symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF5B86E5), Color(0xFF36D1DC)],
              begin: .topLeft,
              end: .bottomRight,
            ),
            borderRadius: .circular(24),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF36D1DC).withValues(alpha: 0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    '${weather.temperature.round()}°',
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: .bold,
                      color: Colors.white,
                      height: 1.0,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    weather.cityName,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                      fontWeight: .w500,
                    ),
                  ),
                  Text(
                    weather.description,
                    style: const TextStyle(fontSize: 12, color: Colors.white70),
                  ),
                ],
              ),
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  shape: .circle,
                ),
                child: Image.network(weather.iconUrl, fit: .cover),
              ),
            ],
          ),
        );
      },
    );
  }
}
