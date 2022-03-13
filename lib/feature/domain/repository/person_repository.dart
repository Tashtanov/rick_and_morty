import 'package:dartz/dartz.dart';
import 'package:rick_and_morty/core/error/failure.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entitie.dart';

abstract class PersonRepository{ //Этот класс определит контракт для репозитори
  Future<Either<Failure,List<PersonEntity>>>getAllpersons(int page);
  Future<Either<Failure,List<PersonEntity>>>searchPerson(String query);

}