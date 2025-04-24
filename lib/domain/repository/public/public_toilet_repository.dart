import '../../model/public/public_toilet.dart';

abstract class PublicToiletRepository {
  Future<List<PublicToilet>> getPublicToilets();
}