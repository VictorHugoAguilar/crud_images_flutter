import 'package:flutter/material.dart';
import 'package:formvalidator/src/models/producto_model.dart';
import 'package:formvalidator/src/providers/productos_providers.dart';
import 'package:formvalidator/src/utils/util.dart' as utils;

class ProductoPage extends StatefulWidget {
  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  final formkey = GlobalKey<FormState>();
  final scaffolkey = GlobalKey<ScaffoldState>();

  final productosProvider = new ProductosProvider();

  ProductoModel producto = new ProductoModel();
  bool _guardando = false;

  @override
  Widget build(BuildContext context) {
    final ProductoModel productoData =
        ModalRoute.of(context).settings.arguments;

    if (productoData != null) {
      producto = productoData;
    }

    return Scaffold(
      key: scaffolkey,
      appBar: AppBar(
        title: Text('Producto'),
        actions: [
          IconButton(
              icon: Icon(Icons.photo_size_select_actual), onPressed: () {}),
          IconButton(icon: Icon(Icons.camera_alt), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formkey,
            child: Column(
              children: <Widget>[
                _crearNombre(),
                _crearPrecio(),
                _crearDisponible(),
                _crearBoton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearNombre() {
    return TextFormField(
      initialValue: producto.titulo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Producto',
      ),
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese el nombre del producto';
        } else {
          return null;
        }
      },
      onSaved: (value) => {producto.titulo = value},
    );
  }

  Widget _crearPrecio() {
    return TextFormField(
      initialValue: producto.valor.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Precio',
      ),
      validator: (value) {
        if (utils.isNumeric(value)) {
          return null;
        } else {
          return 'Sólo números';
        }
      },
      onSaved: (value) => {producto.valor = double.parse(value)},
    );
  }

  Widget _crearBoton() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      color: Colors.deepPurple,
      textColor: Colors.white,
      label: Text('Guardar'),
      icon: Icon(Icons.save),
      onPressed: (_guardando) ? null : _submit,
    );
  }

  void _submit() {
    if (!formkey.currentState.validate()) {
      return;
    }

    formkey.currentState.save();

    setState(() {
      _guardando = true;
    });

    // print(producto.titulo);
    //  print(producto.valor);
    //  print(producto.disponible);

    if (producto.id == null) {
      productosProvider.crearProducto(producto);
      mostrarSnackbar('Registro guardado');
    } else {
      productosProvider.editarProducto(producto);
      mostrarSnackbar('Registro actualizado');
    }

    setState(() {
      _guardando = false;
    });

    Navigator.pop(context);
  }

  Widget _crearDisponible() {
    return SwitchListTile(
      value: producto.disponible,
      title: Text('Disponible'),
      activeColor: Colors.deepPurple,
      onChanged: (value) => setState(() {
        producto.disponible = value;
      }),
    );
  }

  void mostrarSnackbar(String mensaje) {
    final snackbar = SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 2000),
    );

    scaffolkey.currentState.showSnackBar(snackbar);
  }
}
