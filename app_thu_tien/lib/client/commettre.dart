// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:app_thu_tien/const.dart';
import 'package:app_thu_tien/model/pay.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:toastification/toastification.dart';

class CommettrePage extends StatefulWidget {
  const CommettrePage({super.key});

  @override
  State<CommettrePage> createState() => _CommettrePageState();
}

class _CommettrePageState extends State<CommettrePage> {
  bool resReel = false;
  var db = FirebaseFirestore.instance;
  DateTime dateTime = Timestamp.now().toDate();
  String dateWhere =
      '${Timestamp.now().toDate().day}/${Timestamp.now().toDate().month}/${Timestamp.now().toDate().year}';

  PayMdl reel = PayMdl(
    typeService: 0,
    typePayment: 5,
    isTip: true,
  );
  TextEditingController reelCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Commettre'),
      ),
      child: SafeArea(
        child: SizedBox(
          width: context.width,
          height: context.height,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: Table(
                  border: const TableBorder(
                    top: BorderSide(color: CupertinoColors.systemGrey2),
                    left: BorderSide(color: CupertinoColors.systemGrey2),
                    right: BorderSide(color: CupertinoColors.systemGrey2),
                  ),
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(
                      children: <Widget>[
                        TableCell(
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            color: CupertinoColors.white,
                            child: Text(
                              'Date: $dateWhere',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        TableCell(
                          child: GestureDetector(
                            onTap: () async {
                              showCupertinoModalPopup<void>(
                                context: context,
                                builder: (BuildContext context) => Container(
                                  height: 216,
                                  padding: const EdgeInsets.only(top: 6.0),
                                  margin: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom,
                                  ),
                                  color: CupertinoColors.systemBackground
                                      .resolveFrom(context),
                                  child: SafeArea(
                                    top: false,
                                    child: CupertinoDatePicker(
                                      initialDateTime: dateTime,
                                      minimumDate: dateTime
                                          .subtract(const Duration(days: 3)),
                                      maximumDate:
                                          dateTime.add(const Duration(days: 7)),
                                      mode: CupertinoDatePickerMode.date,
                                      showDayOfWeek: false,
                                      onDateTimeChanged: (DateTime dt) {
                                        setState(() {
                                          dateTime = dt;
                                          dateWhere =
                                              '${dateTime.day}/${dateTime.month}/${dateTime.year}';
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: const Row(
                              children: [
                                Icon(CupertinoIcons.calendar),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Table(
                  border: const TableBorder(
                    top: BorderSide(color: CupertinoColors.systemGrey2),
                    left: BorderSide(color: CupertinoColors.systemGrey2),
                    right: BorderSide(color: CupertinoColors.systemGrey2),
                    bottom: BorderSide(color: CupertinoColors.systemGrey2),
                    horizontalInside:
                        BorderSide(color: CupertinoColors.systemGrey2),
                    verticalInside:
                        BorderSide(color: CupertinoColors.systemGrey2),
                  ),
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(
                      children: <Widget>[
                        TableCell(
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            color: CupertinoColors.white,
                            child: const Text(
                              'Manucure',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            color: CupertinoColors.white,
                            child: const Text(
                              'Coiffure',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Table(
                  border: const TableBorder(
                    left: BorderSide(color: CupertinoColors.systemGrey2),
                    right: BorderSide(color: CupertinoColors.systemGrey2),
                    bottom: BorderSide(color: CupertinoColors.systemGrey2),
                    horizontalInside:
                        BorderSide(color: CupertinoColors.systemGrey2),
                    verticalInside:
                        BorderSide(color: CupertinoColors.systemGrey2),
                  ),
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(
                      children: <Widget>[
                        TableCell(
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            color: CupertinoColors.white,
                            child: const Text(
                              'ESP',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            color: CupertinoColors.white,
                            child: const Text(
                              'CB',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            color: CupertinoColors.white,
                            child: const Text(
                              'ESP',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            color: CupertinoColors.white,
                            child: const Text(
                              'CB',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: SingleChildScrollView(
                    child: BodyList(
                      uidWhere: GetStorage().read('uid').toString(),
                      dateWhere: dateWhere,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: CupertinoListTile(
                  leading: const SizedBox(
                    width: 60,
                    child: Text('ESP réel', textAlign: TextAlign.start),
                  ),
                  leadingSize: 60,
                  leadingToTitle: 10,
                  title: CupertinoTextField(
                    key: const Key('reel'),
                    controller: reelCtrl,
                    decoration: Const.decoration,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      reel.value = double.tryParse(value) ?? 0;
                      setState(() {
                        resReel = reel.value != 0;
                      });
                    },
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CupertinoButton(
                      color: CupertinoColors.separator,
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: const Text('Fermer',
                          style: TextStyle(
                            color: CupertinoColors.label,
                          )),
                      onPressed: () {
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        }
                      },
                    ),
                    CupertinoButton(
                      color: resReel
                          ? CupertinoColors.activeBlue
                          : CupertinoColors.label,
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: const Text('Commettre'),
                      onPressed: () {
                        if (resReel) {
                          submitForm(context);
                        } else {
                          toastification.show(
                            context: context,
                            title: const Text(
                                'Il n`y a pas encore de type de service'),
                            autoCloseDuration: const Duration(seconds: 3),
                            type: ToastificationType.warning,
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future submitForm(BuildContext context) async {
    context.loaderOverlay.show();
    if (reel.value != 0) {
      DateTime dateTime = Timestamp.now().toDate();
      reel.date = '${dateTime.day}/${dateTime.month}/${dateTime.year}';
      GetStorage box = GetStorage();
      String uid = box.read('uid');
      reel.uid = uid;
      await db.collection('payment').add(reel.toJson()).then((e) {
        toastification.show(
          context: context,
          title: const Text('Nouveau compte créé'),
          autoCloseDuration: const Duration(milliseconds: 1500),
          type: ToastificationType.success,
        );
        reel.value = 0;
      });
      await Future.delayed(Durations.medium1);
    }
    reelCtrl.text = '';
    setState(() {
      resReel = reel.value != 0;
    });
    context.loaderOverlay.hide();
  }
}

class BodyList extends StatefulWidget {
  String uidWhere;
  String dateWhere;
  BodyList({super.key, required this.uidWhere, required this.dateWhere});

  @override
  State<BodyList> createState() => _BodyListState();
}

class _BodyListState extends State<BodyList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('payment')
          .where('uid', isEqualTo: widget.uidWhere)
          .where('date', isEqualTo: widget.dateWhere)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        int indexA = 0;
        int indexB = 0;
        int indexC = 0;
        int indexD = 0;
        List<List<double>> dataR = [
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
        ];
        if (snapshot.hasError) {
          return Item(dataR: dataR);
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Item(dataR: dataR);
        }
        snapshot.data!.docs.map(
          (DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            PayMdl payMdl = PayMdl.fromJson(data);
            if (payMdl.typeService == 1) {
              if (payMdl.typePayment == 1) {
                dataR[indexA][0] = payMdl.value;
                indexA++;
              } else if (payMdl.typePayment == 2) {
                dataR[indexB][1] = payMdl.value;
                indexB++;
              } else if (payMdl.typePayment == 3) {
              } else if (payMdl.typePayment == 4) {}
            } else if (payMdl.typeService == 2) {
              if (payMdl.typePayment == 1) {
                dataR[indexC][2] = payMdl.value;
                indexC++;
              } else if (payMdl.typePayment == 2) {
                dataR[indexD][3] = payMdl.value;
                indexD++;
              } else if (payMdl.typePayment == 3) {
              } else if (payMdl.typePayment == 4) {}
            }
          },
        ).toList();
        return Item(dataR: dataR);
      },
    );
  }
}

class Item extends StatefulWidget {
  List<List<double>> dataR;
  Item({
    super.key,
    required this.dataR,
  });

  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
  @override
  Widget build(BuildContext context) {
    return Table(
      border: const TableBorder(
        left: BorderSide(color: CupertinoColors.systemGrey2),
        right: BorderSide(color: CupertinoColors.systemGrey2),
        bottom: BorderSide(color: CupertinoColors.systemGrey2),
        horizontalInside: BorderSide(color: CupertinoColors.systemGrey2),
        verticalInside: BorderSide(color: CupertinoColors.systemGrey2),
      ),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: widget.dataR
          .map(
            (dataI) {
              return TableRow(
                children: <Widget>[
                  TableCell(
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        dataI[0] != 0 ? '${dataI[0]}' : '',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        dataI[1] != 0 ? '${dataI[1]}' : '',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        dataI[2] != 0 ? '${dataI[2]}' : '',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        dataI[3] != 0 ? '${dataI[3]}' : '',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              );
            },
          )
          .toList()
          .cast(),
    );
  }
}
