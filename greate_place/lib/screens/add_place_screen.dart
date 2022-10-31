import 'package:flutter/material.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = 'add-place';
  const AddPlaceScreen({super.key});

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add a New place"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(labelText: "Title"),
                      controller: _titleController,
                    ),
                    TextField(),
                    TextField(),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(
                Icons.add,
                color: Colors.black,
              ),
              label: Text(
                "Add Place",
                style: TextStyle(color: Colors.black),
              ),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  elevation: 0,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape:
                      RoundedRectangleBorder(borderRadius: BorderRadius.zero)))
        ],
      ),
    );
  }
}
