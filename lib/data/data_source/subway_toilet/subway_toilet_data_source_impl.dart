
import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:gupae/data/data_source/subway_toilet/subway_toilet_data_source.dart';
import 'package:gupae/domain/model/subway/subway_toilet.dart';

class SubwayToiletDataSourceImpl implements SubwayToiletDataSource {


  @override
  Future<List<SubwayToilet>> getSubwayToilets() async {
    final subwayString = await rootBundle.loadString('assets/data/subway_seoul.json');
    final List<dynamic> subwayJson = jsonDecode(subwayString);
    return subwayJson.map((e) => SubwayToilet.fromJson(e)).toList();
  }


}