import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entitie.dart';
import 'package:rick_and_morty/feature/presentation/bloc/person_list_cubit/person_list_cubit.dart';
import 'package:rick_and_morty/feature/presentation/bloc/person_list_cubit/person_list_state.dart';
import 'package:rick_and_morty/feature/presentation/widgets/person_card_widget.dart';

class PersonsList extends StatelessWidget {
  final int page = -1;
  final scrollController = ScrollController();

   PersonsList({Key? key}) : super(key: key);

  void setupScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          BlocProvider.of<PersonListCubit>(context).loadPerson();
          //context.read<PersonListCubit>().loadPerson();

        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setupScrollController(context);
    return BlocBuilder<PersonListCubit, PersonState>(builder: (context, state) {
      List<PersonEntity> persons = [];
      bool isLoading = false;
      if (state is PersonLoading && state.isFirstFetch) {
        return _loadIndicator();
      } else if (state is PersonLoading) {
        persons = state.oldPersonList;
        isLoading = true;
      } else if (state is PersonLoaded) {
        persons = state.personsList;
      } else if (state is PersonError) {
        return Text(
          state.message,
          style: TextStyle(color: Colors.white, fontSize: 25),
        );
      }
      return ListView.separated(
          controller: scrollController,
          itemBuilder: (context, index) {
            if (persons.length > index) {
              return PersonCard(person: persons[index]);
            } else {
              Timer(const Duration(milliseconds: 30), () {
                scrollController
                    .jumpTo(scrollController.position.maxScrollExtent);
              });
              return _loadIndicator();
            }
          },
          separatorBuilder: (context, index) {
            return Divider(
              color: Colors.grey,
            );
          },
          itemCount: persons.length + (isLoading ? 1 : 0));
    });
  }

  Widget _loadIndicator() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
