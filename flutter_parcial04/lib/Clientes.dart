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
  final TextEditingController _cedulaController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();
  final TextEditingController _fecha_nacimientoController = TextEditingController();
  final TextEditingController _sexoController = TextEditingController();
  final TextEditingController _tipoController = TextEditingController();
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _reserva_id_reservaController = TextEditingController();

  final CollectionReference _clientes =
      FirebaseFirestore.instance.collection('clientes');
//insertar producto
  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    await showModalBottomSheet(
      
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          reset();
          _reserva_id_reservaController.text = 'Sr6Dp1bh98szXhClO48s';  
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
                  maxLength: 20,
                  controller: _cedulaController,
                  decoration: const InputDecoration(
                      labelText: 'Cedula:',
                      fillColor: Colors.white,
                      filled: true,
                      //errorText: 'Error message',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.card_membership_outlined)),
                ),
                TextField(
                  maxLength: 20,
                  controller: _nombreController,
                  decoration: const InputDecoration(
                      labelText: 'Nombre: ',
                      fillColor: Colors.white,
                      filled: true,
                      //errorText: 'Error message',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person)
                  ),
                ),
                TextField(
                  maxLength: 20,
                  controller: _apellidoController,
                  decoration: const InputDecoration(
                      labelText: 'Apellido: ',
                      fillColor: Colors.white,
                      filled: true,
                      //errorText: 'Error message',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person)
                  ),
                  
                ),
                TextField(
                  maxLength: 20,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: _fecha_nacimientoController,
                  decoration: const InputDecoration(
                      labelText: 'Fecha nacimiento Eje: (01 Ene 1998)',
                      fillColor: Colors.white,
                      filled: true,
                      //errorText: 'Error message',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.date_range)
                  ),
                  
                ),
                TextField(
                  maxLength: 20,
                  controller: _sexoController,
                  decoration: const InputDecoration(
                      labelText: 'Sexo: Ej:(Masculino/Femenino)',
                      fillColor: Colors.white,
                      filled: true,
                      //errorText: 'Error message',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.people_alt_outlined)
                  ),
                  
                ),
                TextField(
                  maxLength: 20,
                  controller: _tipoController,
                  decoration: const InputDecoration(
                      labelText: 'Tipo Ej:(A, B, C)',
                      fillColor: Colors.white,
                      filled: true,
                      //errorText: 'Error message',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.category_outlined)
                  ), 
                ),
                TextField(
                  maxLength: 20,
                  controller: _usuarioController,
                  decoration: const InputDecoration(
                      labelText: 'Usuario: ',
                      fillColor: Colors.white,
                      filled: true,
                      //errorText: 'Error message',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.verified_user_outlined)
                  ),
                ),
                TextField(
                  maxLength: 100,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: _reserva_id_reservaController,
                  decoration: const InputDecoration(
                      labelText: 'Reserva: ',
                      enabled: false,
                      fillColor: Colors.white,
                      filled: true,
                      //errorText: 'Error message',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.book_online_outlined)
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Crear'),
                  onPressed: () async {
                    final String cedula = _cedulaController.text;
                    final String nombre = _nombreController.text;
                    final String apellido = _apellidoController.text;
                    final String fecha_nacimiento= _fecha_nacimientoController.text;   
                    final String sexo = _sexoController.text;
                    final String tipo = _tipoController.text;
                    final String usuario = _usuarioController.text;
                    final String reserva_id_reserva= _reserva_id_reservaController.text;                                        
                    if (cedula != null) {
                      await _clientes
                          .add({"cedula": cedula, "nombre": nombre, "apellido": apellido, "fecha_nacimiento": fecha_nacimiento, "sexo": sexo, "tipo": tipo, "usuario": usuario, "reserva_id_reserva": reserva_id_reserva});

                      _cedulaController.text = '';
                      _nombreController.text = '';
                      _apellidoController.text = '';
                      _fecha_nacimientoController.text = '';  
                      _sexoController.text = '';
                      _tipoController.text = '';
                      _usuarioController.text = '';
                      _reserva_id_reservaController.text = '';                                            
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('El cliente fue agregado correctamente')));
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
      _cedulaController.text = documentSnapshot['cedula'].toString();
      _nombreController.text = documentSnapshot['nombre'].toString();
      _apellidoController.text = documentSnapshot['apellido'].toString();
      _fecha_nacimientoController.text = documentSnapshot['fecha_nacimiento'].toString();
      _sexoController.text = documentSnapshot['sexo'].toString();
      _tipoController.text = documentSnapshot['tipo'].toString();
      _usuarioController.text = documentSnapshot['usuario'].toString();
      _reserva_id_reservaController.text = documentSnapshot['reserva_id_reserva'].toString();
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
                  maxLength: 20,
                  controller: _cedulaController,
                  decoration: const InputDecoration(
                      labelText: 'Cedula:',
                      fillColor: Colors.white,
                      filled: true,
                      //errorText: 'Error message',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.card_membership_outlined)),
                ),
                TextField(
                  maxLength: 20,
                  controller: _nombreController,
                  decoration: const InputDecoration(
                      labelText: 'Nombre: ',
                      fillColor: Colors.white,
                      filled: true,
                      //errorText: 'Error message',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person)
                  ),
                ),
                TextField(
                  maxLength: 20,
                  controller: _apellidoController,
                  decoration: const InputDecoration(
                      labelText: 'Apellido: ',
                      fillColor: Colors.white,
                      filled: true,
                      //errorText: 'Error message',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person)
                  ),
                  
                ),
                TextField(
                  maxLength: 20,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: _fecha_nacimientoController,
                  decoration: const InputDecoration(
                      labelText: 'Fecha nacimiento Eje: (01 Ene 1998)',
                      fillColor: Colors.white,
                      filled: true,
                      //errorText: 'Error message',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.date_range)
                  ),
                  
                ),
                TextField(
                  maxLength: 20,
                  controller: _sexoController,
                  decoration: const InputDecoration(
                      labelText: 'Sexo: Ej:(Masculino/Femenino)',
                      fillColor: Colors.white,
                      filled: true,
                      //errorText: 'Error message',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.people_alt_outlined)
                  ),
                  
                ),
                TextField(
                  maxLength: 20,
                  controller: _tipoController,
                  decoration: const InputDecoration(
                      labelText: 'Tipo Ej:(A, B, C)',
                      fillColor: Colors.white,
                      filled: true,
                      //errorText: 'Error message',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.category_outlined)
                  ), 
                ),
                TextField(
                  maxLength: 20,
                  controller: _usuarioController,
                  decoration: const InputDecoration(
                      labelText: 'Usuario: ',
                      fillColor: Colors.white,
                      filled: true,
                      //errorText: 'Error message',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.verified_user_outlined)
                  ),
                ),
                TextField(
                  maxLength: 100,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: _reserva_id_reservaController,
                  decoration: const InputDecoration(
                      labelText: 'Reserva: ',
                      fillColor: Colors.white,
                      filled: true,
                      //errorText: 'Error message',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.book_online_outlined)
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Update'),
                  onPressed: () async {
                    final String cedula = _cedulaController.text;
                    final String nombre = _nombreController.text;
                    final String apellido = _apellidoController.text;
                    final String fecha_nacimiento= _fecha_nacimientoController.text;   
                    final String sexo = _sexoController.text;
                    final String tipo = _tipoController.text;
                    final String usuario = _usuarioController.text;
                    final String reserva_id_reserva= _reserva_id_reservaController.text; 
                    if (cedula != null) {
                      await _clientes
                          .doc(documentSnapshot!.id)
                          .update({"cedula": cedula, "nombre": nombre, "apellido": apellido, "fecha_nacimiento": fecha_nacimiento, "sexo": sexo, "tipo": tipo, "usuario": usuario, "reserva_id_reserva": reserva_id_reserva});

                      /*
                      _cedulaController.text = '';
                      _nombreController.text = '';
                      _apellidoController.text = '';
                      _fecha_nacimientoController.text = '';  
                      _sexoController.text = '';
                      _tipoController.text = '';
                      _usuarioController.text = '';
                      */
                      reset();
                      _reserva_id_reservaController.text = '';  

                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('El cliente fue actualizado correctamente')));
                    }
                  },
                )
              ],
            ),
          );
        });
  }

//borrar productos
  Future<void> _delete(String clientId) async {
    await _clientes.doc(clientId).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('El cliente fue eliminado correctamente')));
  }

reset() {
    _cedulaController.text = '';
    _nombreController.text = '';
    _apellidoController.text = '';
    _fecha_nacimientoController.text = '';
    _sexoController.text = '';
    _tipoController.text = '';
    _usuarioController.text = '';
  }
//Listar Clientes
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Firebase Clientes')),
        ),
        body: StreamBuilder(
          stream: _clientes.snapshots(),
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
                      title: Text('Nombre: '+documentSnapshot['nombre'].toString() + '\n'+
                      'Apellido: ' + documentSnapshot['apellido'].toString()),
                      subtitle: Text('Cédula: '+documentSnapshot['cedula'].toString() + '\n'+
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
                                icon: const Icon(Icons.edit,
                                color: Colors.green,),

                                onPressed: () => _update(documentSnapshot)),
                            IconButton(
                                icon: const Icon(Icons.delete,
                                color: Colors.redAccent,),
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
// agregar clientes
        floatingActionButton: FloatingActionButton(
          onPressed: () => _create(),
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }
}
