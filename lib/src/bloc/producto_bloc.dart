import 'dart:io';

import 'package:formvalidator/src/providers/productos_providers.dart';
import 'package:rxdart/rxdart.dart';

import 'package:formvalidator/src/models/producto_model.dart';

class ProductosBloc {
  final _productosController = new BehaviorSubject<List<ProductoModel>>();
  final _cargandoController = new BehaviorSubject<bool>();

  final _productosProvider = new ProductosProvider();

  Stream<List<ProductoModel>> get productosStream =>
      _productosController.stream;
  Stream<bool> get cargando => _cargandoController.stream;

  void cargarProducto() async {
    final productos = await _productosProvider.cargarProductos();
    _productosController.sink.add(productos);
  }

  void agregarProducto(ProductoModel productoModel) async {
    _cargandoController.sink.add(true);
    await _productosProvider.crearProducto(productoModel);
    _cargandoController.sink.add(false);
  }

  Future<String> subirFoto(File foto) async {
    _cargandoController.sink.add(true);
    final fotoUrl = await _productosProvider.subirImagen(foto);
    _cargandoController.sink.add(false);
    return fotoUrl;
  }

  void editarProducto(ProductoModel productoModel) async {
    _cargandoController.sink.add(true);
    await _productosProvider.editarProducto(productoModel);
    _cargandoController.sink.add(false);
  }

  void eliminarProducto(String id) async {
    await _productosProvider.borrarProducto(id);
  }

  dispose() {
    _productosController?.close();
    _cargandoController?.close();
  }
}
