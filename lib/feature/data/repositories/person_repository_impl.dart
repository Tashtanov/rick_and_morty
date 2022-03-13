import 'package:dartz/dartz.dart';
import 'package:rick_and_morty/core/error/exception.dart';
import 'package:rick_and_morty/core/error/failure.dart';
import 'package:rick_and_morty/core/platform/network_info.dart';
import 'package:rick_and_morty/feature/data/datasources/person_local_data_source.dart';
import 'package:rick_and_morty/feature/data/datasources/remote_data_source.dart';
import 'package:rick_and_morty/feature/data/models/person_model.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entitie.dart';
import 'package:rick_and_morty/feature/domain/repository/person_repository.dart';

class PersonRepositoryImpl implements PersonRepository {
  final PersonRemoteDataSource remoteDataSource;
  final PersonLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PersonRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<PersonEntity>>> getAllpersons(int page) async {
    return _getPersons(() {
      return remoteDataSource.getAllPersons(page);
    });
    
  }

  @override
  Future<Either<Failure, List<PersonEntity>>> searchPerson(String query) async {
    return _getPersons(() {
      return remoteDataSource.searchPerson(query);
    });
  }

  Future <Either<Failure,List<PersonModel>>> _getPersons(Function () getPersons) async{
    if (await networkInfo.isConnected) {
      try {
        final remotePerson = await getPersons();
        localDataSource.personToCash(remotePerson);

        return Right(remotePerson);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final locationPerson = await localDataSource.getLastPersonsFromCash();
        return Right(locationPerson);
      } on CashException {
        return Left(CashFailure());
      }
    }

  }
}
