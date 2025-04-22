
import 'package:gupae/domain/model/public/public_toilet.dart';

abstract interface class PublicToiletDataSource {
  Future<List<PublicToilet>> getPublicToilets();
}