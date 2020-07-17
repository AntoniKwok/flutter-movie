import 'package:json_annotation/json_annotation.dart';
import 'movie.dart';

part 'movie_response.g.dart';

@JsonSerializable()
class MovieResponse {
  int page;

  @JsonKey(name: 'total_results')
  int totalResults;

  @JsonKey(name: 'total_pages')
  int totalPages;

  @JsonKey(name: "results")
  List<Movie> results;

  MovieResponse({this.page, this.totalResults, this.totalPages, this.results});

  static fromJson(Map<String, dynamic> data) => _$MovieResponseFromJson(data);
  Map<String, dynamic> toJson() => _$MovieResponseToJson(this);

}