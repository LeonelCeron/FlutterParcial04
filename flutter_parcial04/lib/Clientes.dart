import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class Clientes extends StatefulWidget {
  const Clientes({super.key});

  @override
  State<Clientes> createState() => _ClientesState();
}

class _ClientesState extends State<Clientes> {
  // text fields' controllers
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _precioController = TextEditingController();

  final CollectionReference _productos =
      FirebaseFirestore.instance.collection('clientes');
//insertar producto
  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nombreController,
                  decoration: const InputDecoration(labelText: 'Nombre:'),
                ),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: _precioController,
                  decoration: const InputDecoration(
                    labelText: 'Precio',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Crear'),
                  onPressed: () async {
                    final String nombre = _nombreController.text;
                    final double? precio =
                        double.tryParse(_precioController.text);
                    if (precio != null) {
                      await _productos
                          .add({"nombre": nombre, "precio": precio});

                      _nombreController.text = '';
                      _precioController.text = '';
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }
//actualizar poducto

  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _nombreController.text = documentSnapshot['nombre'].toString();
      _precioController.text = documentSnapshot['precio'].toString();
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nombreController,
                  decoration: const InputDecoration(labelText: 'Nombre'),
                ),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: _precioController,
                  decoration: const InputDecoration(
                    labelText: 'Precio',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Update'),
                  onPressed: () async {
                    final String nombre = _nombreController.text;
                    final double? precio =
                        double.tryParse(_precioController.text);
                    if (precio != null) {
                      await _productos
                          .doc(documentSnapshot!.id)
                          .update({"nombre": nombre, "precio": precio});
                      _nombreController.text = '';
                      _precioController.text = '';
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('El producto fue actualizado correctamente')));
                    }
                  },
                )
              ],
            ),
          );
        });
  }

//borrar productos
  Future<void> _delete(String productId) async {
    await _productos.doc(productId).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('El producto fue eliminado correctamente')));
  }

//Listar Clientes
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Firebase Firestore')),
        ),
        body: StreamBuilder(
          stream: _productos.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];
                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      title: Text('Cédula: '+documentSnapshot['cedula'].toString() + '\n'+
                      'Nombre: ' + documentSnapshot['nombre'].toString()),
                      subtitle: Text('Apellido: '+documentSnapshot['apellido'].toString() + '\n'+
                      'Fecha nacimiento: ' +documentSnapshot['fecha_nacimiento'].toString()+ '\n'+
                      'Sexo: ' +documentSnapshot['sexo'].toString()+ '\n'+
                      'Tipo cliente: ' +documentSnapshot['tipo'].toString()+ '\n'+
                      'Usuario: ' +documentSnapshot['usuario'].toString()+ '\n'+
                      'Reserva: ' +documentSnapshot['reserva_id_reserva'].toString()+ '\n'),
                      
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () => _update(documentSnapshot)),
                            IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () => _delete(documentSnapshot.id)),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
// agregar productos
        floatingActionButton: FloatingActionButton(
          onPressed: () => _create(),
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }
}
