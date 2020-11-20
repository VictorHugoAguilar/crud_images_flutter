import 'package:flutter/material.dart';
import 'package:formvalidator/src/bloc/provider.dart';
import 'package:formvalidator/src/models/producto_model.dart';
import 'package:formvalidator/src/providers/productos_providers.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final productosProvider = new ProductosProvider();

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: _crearListado(),
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearListado() {
    return FutureBuilder(
      future: productosProvider.cargarProductos(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          final productos = snapshot.data;

          return ListView.builder(
            itemCount: productos.length,
            itemBuilder: (context, index) =>
                _crearItem(context, productos[index]),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _crearItem(BuildContext context, ProductoModel producto) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (direccion) {
        // Borrar producto
        productosProvider.borrarProducto(producto.id);
      },
      child: ListTile(
          title: Text('${producto.titulo} - ${producto.valor}'),
          subtitle: Text(producto.id),
          onTap: () =>
              Navigator.pushNamed(context, 'producto', arguments: producto)
                  .then((value) {
                Future.delayed(const Duration(milliseconds: 500), () {
                  setState(() {});
                });
              })),
    );
  }

  Widget _crearBoton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Colors.deepPurple,
      onPressed: () => Navigator.pushNamed(context, 'producto').then((value) {
        Future.delayed(const Duration(milliseconds: 500), () {
          setState(() {});
        });
      }),
    );
  }
}
