// ignore_for_file: use_build_context_synchronously

import 'package:app_thu_tien/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
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
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Liste de clients'),
        trailing: GestureDetector(
          child: const Icon(
            CupertinoIcons.person_add,
          ),
          onTap: () async {
            addUser();
          },
        ),
      ),
      child: SafeArea(
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
              return CupertinoListSection(
                children: snapshot.data!.docs
                    .map(
                      (DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;
                        String uid = document.id;
                        return CupertinoListTile(
                          title: Text('${data['fullname']}'),
                          subtitle: Text('Username: ${data['username']}'),
                          trailing: const CupertinoListTileChevron(),
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
    await showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('Créer des clients'),
          actions: [
            CupertinoDialogAction(
              isDestructiveAction: true,
              child: const Text('Modifier le client'),
              onPressed: () async {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
                await deleteUser(uid: uid);
              },
            ),
            CupertinoDialogAction(
              child: const Text('Supprimer le client'),
              onPressed: () async {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
                await updateUser(uid: uid);
              },
            ),
            CupertinoDialogAction(
              child: const Text('Fermer',
                  style: TextStyle(color: CupertinoColors.label)),
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
    await showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('Créer des clients'),
          content: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Nom de connexion'),
                const SizedBox(height: 3),
                CupertinoTextField(
                  decoration: Const.decoration,
                  controller: controllerUsername,
                  autofocus: true,
                ),
                const SizedBox(height: 10),
                const Text('Nom et prénom'),
                const SizedBox(height: 3),
                CupertinoTextField(
                  decoration: Const.decoration,
                  controller: controllerFullname,
                ),
              ],
            ),
          ),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
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
            CupertinoDialogAction(
              isDestructiveAction: true,
              child: const Text('Fermer',
                  style: TextStyle(color: CupertinoColors.label)),
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
        await showCupertinoDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) {
            TextEditingController controllerFullname = TextEditingController();
            controllerFullname.text = user['fullname'];
            return CupertinoAlertDialog(
              title: const Text('Supprimer le client'),
              content: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Nom et prénom'),
                    const SizedBox(height: 3),
                    CupertinoTextField(
                      decoration: const BoxDecoration(
                        color: CupertinoColors.systemBackground,
                      ),
                      controller: controllerFullname,
                    ),
                  ],
                ),
              ),
              actions: [
                CupertinoDialogAction(
                  isDefaultAction: true,
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
                CupertinoDialogAction(
                  isDestructiveAction: true,
                  child: const Text('Fermer',
                      style: TextStyle(color: CupertinoColors.label)),
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
        await showCupertinoDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) {
            return CupertinoAlertDialog(
              title: const Text('Supprimer ce compte client?'),
              content: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Nom de connexion: ${data['username']}'),
                    const SizedBox(height: 10),
                    Text('Nom et prénom: ${data['fullname']}'),
                  ],
                ),
              ),
              actions: [
                CupertinoDialogAction(
                  isDestructiveAction: true,
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
                CupertinoDialogAction(
                  child: const Text('Fermer',
                      style: TextStyle(color: CupertinoColors.label)),
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
