import 'dart:io';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fbejemplo/model/book.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class BookScreen extends StatefulWidget {
  final Book book;
  BookScreen(this.book);

  @override
  _BookScreenState createState() => _BookScreenState();
}

final bookReference = FirebaseDatabase.instance.reference().child('book');

class _BookScreenState extends State<BookScreen> {
  List<Book> items;

  TextEditingController _tituloController;
  TextEditingController _autorController;
  TextEditingController _editorialController;
  TextEditingController _publicacionController;
  TextEditingController _emisionController;
  TextEditingController _precioController;
  TextEditingController _prestamosController;
  TextEditingController _disponiblesController;
  TextEditingController _portadaController;
  File _image;
  String url;
  void setURL(url) {
    this.url = url;
  }

  final picker = ImagePicker();
  firebase_storage.UploadTask _task;
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  firebase_storage.UploadTask uploadTask;
  firebase_storage.Reference ref;
  Future<firebase_storage.UploadTask> uploadFile(File file) async {
    if (file == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('No file was selected'),
      ));
      return null;
    }

    // Create a Reference to the file
    ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('playground')
        .child('/' + _tituloController.text.replaceAll("-", "") + '.jpg');

    final metadata = firebase_storage.SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': file.path});

    if (kIsWeb) {
      uploadTask = ref.putData(await file.readAsBytes(), metadata);
    } else {
      uploadTask = ref.putFile(File(file.path), metadata);
    }
    print(ref.getDownloadURL().then((value) => {setURL(value), print(value)}));
    return Future.value(uploadTask);
  }

  @override
  void initState() {
    firebase_storage.UploadTask _task;
    // TODO: implement initState
    super.initState();

    _tituloController = new TextEditingController(text: widget.book.titulo);
    _autorController = new TextEditingController(text: widget.book.autor);
    _editorialController =
        new TextEditingController(text: widget.book.editorial);
    _publicacionController =
        new TextEditingController(text: widget.book.publicacion);
    _emisionController = new TextEditingController(text: widget.book.emision);
    _precioController = new TextEditingController(text: widget.book.precio);
    _prestamosController =
        new TextEditingController(text: widget.book.prestamos);
    _disponiblesController =
        new TextEditingController(text: widget.book.disponibles);
    _portadaController = new TextEditingController(text: widget.book.portada);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Books DB'),
        backgroundColor: Colors.black,
      ),
      body: Container(
        height: 570.0,
        padding: const EdgeInsets.all(20.0),
        child: Card(
            child: ListView(
          children: [
            Center(
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _tituloController,
                    style: TextStyle(
                        fontSize: 17.0, color: Colors.deepOrangeAccent),
                    decoration: InputDecoration(
                        icon: Icon(Icons.book), labelText: 'Titulo'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                  ),
                  Divider(),
                  TextField(
                    controller: _autorController,
                    style: TextStyle(
                        fontSize: 17.0, color: Colors.deepOrangeAccent),
                    decoration: InputDecoration(
                        icon: Icon(Icons.person), labelText: 'Autor'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                  ),
                  Divider(),
                  TextField(
                    controller: _editorialController,
                    style: TextStyle(
                        fontSize: 17.0, color: Colors.deepOrangeAccent),
                    decoration: InputDecoration(
                        icon: Icon(Icons.person), labelText: 'Editorial'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                  ),
                  Divider(),
                  TextField(
                    controller: _publicacionController,
                    style: TextStyle(
                        fontSize: 17.0, color: Colors.deepOrangeAccent),
                    decoration: InputDecoration(
                        icon: Icon(Icons.place),
                        labelText: 'Lugar publicacion'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                  ),
                  Divider(),
                  TextField(
                    controller: _emisionController,
                    style: TextStyle(
                        fontSize: 17.0, color: Colors.deepOrangeAccent),
                    decoration: InputDecoration(
                        icon: Icon(Icons.date_range),
                        labelText: 'Fecha emision'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                  ),
                  Divider(),
                  TextField(
                    controller: _precioController,
                    style: TextStyle(
                        fontSize: 17.0, color: Colors.deepOrangeAccent),
                    decoration: InputDecoration(
                        icon: Icon(Icons.monetization_on), labelText: 'Precio'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                  ),
                  Divider(),
                  TextField(
                    controller: _prestamosController,
                    style: TextStyle(
                        fontSize: 17.0, color: Colors.deepOrangeAccent),
                    decoration: InputDecoration(
                        icon: Icon(Icons.assignment), labelText: 'Prestamos'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                  ),
                  Divider(),
                  TextField(
                    controller: _disponiblesController,
                    style: TextStyle(
                        fontSize: 17.0, color: Colors.deepOrangeAccent),
                    decoration: InputDecoration(
                        icon: Icon(Icons.assignment),
                        labelText: 'Libros disponibles'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                  ),
                  Divider(),
                  Divider(),
                  IconButton(icon: Icon(Icons.image), onPressed: getImage),
                  ElevatedButton(
                      child: Text('subir'),
                      onPressed: () => {
                            uploadFile(_image),
                          }),
                  FlatButton(
                      onPressed: () {
                        if (widget.book.id != null) {
                          bookReference.child(widget.book.id).set({
                            'titulo': _tituloController.text,
                            'autor': _autorController.text,
                            'editorial': _editorialController.text,
                            'publicacion': _publicacionController.text,
                            'emision': _emisionController.text,
                            'precio': _precioController.text,
                            'prestamos': _prestamosController.text,
                            'disponibles': _disponiblesController.text,
                            'portada': url,
                          }).then((_) {
                            Navigator.pop(context);
                          });
                        } else {
                          bookReference.push().set({
                            'titulo': _tituloController.text,
                            'autor': _autorController.text,
                            'editorial': _editorialController.text,
                            'publicacion': _publicacionController.text,
                            'emision': _emisionController.text,
                            'precio': _precioController.text,
                            'prestamos': _prestamosController.text,
                            'disponibles': _disponiblesController.text,
                            'portada': url,
                          }).then((_) {
                            Navigator.pop(context);
                          });
                        }
                      },
                      child: (widget.book.id != null)
                          ? Text('Update')
                          : Text('Add')),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}
