// ignore_for_file: use_build_context_synchronously

import 'package:app_thu_tien/client/commettre.dart';
import 'package:app_thu_tien/client/payer.dart';
import 'package:app_thu_tien/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:toastification/toastification.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  var db = FirebaseFirestore.instance;
  Widget authHead = const SizedBox();
  Widget authBody = const Center(child: CupertinoActivityIndicator());
  Widget authButton = const SizedBox();
  Widget authLogout = const SizedBox();
  TextEditingController controllerUsername = TextEditingController();
  @override
  void initState() {
    super.initState();
    loadAuth();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: authHead,
        trailing: authLogout,
      ),
      child: SizedBox(
        height: context.height,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            authBody,
            Center(child: authButton),
          ],
        ),
      ),
    );
  }

  Future loadAuth() async {
    if ('${GetStorage().read('uid')}' != 'null') {
      setState(() {
        authHead = Text('${GetStorage().read('uid')}');
      });
      await db
          .collection('users')
          .doc('${GetStorage().read('uid')}')
          .get()
          .then((snapshot) async {
        final data = snapshot.data();
        if ('${data!['username']}' != '') {
          loadLauch(data);
        } else {
          loadLogin();
        }
      });
    } else {
      loadLogin();
    }
  }

  loadLauch(Map<String, dynamic> data) {
    setState(() {
      authHead = Text('Bonjour ${data['fullname']}');
      authLogout = GestureDetector(
        child: const Icon(
          CupertinoIcons.square_arrow_right,
        ),
        onTap: () async {
          await showCupertinoDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) {
              return CupertinoAlertDialog(
                title: const Text('Déconnectez-vous de votre compte'),
                actions: [
                  CupertinoDialogAction(
                    isDestructiveAction: true,
                    child: const Text('Confirmer'),
                    onPressed: () async {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                      await GetStorage().remove('uid');
                      loading();
                      await Future.delayed(const Duration(seconds: 1));
                      loadAuth();
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
        },
      );
      authBody = const SizedBox();
      authButton = CupertinoButton.filled(
        onPressed: () async {
          await showCupertinoDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) {
              return CupertinoAlertDialog(
                title: const Text('Déconnectez-vous de votre compte'),
                actions: [
                  CupertinoDialogAction(
                    isDefaultAction: true,
                    child: const Text('Payer'),
                    onPressed: () async {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                      await Navigator.push(
                        context,
                        CupertinoPageRoute<Widget>(
                          builder: (BuildContext context) {
                            return const PayerPage();
                          },
                        ),
                      );
                    },
                  ),
                  CupertinoDialogAction(
                    isDefaultAction: true,
                    child: const Text('Commettre'),
                    onPressed: () async {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                      await Navigator.push(
                        context,
                        CupertinoPageRoute<Widget>(
                          builder: (BuildContext context) {
                            return const CommettrePage();
                          },
                        ),
                      );
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
        },
        child: const Text('Démarrer'),
      );
    });
  }

  loadLogin() {
    setState(() {
      authHead = const Text('Veuillez vous connecter');
      authBody = Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Nom de connexion'),
            const SizedBox(height: 5),
            CupertinoTextField(
              decoration: Const.decoration,
              controller: controllerUsername,
              autofocus: false,
            ),
            const SizedBox(height: 20),
          ],
        ),
      );
      authButton = CupertinoButton.filled(
        child: const Text('Se connecter'),
        onPressed: () async {
          if (controllerUsername.text.isNotEmpty) {
            FocusScope.of(context).unfocus();
            loading();
            var checkUser =
                await db.collection('users').doc(controllerUsername.text).get();
            if (checkUser.data() != null) {
              await GetStorage().write('uid', controllerUsername.text);
              await Future.delayed(const Duration(seconds: 1));
              loadLauch(checkUser.data() ?? {});
              toastification.show(
                context: context,
                title: const Text('Connectez-vous avec succès'),
                autoCloseDuration: const Duration(seconds: 3),
                type: ToastificationType.success,
              );
            } else {
              toastification.show(
                context: context,
                title: const Text('Le compte n`existe pas'),
                autoCloseDuration: const Duration(seconds: 3),
                type: ToastificationType.error,
              );
              loadLogin();
            }
          } else {
            toastification.show(
              context: context,
              title: const Text('Le nom d`utilisateur ne peut pas être vide'),
              autoCloseDuration: const Duration(seconds: 3),
              type: ToastificationType.warning,
            );
          }
        },
      );
    });
  }

  loading() {
    setState(() {
      authHead = const Text('Connexion....');
      authButton = CupertinoButton(
        child: const CupertinoActivityIndicator(),
        onPressed: () {},
      );
    });
  }
}
