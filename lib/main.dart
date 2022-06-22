

import 'package:flutter/material.dart';
import 'Classes/Book.dart';
import 'Database/crud.dart';
import 'Screens/AddBook.dart';
import 'Screens/DetailOfBook.dart';
enum popup {About,Help}

void AboutDialog(BuildContext context) {
  var uyari = AlertDialog(
    title: Text("by Erensz.."),
     content:Text("ver :: 0.3") ,

  );

  showDialog(context: context, builder: (BuildContext context) => uyari);
}
void HelpDialog(BuildContext context) {
  var uyari = AlertDialog(
    title: Text("If you wanna add a new book just click add buton."),
    content: Text("And for see book details and operations just click the book card."),

  );

  showDialog(context: context, builder: (BuildContext context) => uyari);
}

void main() {
  runApp(MaterialApp(home: begin()));
}

class begin extends StatefulWidget {
  @override
  State<begin> createState() => _beginState();
}

class _beginState extends State<begin> {
  var db = crud();
  late List<Book> books;
  int bookCount = 0;
  int lid = 1;
  
  void fillTable() async {
    var booksfuture = db.getBooks();
    booksfuture.then((data) {
      setState(() {
        this.books = data;
        bookCount = books.length;
        if(bookCount!=0){
          lid = books[bookCount-1].id;
        }
      });

    });
  }
  
  void initState() {
    fillTable();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("LIBRARY SYSTEM"),
      actions: [
        PopupMenuButton<popup >(
          onSelected: selectProcess,
          itemBuilder: (BuildContext context) =>  <PopupMenuEntry<popup>>[
            PopupMenuItem(child: Text("Help"),value: popup.Help),
            PopupMenuItem(child: Text("About"),value: popup.About)
          ]
        )]),
      body: buildBody(context),

    );
  }

  buildBody(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
              itemCount: bookCount,
              itemBuilder: (BuildContext context, int i) {
                return Card(
                    color: Colors.blueGrey,
                    elevation: 2.0,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.redAccent,
                        child: const Text('📖'),
                      ),
                      title: Text(books[i].name),
                      subtitle: Text(books[i].author),
                      trailing: Icon(Icons.book_outlined),
                      onTap: () async {
                        bool result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => detailBook(books[i])));
                        if (result != null) {
                          if (result) {
                            fillTable();
                          }
                        }

                      },
                    ));
              }),
        ),
        Row(
          children: [

                  /*onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => updateBook(selectedBook)));
                  },*/
            Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: RaisedButton(
                  color: Colors.amberAccent,
                  child: Row(
                    children: [
                      Flexible(
                          fit: FlexFit.tight,
                          flex: 3,
                          child:SizedBox(width: 5.0)),
                      Flexible(
                          fit: FlexFit.tight,
                          flex: 1,
                          child:Icon(Icons.add_box)) ,
                     Flexible(
                         fit:FlexFit.tight,
                         flex: 1,
                         child: Text("Add")),
                      Flexible(
                          fit: FlexFit.tight,
                          flex: 3,
                          child:SizedBox(width: 5.0))
                    ],
                  ),
                  onPressed: () async {
                    bool result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => addBook(lid)));
                    if (result != null) {
                      if (result) {
                        fillTable();
                      }
                    }
                  },
                )),

          ],
        )
      ],
    );
  }

  void selectProcess(popup value) {
    switch(value){
      case popup.About:
        AboutDialog(context);
        break;
      case popup.Help:
        HelpDialog(context);
        break;

    }


  }
}
