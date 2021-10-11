import 'package:flutter/material.dart';

class AddEditNote extends StatelessWidget {
  const AddEditNote({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Note"),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: BuildEditNote(),
    );
  }
}

class BuildEditNote extends StatefulWidget {
  const BuildEditNote({Key? key}) : super(key: key);

  @override
  _BuildEditNoteState createState() => _BuildEditNoteState();
}

class _BuildEditNoteState extends State<BuildEditNote> {
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        child: Column(
          children: [
            TextField(
              onChanged: (value) => {},
              maxLength: 40,
              decoration: InputDecoration(
                hintText: "Title",
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              onChanged: (value) => {},
              maxLength: 30000,
              textInputAction: TextInputAction.newline,
              keyboardType: TextInputType.multiline,
              maxLines: 1000,
              decoration: InputDecoration(
                hintText: "Content",
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
