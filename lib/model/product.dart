import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class Product {
  String _id;
  String _nombre;
  String _code;
  String _descripcion;
  String _precio;
  String _stock;

  Product(this._id, this._nombre, this._code, this._descripcion, this._precio,
      this._stock);

  //mapa de archivos
  Product.map(dynamic obj) {
    this._nombre = obj['nombre'];
    this._code = obj['code'];
    this._descripcion = obj['descripcion'];
    this._precio = obj['precio'];
    this._stock = obj['stock'];
  }
  String get id => _id;
  String get nombre => _nombre;
  String get code => _code;
  String get descripcion => _descripcion;
  String get precio => _precio;
  String get stock => _stock;

//creacion de las tablas
  Product.fromSnapShop(DataSnapshot snapshot) {
    _id = snapshot.key;
    _nombre = snapshot.value['nombre'];
    _code = snapshot.value['code'];
    _descripcion = snapshot.value['descripcion'];
    _precio = snapshot.value['precio'];
    _stock = snapshot.value['stock'];
  }
}
