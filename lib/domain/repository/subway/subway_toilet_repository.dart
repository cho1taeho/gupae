import '../../model/subway/subway_toilet.dart';

abstract class SubwayToiletRepository {
  Future<List<SubwayToilet>> getSubwayToilets();
}
