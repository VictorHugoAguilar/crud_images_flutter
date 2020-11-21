import 'dart:io';
import 'package:formvalidator/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart';

import 'package:formvalidator/src/models/producto_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductosProvider {
  final String _url = 'https://flutter-varios-dc6aa.firebaseio.com';
  final _prefs = new PreferenciasUsuario();

  Future<bool> crearProducto(ProductoModel producto) async {
    final url = '$_url/productos.json?auth=${_prefs.token}';

    final response = await http.post(url, body: productoModelToJson(producto));

    final decodedData = json.decode(response.body);

    print(decodedData);

    return true;
  }

  Future<List<ProductoModel>> cargarProductos() async {
    final url = '$_url/productos.json?auth=${_prefs.token}';

    final response = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(response.body);
    final List<ProductoModel> productos = new List();

    if (decodedData == null) {
      return [];
    }

    decodedData.forEach((id, producto) {
      final prodTemp = ProductoModel.fromJson(producto);
      prodTemp.id = id;
      productos.add(prodTemp);
    });

    print(productos);
    return productos;
  }

  Future<int> borrarProducto(String id) async {
    final url = '$_url/productos/$id.json?auth=${_prefs.token}';

    final response = await http.delete(url);

    print(response.body);

    return 1;
  }

  Future<bool> editarProducto(ProductoModel producto) async {
    final url = '$_url/productos/${producto.id}.json';

    final response = await http.put(url, body: productoModelToJson(producto));

    final decodedData = json.decode(response.body);

    print(decodedData);

    return true;
  }

  Future<String> subirImagen(File image) async {
    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/lavaca/image/upload?upload_preset=eh5xvssw');

    final mineType = mime(image.path).split('/');

    final imageUploadRequest = http.MultipartRequest(
      'POST',
      url,
    );

    final file = await http.MultipartFile.fromPath(
      'file',
      image.path,
      contentType: MediaType(mineType[0], mineType[1]),
    );

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();

    final respuesta = await http.Response.fromStream(streamResponse);

    if (respuesta.statusCode != 200 && respuesta.statusCode != 201) {
      print('Algo salio mal');
      print(respuesta.body);
      return null;
    }

    final respData = json.decode(respuesta.body);

    return respData['secure_url'];
  }
}
