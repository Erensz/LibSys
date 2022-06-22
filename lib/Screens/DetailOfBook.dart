import 'package:flutter/material.dart';
import '../Classes/Book.dart';
import '../Database/crud.dart';
import 'UpdateBook.dart';

class detailBook extends StatefulWidget{
  @override
    late Book book;
    detailBook(this.book);
    @override
    State<StatefulWidget> createState() {
      return _detailBook(book);
    }



}

class _detailBook extends State{
  late Book book;
  _detailBook(this.book);
  var db = crud();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text("Detail of  '${book.name}'",textScaleFactor: 0.8),
          actions: [
            IconButton(onPressed: onUpdate, icon: Icon(Icons.wifi_protected_setup_rounded,color: Colors.white,)),
            IconButton(onPressed: onDelete, icon: Icon(Icons.delete_forever,color: Colors.white))

          ],

    ),
    body: Container(
    margin: EdgeInsets.all(10.0),
    child: Form(
    child: Column(
    children: [
      Flexible(child:Container(
            child: Image.asset("lib/images/book.jpeg"),),
          fit: FlexFit.tight,flex:4),
      Flexible(child:BuildTextFormName(),fit: FlexFit.tight,flex:1),
      Flexible(child:BuildTextFormAuthor(),fit: FlexFit.tight,flex:1),
      Flexible(child:BuildTextFormTopic(),fit: FlexFit.tight,flex:1),
      Flexible(child:BuildTextFormPageNumber(),fit: FlexFit.tight,flex:1),




    ],
    ),
    ),
    ));
  }
  Widget BuildTextFormName() {
    return TextFormField(
        initialValue: book.name,
      decoration:
      InputDecoration(prefixIcon: Icon(Icons.book),labelText: "Book Name",border: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue))),
    readOnly: true,

    );
  }

  Widget BuildTextFormAuthor() {
    return TextFormField(
        initialValue: book.author,
      decoration:
      InputDecoration(prefixIcon: Icon(Icons.person),labelText: "Author Name",border: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue))),
    readOnly: true,
    );
  }

  Widget BuildTextFormTopic() {
    return TextFormField(
        initialValue: book.topic,
      decoration: InputDecoration(prefixIcon: Icon(Icons.topic),labelText: "Topic",border: OutlineInputBorder(borderSide: BorderSide(color: Colors.indigo))),
    readOnly: true,
    );
  }

  Widget BuildTextFormPageNumber() {
    return TextFormField(
      initialValue: book.pageNumber.toString(),
      decoration:
      InputDecoration(prefixIcon: Icon(Icons.pages_outlined),labelText: "Page Number",border: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue))),
      readOnly: true,

    );
  }

  void onUpdate() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => updateBook(book)));
  }

  void onDelete() async {
  await db.deleteBook(book.id);
  Navigator.pop(context,true);
  }
}