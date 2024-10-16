// ignore_for_file: must_be_immutable

import 'package:app_thu_tien/admin/users.dart';
import 'package:app_thu_tien/client/commettre.dart';
import 'package:app_thu_tien/model/pay.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  var db = FirebaseFirestore.instance;
  DateTime dateTime = Timestamp.now().toDate();
  String dateWhere =
      '${Timestamp.now().toDate().day}/${Timestamp.now().toDate().month}/${Timestamp.now().toDate().year}';

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Utilisateur administrateur'),
        trailing: GestureDetector(
          child: const Icon(
            CupertinoIcons.person_3,
          ),
          onTap: () {
            Navigator.push(
              context,
              CupertinoPageRoute<Widget>(
                builder: (BuildContext context) {
                  return const UsersPage();
                },
              ),
            );
          },
        ),
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
                  child: BodyList(dateWhere: dateWhere),
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
  String dateWhere;
  BodyList({super.key, required this.dateWhere});

  @override
  State<BodyList> createState() => _BodyListState();
}

class _BodyListState extends State<BodyList> {
  double countESP = 0.0;
  double countCB = 0.0;
  double countCHQ = 0.0;
  double countCoupon = 0.0;
  double countTip = 0.0;
  double countReel = 0.0;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('payment')
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
        countESP = 0.0;
        countCB = 0.0;
        countCHQ = 0.0;
        countCoupon = 0.0;
        countTip = 0.0;
        countReel = 0.0;
        snapshot.data!.docs.map(
          (DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            PayMdl payMdl = PayMdl.fromJson(data);
            if (payMdl.typePayment == 5) {
              countReel += payMdl.value;
            } else if (payMdl.typeService == 1) {
              if (payMdl.typePayment == 1) {
                if (payMdl.isTip) {
                  countTip += payMdl.value;
                } else {
                  dataR[indexA][0] = payMdl.value;
                  countESP += payMdl.value;
                  indexA++;
                }
              } else if (payMdl.typePayment == 2) {
                dataR[indexB][1] = payMdl.value;
                countCB += payMdl.value;
                indexB++;
              } else if (payMdl.typePayment == 3) {
                countCHQ += payMdl.value;
              } else if (payMdl.typePayment == 4) {
                countCoupon += payMdl.value;
              }
            } else if (payMdl.typeService == 2) {
              if (payMdl.typePayment == 1) {
                dataR[indexC][2] = payMdl.value;
                countESP += payMdl.value;
                indexC++;
              } else if (payMdl.typePayment == 2) {
                dataR[indexD][3] = payMdl.value;
                countCB += payMdl.value;
                indexD++;
              } else if (payMdl.typePayment == 3) {
                countCHQ += payMdl.value;
              } else if (payMdl.typePayment == 4) {
                countCoupon += payMdl.value;
              }
            }
          },
        ).toList();
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Item(dataR: dataR),
              ),
            ),
            Container(
              width: context.width,
              padding: const EdgeInsets.only(
                  top: 10, left: 10, right: 10, bottom: 10),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Total ESP: $countESP'),
                  Text('Total CB: $countCB'),
                  Text('Total CHQ: $countCHQ'),
                  Text('Total Coupon: $countCoupon'),
                  Text('Total Tip: $countTip'),
                  Text('Total ESP réel: $countReel'),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
