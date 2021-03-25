import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:fbejemplo/ui/book_screen.dart';
import 'package:fbejemplo/ui/book_information.dart';
import 'package:fbejemplo/model/book.dart';
import 'package:fbejemplo/authentication.dart';

//stf + tab
class ListViewBook extends StatefulWidget {
  @override
  _ListViewBookState createState() => _ListViewBookState();
}
//instanciar bd de firebase y crear tabla

final bookReference = FirebaseDatabase.instance.reference().child('book');

class _ListViewBookState extends State<ListViewBook> {
  //instanciar un list
  List<Book> items;
  //agregar
  StreamSubscription<Event> _onBookAddedSubsripction;
  //cambiar
  StreamSubscription<Event> _onProducChangedSubsripction;
  final auth = FirebaseAuth.instance;

  //iniS + tab
  @override
  void initState() {
    super.initState();
    //listar items
    items = new List();
    _onBookAddedSubsripction = bookReference.onChildAdded.listen(_onBookAdded);

    _onProducChangedSubsripction =
        bookReference.onChildChanged.listen(_onBookUpdate);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _onBookAddedSubsripction.cancel();
    _onProducChangedSubsripction.cancel();
  }

  @override
  Widget build(BuildContext context2) {
    return MaterialApp(
      title: 'Book DB',
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.logout), onPressed: () => {auth.signOut()}),
          title: Text('Book information'),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        body: Center(
          child: ListView.builder(
            itemCount: items.length,
            padding: EdgeInsets.only(top: 12.0),
            itemBuilder: (context, position) {
              return Column(
                children: <Widget>[
                  Divider(
                    height: 7.0,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: ListTile(
                          title: Text(
                            '${items[position].titulo}',
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 21.0,
                            ),
                          ),
                          subtitle: Text(
                            '${items[position].autor}',
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 21.0,
                            ),
                          ),
                          leading: Column(
                            children: <Widget>[
                              CircleAvatar(
                                backgroundColor: Colors.amberAccent,
                                radius: 17.0,
                                child: Text(
                                  '${position + 1}',
                                  style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: 21.0,
                                  ),
                                ),
                              )
                            ],
                          ),
                          onTap: () => _navigateToBookInformation(
                              context, items[position]),
                        ),
                      ),
                      IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () =>
                              _deleteBook(context, items[position], position)),
                      IconButton(
                          icon: Icon(Icons.edit, color: Colors.blueAccent),
                          onPressed: () =>
                              _navigateToBook(context, items[position])),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Colors.deepOrangeAccent,
          onPressed: () => _createNewBook(context),
        ),
      ),
    );
  }

  void _onBookAdded(Event event) {
    setState(() {
      items.add(new Book.fromSnapShop(event.snapshot));
    });
  }

  void _onBookUpdate(Event event) {
    //consulta
    var oldBookValue =
        items.singleWhere((book) => book.id == event.snapshot.key);
    setState(() {
      items[items.indexOf(oldBookValue)] =
          new Book.fromSnapShop(event.snapshot);
    });
  }

  void _deleteBook(BuildContext context, Book book, int position) async {
    await bookReference.child(book.id).remove().then((_) {
      setState(() {
        items.removeAt(position);
        Navigator.of(context).pop();
      });
    });
  }

  void _navigateToBookInformation(BuildContext context, Book book) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BookScreen(book)),
    );
  }

  void _navigateToBook(BuildContext context, Book book) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BookInformation(book)),
    );
  }

  void _createNewBook(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => BookScreen(Book(
                null,
                '',
                '',
                '',
                '',
                '',
                '',
                '',
                '',
                '',
              ))),
    );
  }
}
