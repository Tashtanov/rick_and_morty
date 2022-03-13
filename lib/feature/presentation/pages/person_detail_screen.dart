import 'package:flutter/material.dart';
import 'package:rick_and_morty/common/app_colors.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entitie.dart';
import 'package:rick_and_morty/feature/presentation/widgets/person_cached_imege.dart';

class PersonDetailScreen extends StatelessWidget {
  final PersonEntity person;

  const PersonDetailScreen({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Character'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                person.name,
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: PersonCachedImage(
                  width: 260,
                  height: 260,
                  imageUrl: person.image,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 15,
                    height: 15,

                    decoration: BoxDecoration(
                        color: person.status == 'Alive'
                            ? Colors.green
                            : Colors.red,
                      borderRadius: BorderRadius.circular(8)
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(person.status,style: TextStyle(color: Colors.white,fontSize: 15),)
                ],
              ),
              SizedBox(
                height: 15,
              ),
              ...buildText('Gender:', person.gender),
              ...buildText('Number of episodes:', person.episode.length.toString()),
              ...buildText('Species:', person.species),
              ...buildText('Last known episode:', person.location.name),
              ...buildText('Origin:', person.origin.name),
              ...buildText('Was created:', person.created.toString()),
            ],
          ),
        ),
      ),
    );
  }
  List<Widget> buildText(String text, String value){
    return [

      Text(text,style: TextStyle(color: AppColors.geryColor),),
      SizedBox(
        height: 5,
      ),
      Text(value,style: TextStyle(color: Colors.white),),
      SizedBox(
        height: 12,
      ),



  ];
}
}
