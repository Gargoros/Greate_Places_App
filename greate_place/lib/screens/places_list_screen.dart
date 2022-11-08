import 'package:flutter/material.dart';
import 'package:greate_place/providers/great_places.dart';
import 'package:greate_place/screens/add_place_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Your places"),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
                },
                icon: Icon(Icons.add))
          ],
        ),
        body: Consumer<GreatPlaces>(
            child: Center(
              child: Text("Got no places yet, start adding some!"),
            ),
            builder: (context, greatPlace, ch) => greatPlace.items.length <= 0
                ? ch!
                : ListView.builder(
                    itemCount: greatPlace.items.length,
                    itemBuilder: (context, index) => ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            FileImage(greatPlace.items[index].image),
                      ),
                      title: Text(greatPlace.items[index].title),
                      onTap: () {},
                    ),
                  )));
  }
}
