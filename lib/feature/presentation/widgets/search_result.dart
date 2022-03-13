import 'package:flutter/material.dart';
import 'package:rick_and_morty/common/app_colors.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entitie.dart';
import 'package:rick_and_morty/feature/presentation/pages/person_detail_screen.dart';
import 'package:rick_and_morty/feature/presentation/widgets/person_cached_imege.dart';
import 'package:rick_and_morty/feature/presentation/widgets/person_card_widget.dart';

class SearchResult extends StatelessWidget {
  final PersonEntity personResult;

  const SearchResult({Key? key, required this.personResult}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>PersonDetailScreen(person: personResult)));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 300,
            width: double.infinity,
            child: PersonCachedImage(
              imageUrl: personResult.image,
            ),),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                personResult.name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                personResult.location.name,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppColors.geryColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}
