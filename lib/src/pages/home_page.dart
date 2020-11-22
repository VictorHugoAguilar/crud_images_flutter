import 'package:flutter/material.dart';
import 'package:formvalidator/src/bloc/provider.dart';
// import 'package:formvalidator/src/bloc/provider.dart';
import 'package:formvalidator/src/models/producto_model.dart';
// import 'package:formvalidator/src/providers/productos_providers.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final productosProvider = new ProductosProvider();

  @override
  Widget build(BuildContext context) {
    // final bloc = Provider.of(context);

    final productosBloc = Provider.productosBloc(context);
    productosBloc.cargarProducto();

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: _crearListado(productosBloc),
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearListado(ProductosBloc productosBloc) {
    return StreamBuilder(
      stream: productosBloc.productosStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot) {
        if (snapshot.hasData) {
          final productos = snapshot.data;

          return ListView.builder(
            itemCount: productos.length,
            itemBuilder: (context, index) =>
                _crearItem(context, productosBloc, productos[index]),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _crearItem(BuildContext context, ProductosBloc productosBloc,
      ProductoModel producto) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (direccion) {
        // Borrar producto
        //  productosProvider.borrarProducto(producto.id);
        productosBloc.eliminarProducto(producto.id);
      },
      child: Card(
        child: Column(
          children: <Widget>[
            (producto.fotoUrl == null)
                ? Image(image: AssetImage('assets/img/no-image.png'))
                : FadeInImage(
                    placeholder: AssetImage('assets/img/jar-loading.gif'),
                    image: NetworkImage(producto.fotoUrl),
                    height: 300.0,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
            ListTile(
                title: Text('${producto.titulo} - ${producto.valor}'),
                subtitle: Text(producto.id),
                onTap: () => Navigator.pushNamed(context, 'producto',
                            arguments: producto)
                        .then((value) {
                      Future.delayed(const Duration(milliseconds: 500), () {
                        setState(() {});
                      });
                    })),
          ],
        ),
      ),
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
