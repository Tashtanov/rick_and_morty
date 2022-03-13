import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:rick_and_morty/core/error/failure.dart';
import 'package:rick_and_morty/core/usescase/usescase.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entitie.dart';
import 'package:rick_and_morty/feature/domain/repository/person_repository.dart';

class SearchPerson extends UseCase<List<PersonEntity>,SearchPersonParams>{//этот класс просто будет поличать данные от репозитори
  final PersonRepository personRepository;

  SearchPerson(this.personRepository);
  //create method
  Future <Either<Failure,List<PersonEntity>>> call(SearchPersonParams params)async {
    return await personRepository.searchPerson(params.query);

  }

}
 class SearchPersonParams extends Equatable{
  final String query;

  const SearchPersonParams({required this.query});
  @override
  List<Object?> get props => [];
 }