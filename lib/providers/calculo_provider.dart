import 'package:flutter/material.dart';
import 'package:web_calculator/enities/persona.dart';

class CalculoProvider extends ChangeNotifier {
   List<Persona> _listaDePersonas = [];

  List<Persona> get listaDePersonas => _listaDePersonas;

  void recibirPersonas(List<Persona> lista) {
    _listaDePersonas = List<Persona>.from(lista);
  }

  // void agregarPersona(String nombre, double montoGastado) {
  //   final nuevaPersona = Persona(nombre, montoGastado);
  //   _listaDePersonas.add(nuevaPersona);
  // }
}
