import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fbejemplo/model/product.dart';

class ProductScreen extends StatefulWidget {
  final Product product;
  ProductScreen(this.product);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

final productReference = FirebaseDatabase.instance.reference().child('product');

class _ProductScreenState extends State<ProductScreen> {
  List<Product> items;

  TextEditingController _nombreController;
  TextEditingController _codeController;
  TextEditingController _descripcionController;
  TextEditingController _precioController;
  TextEditingController _stockController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nombreController = new TextEditingController(text: widget.product.nombre);
    _codeController = new TextEditingController(text: widget.product.code);
    _descripcionController =
        new TextEditingController(text: widget.product.descripcion);
    _precioController = new TextEditingController(text: widget.product.precio);
    _stockController = new TextEditingController(text: widget.product.stock);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Products DB'),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: Container(
        height: 570.0,
        padding: const EdgeInsets.all(20.0),
        child: Card(
          child: Center(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _nombreController,
                  style:
                      TextStyle(fontSize: 17.0, color: Colors.deepOrangeAccent),
                  decoration: InputDecoration(
                      icon: Icon(Icons.person), labelText: 'Nombre'),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                ),
                Divider(),
                TextField(
                  controller: _codeController,
                  style:
                      TextStyle(fontSize: 17.0, color: Colors.deepOrangeAccent),
                  decoration: InputDecoration(
                      icon: Icon(Icons.apps_outlined), labelText: 'Code'),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                ),
                Divider(),
                TextField(
                  controller: _descripcionController,
                  style:
                      TextStyle(fontSize: 17.0, color: Colors.deepOrangeAccent),
                  decoration: InputDecoration(
                      icon: Icon(Icons.list), labelText: 'Descripcion'),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                ),
                Divider(),
                TextField(
                  controller: _precioController,
                  style:
                      TextStyle(fontSize: 17.0, color: Colors.deepOrangeAccent),
                  decoration: InputDecoration(
                      icon: Icon(Icons.monetization_on_rounded),
                      labelText: 'Precio'),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                ),
                Divider(),
                TextField(
                  controller: _stockController,
                  style:
                      TextStyle(fontSize: 17.0, color: Colors.deepOrangeAccent),
                  decoration: InputDecoration(
                      icon: Icon(Icons.add_business), labelText: 'Stock'),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                ),
                Divider(),
                FlatButton(
                    onPressed: () {
                      if (widget.product.id != null) {
                        productReference.child(widget.product.id).set({
                          'nombre': _nombreController.text,
                          'code': _codeController.text,
                          'descripcion': _descripcionController.text,
                          'precio': _precioController.text,
                          'stock': _stockController.text,
                        }).then((_) {
                          Navigator.pop(context);
                        });
                      } else {
                        productReference.push().set({
                          'nombre': _nombreController.text,
                          'code': _codeController.text,
                          'descripcion': _descripcionController.text,
                          'precio': _precioController.text,
                          'stock': _stockController.text,
                        }).then((_) {
                          Navigator.pop(context);
                        });
                      }
                    },
                    child: (widget.product.id != null)
                        ? Text('Update')
                        : Text('Add')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
