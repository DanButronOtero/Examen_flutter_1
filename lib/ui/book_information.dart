import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fbejemplo/model/book.dart';

class BookInformation extends StatefulWidget {
  final Book book;
  BookInformation(this.book);

  @override
  _BookInformationState createState() => _BookInformationState();
}

//instanciar bd
final bookReference = FirebaseDatabase.instance.reference().child('book');

class _BookInformationState extends State<BookInformation> {
  //
  List<Book> items;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Information'),
        backgroundColor: Colors.black,
      ),
      body: Container(
          height: 800.0,
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              Card(
                child: Center(
                  child: Image.network(widget.book.portada),
                ),
              ),
              Card(
                child: Center(
                  child: Column(
                    children: <Widget>[
                      new Text(
                        "Titulo : ${widget.book.titulo}",
                        style: TextStyle(fontSize: 18.0),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8.0),
                      ),
                      Divider(),
                    ],
                  ),
                ),
              ),
              Card(
                child: Center(
                  child: Column(
                    children: <Widget>[
                      new Text(
                        "Autor : ${widget.book.autor}",
                        style: TextStyle(fontSize: 18.0),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8.0),
                      ),
                      Divider(),
                    ],
                  ),
                ),
              ),
              Card(
                child: Center(
                  child: Column(
                    children: <Widget>[
                      new Text(
                        "Editorial : ${widget.book.editorial}",
                        style: TextStyle(fontSize: 18.0),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8.0),
                      ),
                      Divider(),
                    ],
                  ),
                ),
              ),
              Card(
                child: Center(
                  child: Column(
                    children: <Widget>[
                      new Text(
                        "Lugar de publicacion : ${widget.book.publicacion}",
                        style: TextStyle(fontSize: 18.0),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8.0),
                      ),
                      Divider(),
                    ],
                  ),
                ),
              ),
              Card(
                child: Center(
                  child: Column(
                    children: <Widget>[
                      new Text(
                        "Fecha de emision : ${widget.book.emision}",
                        style: TextStyle(fontSize: 18.0),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8.0),
                      ),
                      Divider(),
                    ],
                  ),
                ),
              ),
              Card(
                child: Center(
                  child: Column(
                    children: <Widget>[
                      new Text(
                        "Precio :\$ ${widget.book.precio}",
                        style: TextStyle(fontSize: 18.0),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8.0),
                      ),
                      Divider(),
                    ],
                  ),
                ),
              ),
              Card(
                child: Center(
                  child: Column(
                    children: <Widget>[
                      new Text(
                        "Prestamos : ${widget.book.prestamos}",
                        style: TextStyle(fontSize: 18.0),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8.0),
                      ),
                      Divider(),
                    ],
                  ),
                ),
              ),
              Card(
                child: Center(
                  child: Column(
                    children: <Widget>[
                      new Text(
                        "Disponibles : ${widget.book.disponibles}",
                        style: TextStyle(fontSize: 18.0),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8.0),
                      ),
                      Divider(),
                    ],
                  ),
                ),
              ),
              Card(
                child: Center(
                  child: Column(
                    children: <Widget>[
                      new Text(
                        "Portada : ${widget.book.portada}",
                        style: TextStyle(fontSize: 18.0),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8.0),
                      ),
                      Divider(),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
