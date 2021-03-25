import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class Book {
  String _id;
  String _titulo;
  String _autor;
  String _editorial;
  //=>lugar publicacion
  String _publicacion;
  //=>fecha emision
  String _emision;
  String _precio;
  //=>prestamos totales
  String _prestamos;
  //=>prestamos disponibles
  String _disponibles;
  //portada
  String _portada;

  Book(
      this._id,
      this._titulo,
      this._autor,
      this._editorial,
      this._publicacion,
      this._emision,
      this._precio,
      this._prestamos,
      this._disponibles,
      this._portada);

  //mapa de archivos
  Book.map(dynamic obj) {
    this._titulo = obj['titulo'];
    this._autor = obj['autor'];
    this._editorial = obj['editorial'];
    this._publicacion = obj['publicacion'];
    this._emision = obj['emision'];
    this._precio = obj['precio'];
    this._prestamos = obj['prestamos'];
    this._disponibles = obj['disponibles'];
    this._portada = obj['portada'];
  }
  String get id => _id;
  String get titulo => _titulo;
  String get autor => _autor;
  String get editorial => _editorial;
  String get publicacion => _publicacion;
  String get emision => _emision;
  String get precio => _precio;
  String get prestamos => _prestamos;
  String get disponibles => _disponibles;
  String get portada => _portada;

//creacion de las tablas
  Book.fromSnapShop(DataSnapshot snapshot) {
    _id = snapshot.key;
    _titulo = snapshot.value['titulo'];
    _autor = snapshot.value['autor'];
    _editorial = snapshot.value['editorial'];
    _publicacion = snapshot.value['publicacion'];
    _emision = snapshot.value['emision'];
    _precio = snapshot.value['precio'];
    _prestamos = snapshot.value['prestamos'];
    _disponibles = snapshot.value['disponibles'];
    _portada = snapshot.value['portada'];
  }
}
