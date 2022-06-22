import 'package:flutter/material.dart';


import '../Classes/Book.dart';
import '../Database/crud.dart';
import '../Validation/BookValidator.dart';

class updateBook extends StatefulWidget {
  late Book book;
  updateBook(this.book);
  @override
  State<StatefulWidget> createState() {
    return _updateStudentState(book);
  }
}

class _updateStudentState extends State with BookValidationMixin {
  late Book book;
  _updateStudentState(this.book);
  var db = crud();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Update Book Informations"),
        ),
        body: Container(
          margin: EdgeInsets.all(10.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                BuildTextFormName(),
                BuildTextFormAuthor(),
                BuildTextFormTopic(),
                BuildTextFormPageNumber(),
                BuildSendButton()
              ],
            ),
          ),
        ));
  }

  Widget BuildTextFormName() {
    return TextFormField(
      initialValue: book.name,
      decoration:
      InputDecoration(labelText: "Book Name", hintText: "Name here.."),
      validator: validateBookName,
      onSaved: (String? value) {
        book.name = value!;
      },
    );
  }

  Widget BuildTextFormAuthor() {
    return TextFormField(
      initialValue:book.author ,
      decoration:
      InputDecoration(labelText: "Author Name", hintText: "Author here.."),
      validator: validateAuthorName,
      onSaved: (String? value) {
        book.author = value!;
      },
    );
  }

  Widget BuildTextFormTopic() {
    return TextFormField(
      initialValue: book.topic,
      decoration: InputDecoration(labelText: "Topic", hintText: "Topic here.."),
      validator: validateTopic,
      onSaved: (String? value) {
        book.topic = value!;
      },
    );
  }

  Widget BuildTextFormPageNumber() {
    return TextFormField(
      initialValue: book.pageNumber.toString(),
      decoration:
      InputDecoration(labelText: "Page Number", hintText: "Number here.."),
      validator: validatePageNumber,
      onSaved: (String? value) {
        book.pageNumber = int.parse(value!);
      },
    );
  }

  Widget BuildSendButton() {
    return ElevatedButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();
            update();
            Navigator.pop(context);
          }
        },
        child: Text("Save"));
  }

  void update() async {
    await db.updateBook(book);
    Navigator.pop(context,true);

  }
}
