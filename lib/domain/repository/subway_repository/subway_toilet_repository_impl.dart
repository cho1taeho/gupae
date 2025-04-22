
import 'package:gupae/domain/model/subway/subway_toilet.dart';
import 'package:gupae/domain/repository/subway_repository/subway_toilet_repository.dart';

import '../../../data/data_source/subway_toilet/subway_toilet_data_source.dart';

class SubwayToiletRepositoryImpl implements SubwayToiletRepository {
  final SubwayToiletDataSource _subwayDataSource;


  SubwayToiletRepositoryImpl(this._subwayDataSource);

  @override
  Future<List<SubwayToilet>> getSubwayToilets() {
    return _subwayDataSource.getSubwayToilets();
  }

}