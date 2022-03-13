 import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entitie.dart';

abstract class PersonState extends Equatable{
  const PersonState();
  @override
  // TODO: implement props
  List<Object?> get props => [];


}
 class PersonLoading extends  PersonState{
  final List <PersonEntity> oldPersonList;
  final bool isFirstFetch;

  const PersonLoading(this.oldPersonList, {this.isFirstFetch=false });
  @override
  // TODO: implement props
  List<Object> get props => [oldPersonList];


}
 class PersonEmpty extends PersonState{
  @override
  // TODO: implement props
  List<Object> get props => [];

 }
 class PersonLoaded extends PersonState{
  final List<PersonEntity> personsList;

  const PersonLoaded(this.personsList);
  @override
  // TODO: implement props
  List<Object> get props => [personsList];
 }
 class PersonError extends PersonState{
   final String message;

  const PersonError({ required this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [message];
 }