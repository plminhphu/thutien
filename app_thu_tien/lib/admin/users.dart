// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  var db = FirebaseFirestore.instance;
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('users').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Liste de clients'), actions: [
        GestureDetector(
          child: const Icon(
            Icons.person_add_alt,
          ),
          onTap: () async {
            await addUser();
          },
        ),
        const SizedBox(width: 20),
      ]),
      body: SafeArea(
        child: Center(
          child: StreamBuilder<QuerySnapshot>(
            stream: _usersStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Quelque chose s`est mal passé');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text('Chargement');
              }
              return ListView(
                children: snapshot.data!.docs
                    .map(
                      (DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;
                        String uid = document.id;
                        return ListTile(
                          title: Text('${data['fullname']}'),
                          subtitle: Text('Username: ${data['username']}'),
                          onTap: () async {
                            await actionUser(uid: uid);
                          },
                        );
                      },
                    )
                    .toList()
                    .cast(),
              );
            },
          ),
        ),
      ),
    );
  }

  Future actionUser({required String uid}) async {
    await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          title: const Text('Créer des clients'),
          content: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  child: const Text('Modifier le client'),
                  onPressed: () async {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                    await deleteUser(uid: uid);
                  },
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  child: const Text('Supprimer le client'),
                  onPressed: () async {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                    await updateUser(uid: uid);
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Fermer'),
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future addUser() async {
    TextEditingController controllerUsername = TextEditingController(text: '');
    TextEditingController controllerFullname = TextEditingController(text: '');
    await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          title: const Text('Créer des clients'),
          content: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Nom de connexion'),
                const SizedBox(height: 3),
                TextField(
                  controller: controllerUsername,
                  autofocus: true,
                ),
                const SizedBox(height: 10),
                const Text('Nom et prénom'),
                const SizedBox(height: 3),
                TextField(
                  controller: controllerFullname,
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              child: const Text('Créer'),
              onPressed: () async {
                if (controllerFullname.text.isNotEmpty &&
                    controllerUsername.text.isNotEmpty) {
                  var checkUser =
                      db.collection('users').doc(controllerUsername.text).get();
                  final user = <String, dynamic>{
                    'fullname': controllerFullname.text,
                    'username': controllerUsername.text,
                  };
                  if (checkUser.isBlank!) {
                    toastification.show(
                      context: context,
                      title: const Text('Ce compte ne peut pas être créé'),
                      autoCloseDuration: const Duration(seconds: 3),
                      type: ToastificationType.error,
                    );
                  } else {
                    await db
                        .collection('users')
                        .doc(controllerUsername.text)
                        .set(user)
                        .then((e) {
                      toastification.show(
                        context: context,
                        title: const Text('Nouveau compte créé'),
                        autoCloseDuration: const Duration(seconds: 3),
                        type: ToastificationType.success,
                      );
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    });
                  }
                } else {
                  toastification.show(
                    context: context,
                    title: const Text(
                        'Le nom d`utilisateur ne peut pas être vide'),
                    autoCloseDuration: const Duration(seconds: 3),
                    type: ToastificationType.warning,
                  );
                }
              },
            ),
            TextButton(
              child: const Text('Fermer'),
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future updateUser({required String uid}) async {
    db.collection('users').doc(uid).get().then((snapshot) async {
      final data = snapshot.data();
      if (data!.isNotEmpty) {
        var user = <String, dynamic>{
          'fullname': data['fullname'],
          'username': data['username'],
        };
        await showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) {
            TextEditingController controllerFullname = TextEditingController();
            controllerFullname.text = user['fullname'];
            return AlertDialog(
              title: const Text('Supprimer le client'),
              content: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Nom et prénom'),
                    const SizedBox(height: 3),
                    TextField(
                      controller: controllerFullname,
                    ),
                  ],
                ),
              ),
              actions: [
                ElevatedButton(
                  child: const Text('Mise à jour'),
                  onPressed: () async {
                    await db.collection('users').doc(uid).update({
                      'fullname': controllerFullname.text,
                    }).then((e) {
                      toastification.show(
                        context: context,
                        title: const Text('Mis à jour avec succès'),
                        autoCloseDuration: const Duration(seconds: 3),
                        type: ToastificationType.success,
                      );
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    });
                  },
                ),
                TextButton(
                  child: const Text('Fermer'),
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            );
          },
        );
      }
    });
  }

  Future deleteUser({required String uid}) async {
    db.collection('users').doc(uid).get().then((snapshot) async {
      final data = snapshot.data();
      if (data!.isNotEmpty) {
        await showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) {
            return AlertDialog(
              title: const Text('Supprimer ce compte client?'),
              content: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Nom de connexion: ${data['username']}'),
                    const SizedBox(height: 10),
                    Text('Nom et prénom: ${data['fullname']}'),
                  ],
                ),
              ),
              actions: [
                ElevatedButton(
                  child: const Text('Confirmer'),
                  onPressed: () async {
                    await db.collection('users').doc(uid).delete().then((e) {
                      toastification.show(
                        context: context,
                        title: const Text('Compte utilisateur supprimé'),
                        autoCloseDuration: const Duration(seconds: 3),
                        type: ToastificationType.success,
                      );
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    });
                  },
                ),
                TextButton(
                  child: const Text('Fermer'),
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            );
          },
        );
      }
    });
  }
}
