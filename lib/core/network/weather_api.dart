import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:space_scutum/features/weather/data/data_source/models/weather_model.dart';

part 'weather_api.g.dart';

@RestApi()
abstract class WeatherApi {
  factory WeatherApi(Dio dio, {String baseUrl}) = _WeatherApi;

  @GET('/weather')
  Future<WeatherModel> getCurrentWeather({
    @Query('lat') required double lat,
    @Query('lon') required double lon,
    @Query('appid') required String apiKey,
    @Query('units') String units = 'metric',
    @Query('lang') String lang = 'ua',
  });
}
