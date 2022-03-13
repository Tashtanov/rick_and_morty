import 'dart:convert';

import 'package:rick_and_morty/core/error/exception.dart';
import 'package:rick_and_morty/feature/data/models/person_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PersonLocalDataSource {
  Future<List<PersonModel>>
      getLastPersonsFromCash(); //to return Cash data sources
  Future<void> personToCash(List<PersonModel> persons);
}

const CASHED_PERSONS_LIST = 'CASHED_PERSONS_LIST';

class PersonLocalDataSourceImpl implements PersonLocalDataSource {
  final SharedPreferences sharedPreferences;

  PersonLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<PersonModel>> getLastPersonsFromCash() {
    final jsonPersonList = sharedPreferences.getStringList(CASHED_PERSONS_LIST);
    if (jsonPersonList != null) {
      print('persons to write cash ${jsonPersonList.length}');
      return Future.value(jsonPersonList
          .map((person) => PersonModel.fromJson(json.decode(person)))
          .toList());
    } else {
      throw CashException();
    }
  }

  @override
  Future<List<String>> personToCash(List<PersonModel> persons) {
    final List<String> jsonPersonList =
        persons.map((person) => json.encode(person.toJson())).toList();


    sharedPreferences.setStringList(CASHED_PERSONS_LIST, jsonPersonList);
    print('persons to write cash ${jsonPersonList.length}');
    return Future.value(jsonPersonList);
  }
}
