// ignore_for_file: must_be_immutable

import 'package:app_thu_tien/model/pay.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CommettrePage extends StatefulWidget {
  const CommettrePage({super.key});

  @override
  State<CommettrePage> createState() => _CommettrePageState();
}

class _CommettrePageState extends State<CommettrePage> {
  var db = FirebaseFirestore.instance;
  DateTime dateTime = Timestamp.now().toDate();
  String dateWhere =
      '${Timestamp.now().toDate().day}/${Timestamp.now().toDate().month}/${Timestamp.now().toDate().year}';

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
              Container(
                padding: const EdgeInsets.only(
                    top: 30, left: 10, right: 10, bottom: 10),
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
                    CupertinoButton.filled(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: const Text('Commettre'),
                      onPressed: () {},
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
