import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:gupae/data/data_source/public_seoul/public_toilet_data_source.dart';
import 'package:gupae/domain/repository/public/public_toilet_repository.dart';

import '../../model/public/public_toilet.dart';

class PublicToiletRepositoryImpl implements PublicToiletRepository {
  final PublicToiletDataSource _publicToiletDataSource;

  PublicToiletRepositoryImpl(this._publicToiletDataSource);

  @override
  Future<List<PublicToilet>> getPublicToilets() async {
    return _publicToiletDataSource.getPublicToilets();
  }
}