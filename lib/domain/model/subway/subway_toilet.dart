import 'package:freezed_annotation/freezed_annotation.dart';

part 'subway_toilet.freezed.dart';

part 'subway_toilet.g.dart';

@freezed
abstract class SubwayToilet with _$SubwayToilet {
  const factory SubwayToilet({
    @JsonKey(name: '역명') required String stationName,
    @JsonKey(name: '위도', fromJson: _toDouble) required double latitude,
    @JsonKey(name: '경도', fromJson: _toDouble) required double longitude,
    @JsonKey(name: '게이트 내외 구분', fromJson: _fromJsonIsOutsideGate, toJson: _toJsonIsOutsideGate)
    required bool isOutsideGate,
  }) = _SubwayToilet;

  factory SubwayToilet.fromJson(Map<String, Object?> json) => _$SubwayToiletFromJson(json);
}


double _toDouble(dynamic value) => double.tryParse(value.toString().trim()) ?? 0.0;

bool _fromJsonIsOutsideGate(String value) => value.trim() == '외부';
String _toJsonIsOutsideGate(bool value) => value ? '외부' : '내부';