import '../../../domain/model/subway/subway_toilet.dart';

abstract class SubwayToiletDataSource {
  Future<List<SubwayToilet>> getSubwayToilets();
}