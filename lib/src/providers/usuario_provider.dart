import 'dart:convert';

import 'package:formvalidator/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;

class UsuarioProvider {
  final String _firebaseToken = 'AIzaSyDGP7zY9eoHeLgmbToBP8G904b6loaUY5Y';
  final _prefs = new PreferenciasUsuario();

  Future<Map<String, dynamic>> login(String email, String password) async {
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final respuesta = await http.post(
      'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebaseToken',
      body: json.encode(authData),
    );

    Map<String, dynamic> decodeRespuesta = json.decode(respuesta.body);

    print(decodeRespuesta);

    if (decodeRespuesta.containsKey('idToken')) {
      // Guardar el token en el storage
      _prefs.token = decodeRespuesta['idToken'];
      return {'ok': true, 'token': decodeRespuesta['idToken']};
    } else {
      return {'ok': false, 'mensaje': decodeRespuesta['error']['message']};
    }
  }

  Future<Map<String, dynamic>> nuevoUsuario(
      String email, String password) async {
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final respuesta = await http.post(
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken',
      body: json.encode(authData),
    );

    Map<String, dynamic> decodeRespuesta = json.decode(respuesta.body);

    print(decodeRespuesta);

    if (decodeRespuesta.containsKey('idToken')) {
      // Guardar el token en el storage
      _prefs.token = decodeRespuesta['idToken'];
      return {'ok': true, 'token': decodeRespuesta['idToken']};
    } else {
      return {'ok': false, 'mensaje': decodeRespuesta['error']['message']};
    }
  }
}
