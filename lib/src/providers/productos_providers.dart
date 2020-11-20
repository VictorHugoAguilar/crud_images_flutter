import 'package:formvalidator/src/models/producto_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductosProvider {
  final String _url = 'https://flutter-varios-dc6aa.firebaseio.com';

  Future<bool> crearProducto(ProductoModel producto) async {
    final url = '$_url/productos.json';

    final response = await http.post(url, body: productoModelToJson(producto));

    final decodedData = json.decode(response.body);

    print(decodedData);

    return true;
  }

  Future<List<ProductoModel>> cargarProductos() async {
    final url = '$_url/productos.json';

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
    final url = '$_url/productos/$id.json';

    final response = await http.delete(url);

    print(response.body);
  }

  Future<bool> editarProducto(ProductoModel producto) async {
    final url = '$_url/productos/${producto.id}.json';

    final response = await http.put(url, body: productoModelToJson(producto));

    final decodedData = json.decode(response.body);

    print(decodedData);

    return true;
  }
}
