import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entitie.dart';

abstract class PersonSearchState extends Equatable {
  const PersonSearchState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class PersonEmptyState extends PersonSearchState {}

class PersonSearchLoading extends PersonSearchState {}

class PersonSearchLoaded extends PersonSearchState {
  final List<PersonEntity> persons;

  PersonSearchLoaded({ required this.persons});
  @override
  // TODO: implement props
  List<Object?> get props => [persons];
}

class PersonSearchErrorState extends PersonSearchState {
    final String message;

  PersonSearchErrorState({required this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
