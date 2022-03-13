import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:rick_and_morty/core/error/failure.dart';
import 'package:rick_and_morty/core/usescase/usescase.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entitie.dart';
import 'package:rick_and_morty/feature/domain/repository/person_repository.dart';

class GetAllPersons extends UseCase<List<PersonEntity>, PagePersonParams> {
  //этот класс просто будет поличать данные от репозитори
  final PersonRepository personRepository;

  GetAllPersons(this.personRepository);

  //create method
  Future<Either<Failure, List<PersonEntity>>> call(
      PagePersonParams params) async {
    return await personRepository.getAllpersons(params.page);
  }
}

class PagePersonParams extends Equatable {
  final int page;

  const PagePersonParams({required this.page});

  @override
  // TODO: implement props
  List<Object?> get props => [page];
}
