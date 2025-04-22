

import 'package:freezed_annotation/freezed_annotation.dart';

part 'public_toilet.freezed.dart';

part 'public_toilet.g.dart';

@freezed
abstract class PublicToilet with _$PublicToilet {
  const factory PublicToilet({
    required String name,
    required String address,
    required double lat,
    required double lng,
  }) = _PublicToilet;

  factory PublicToilet.fromJson(Map<String, Object?> json) => _$PublicToiletFromJson(json);
}