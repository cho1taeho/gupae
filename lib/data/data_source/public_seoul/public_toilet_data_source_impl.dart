

import 'dart:convert';
import 'dart:io';

import 'package:gupae/data/data_source/public_seoul/public_toilet_data_source.dart';
import 'package:gupae/domain/model/public/public_toilet.dart';

class PublicToiletDataSourceImpl implements PublicToiletDataSource {

  @override
  Future<List<PublicToilet>> getPublicToilets() async {
    final publicFile = File(r'assets/data/public_seoul.json');
    final publicString = await publicFile.readAsString();
    final List<dynamic> publicJson = jsonDecode(publicString);

    return publicJson.map((e) => PublicToilet.fromJson(e)).toList();
  }
}