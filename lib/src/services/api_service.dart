import 'package:chopper/chopper.dart';
import 'package:flutter_app_intro/src/interceptor/header_interceptor.dart';
import 'package:flutter_app_intro/src/models/converter/movie_converter.dart';
import 'package:flutter_app_intro/src/models/movie_response.dart';

part 'api_service.chopper.dart';

@ChopperApi()
abstract class ApiService extends ChopperService {
  @Get(path: 'movie/popular')
  Future<Response<MovieResponse>> getAllMovies();

  @Get(path: 'tv/popular')
  Future<Response<MovieResponse>> getAllTvShows();

  static ApiService create() {
    final client = ChopperClient(
        baseUrl: 'https://api.themoviedb.org/3',
        interceptors: [HeaderInterceptor(), HttpLoggingInterceptor()],
        services: [
          _$ApiService(),
        ],
        converter: MovieConverter(),
        errorConverter: JsonConverter());
    return _$ApiService(client);
  }
}
