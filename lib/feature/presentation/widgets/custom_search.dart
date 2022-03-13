import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entitie.dart';
import 'package:rick_and_morty/feature/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:rick_and_morty/feature/presentation/bloc/search_bloc/search_event.dart';
import 'package:rick_and_morty/feature/presentation/bloc/search_bloc/search_state.dart';
import 'package:rick_and_morty/feature/presentation/widgets/search_result.dart';

class CustomSearchDelegate extends SearchDelegate {
  CustomSearchDelegate() :super(searchFieldLabel: 'Search for Characters...');

  final _suggestions = ['Rick', 'Morty', 'Summer ', 'Beth', 'Jerry'];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () {
        query = '';
        showSuggestions(context);
      }, icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: () {
      close(context, null);
    }, icon: Icon(Icons.arrow_back_ios_outlined));
  }

  @override
  Widget buildResults(BuildContext context) {
    context.read<PersonSearchBloc>().add(SearchPersons(query));
    return BlocBuilder<PersonSearchBloc, PersonSearchState>(
        builder: (context, state) {
          if (state is PersonSearchLoading) {

            return Container(child: CircularProgressIndicator(),);
          } else if (state is PersonSearchLoaded) {
            final person = state.persons;
            if (person.isEmpty ) {
              return _showErrorText('No Characters found');
              
            }  

            return Container(child: ListView.builder(
                itemCount: person.isNotEmpty ? person.length : 0,
                itemBuilder: (context, index) {
                  PersonEntity result = person[index];
                  return SearchResult(personResult: result,);
                }),);
          }
          else if (state is PersonSearchErrorState) {
            return _showErrorText(state.message);
          }
          else {
            return Center(
              child: Icon(Icons.now_wallpaper),
            );
          }
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isNotEmpty) {
      return Container();
    }
    return GestureDetector(
      onTap: () {
        query = _suggestions.first;
      },
      child: ListView.separated(
          padding: EdgeInsets.all(15), itemBuilder: (context, index) {
        return Text(_suggestions[index],
          style: TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.w400),);
      }, separatorBuilder: (context, index) {
        return Divider();
      }, itemCount: _suggestions.length),
    );
  }

  Widget _showErrorText(String errorText) {
    return Container(color: Colors.green,
      child: Center(child: Text(errorText,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),),);
  }

}