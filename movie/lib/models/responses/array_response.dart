import 'package:equatable/equatable.dart';

import '../entities/movie.dart';

class ArrayResponse<T> extends Equatable {
  final int? page;
  final int? pageSize;
  final int? totalPages;
  final List<T>? results;

  ArrayResponse({
    this.page,
    this.pageSize,
    this.totalPages,
    this.results,
  });

  ArrayResponse<T> copyWith(
          {int? page,
          int? pageSize,
          int? total,
          int? totalPages,
          T? result,
          List<T>? results}) =>
      ArrayResponse<T>(
        page: page ?? this.page,
        pageSize: pageSize ?? this.pageSize,
        totalPages: totalPages ?? this.totalPages,
        results: results ?? this.results,
      );

  factory ArrayResponse.fromJson(Map<String, dynamic> json) {
    ArrayResponse<T> resultGeneric = ArrayResponse<T>(
      page: (json['page'] ?? 1) as int,
      pageSize: (json['page_size'] ?? 10) as int,
      totalPages: (json['total_pages'] ?? 1) as int,
    );
    if (json['results'] != null) {
      if (json['results'] is List) {
        return resultGeneric.copyWith(
          results: (json['results'] as List)
              .map((e) => _objectToFrom<T>(e))
              .toList(),
        );
      }
    }
    return resultGeneric;
  }

  static T _objectToFrom<T>(json) {
    switch (T.toString()) {
      case 'Movie':
        return Movie.fromJson(json) as T;
      default:
        return json as T;
    }
  }

  @override
  List<Object> get props => [
        page ?? 1,
        pageSize ?? 1,
        totalPages ?? 1,
        results ?? [],
      ];
}
