
import 'dart:convert';
import 'dart:io';

import 'package:gupae/data/data_source/subway_toilet/subway_toilet_data_source.dart';
import 'package:gupae/domain/model/subway/subway_toilet.dart';

class SubwayToiletDataSourceImpl implements SubwayToiletDataSource {


  @override
  Future<List<SubwayToilet>> getSubwayToilets() async {
    final subwayFile = File(r'assets/data/subway_seoul.json');
    final subwayString = await subwayFile.readAsString();
    final List<dynamic> subwayJson = jsonDecode(subwayString);


    return subwayJson.map((e) => SubwayToilet.fromJson(e)).toList();
  }

}