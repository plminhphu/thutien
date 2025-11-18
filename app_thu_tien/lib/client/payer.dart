// ignore_for_file: use_build_context_synchronously

import 'package:money_management/model/pay.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:toastification/toastification.dart';

class PayerPage extends StatefulWidget {
  const PayerPage({super.key});

  @override
  State<PayerPage> createState() => _PayerPageState();
}

class _PayerPageState extends State<PayerPage> {
  var db = FirebaseFirestore.instance;
  bool resPayment = false;
  PayMdl manucureESP = PayMdl(
    typeService: 1,
    typePayment: 1,
  );
  PayMdl manucureCB = PayMdl(
    typeService: 1,
    typePayment: 2,
  );
  PayMdl manucureCHQ = PayMdl(
    typeService: 1,
    typePayment: 3,
  );
  PayMdl manucureCoupon = PayMdl(
    typeService: 1,
    typePayment: 4,
  );
  PayMdl coiffureESP = PayMdl(
    typeService: 2,
    typePayment: 1,
  );
  PayMdl coiffureCB = PayMdl(
    typeService: 2,
    typePayment: 2,
  );
  PayMdl coiffureCHQ = PayMdl(
    typeService: 2,
    typePayment: 3,
  );
  PayMdl coiffureCoupon = PayMdl(
    typeService: 2,
    typePayment: 4,
  );
  PayMdl tip = PayMdl(
    typeService: 1,
    typePayment: 1,
    isTip: true,
  );
  TextEditingController manucureESPCtrl = TextEditingController();
  TextEditingController manucureCBCtrl = TextEditingController();
  TextEditingController manucureCHQCtrl = TextEditingController();
  TextEditingController manucureCouponCtrl = TextEditingController();
  TextEditingController coiffureESPCtrl = TextEditingController();
  TextEditingController coiffureCBCtrl = TextEditingController();
  TextEditingController coiffureCHQCtrl = TextEditingController();
  TextEditingController coiffureCouponCtrl = TextEditingController();
  TextEditingController tipCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double fontSizeHead =
        Theme.of(context).textTheme.titleMedium!.fontSize ?? 20;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payer'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Manucure',
                style: TextStyle(fontSize: fontSizeHead),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ListView(
                    children: [
                      ListTile(
                        leading: const SizedBox(
                          width: 60,
                          child: Text('ESP', textAlign: TextAlign.start),
                        ),
                        title: TextField(
                          key: const Key('manucureESP'),
                          controller: manucureESPCtrl,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            manucureESP.value = double.parse(value);
                            checkPayment();
                          },
                        ),
                      ),
                      ListTile(
                        leading: const SizedBox(
                          width: 60,
                          child: Text('CB', textAlign: TextAlign.start),
                        ),
                        title: TextField(
                          key: const Key('manucureCB'),
                          controller: manucureCBCtrl,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            manucureCB.value = double.parse(value);
                            checkPayment();
                          },
                        ),
                      ),
                      ListTile(
                        leading: const SizedBox(
                          width: 60,
                          child: Text('CHQ', textAlign: TextAlign.start),
                        ),
                        title: TextField(
                          key: const Key('manucureCHQ'),
                          controller: manucureCHQCtrl,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            manucureCHQ.value = double.parse(value);
                            checkPayment();
                          },
                        ),
                      ),
                      ListTile(
                        leading: const SizedBox(
                          width: 60,
                          child: Text('Coupon', textAlign: TextAlign.start),
                        ),
                        title: TextField(
                          key: const Key('manucureCoupon'),
                          controller: manucureCouponCtrl,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            manucureCoupon.value = double.parse(value);
                            checkPayment();
                          },
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Coiffure',
                    style: TextStyle(fontSize: fontSizeHead),
                  ),
                  ListView(
                    children: [
                      ListTile(
                        leading: const SizedBox(
                          width: 60,
                          child: Text('ESP', textAlign: TextAlign.start),
                        ),
                        title: TextField(
                          key: const Key('coiffureESP'),
                          controller: coiffureESPCtrl,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            coiffureESP.value = double.parse(value);
                            checkPayment();
                          },
                        ),
                      ),
                      ListTile(
                        leading: const SizedBox(
                          width: 60,
                          child: Text('CB', textAlign: TextAlign.start),
                        ),
                        title: TextField(
                          key: const Key('coiffureCB'),
                          controller: coiffureCBCtrl,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            coiffureCB.value = double.parse(value);
                            checkPayment();
                          },
                        ),
                      ),
                      ListTile(
                        leading: const SizedBox(
                          width: 60,
                          child: Text('CHQ', textAlign: TextAlign.start),
                        ),
                        title: TextField(
                          key: const Key('coiffureCHQ'),
                          controller: coiffureCHQCtrl,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            coiffureCHQ.value = double.parse(value);
                            checkPayment();
                          },
                        ),
                      ),
                      ListTile(
                        leading: const SizedBox(
                          width: 60,
                          child: Text('Coupon', textAlign: TextAlign.start),
                        ),
                        title: TextField(
                          key: const Key('coiffureCoupon'),
                          controller: coiffureCouponCtrl,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            coiffureCoupon.value = double.parse(value);
                            checkPayment();
                          },
                        ),
                      ),
                    ],
                  ),
                  ListView(
                    children: [
                      ListTile(
                        leading: const SizedBox(
                          width: 60,
                          child: Text('Tip', textAlign: TextAlign.start),
                        ),
                        title: TextField(
                          key: const Key('tip'),
                          controller: tipCtrl,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            tip.value = double.parse(value);
                          },
                        ),
                      ),
                      const ListTile(
                        leading: SizedBox(
                          width: 60,
                          child: Text('Motif', textAlign: TextAlign.start),
                        ),
                        title: TextField(
                          key: Key('Motif'),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    color: Colors.grey,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextButton(
                          child: const Text('Fermer'),
                          onPressed: () {
                            if (Navigator.canPop(context)) {
                              Navigator.pop(context);
                            }
                          },
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                  resPayment ? Colors.blue : Colors.grey)),
                          child: const Text('Enregistre'),
                          onPressed: () {
                            if (resPayment) {
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
            ],
          ),
        ),
      ),
    );
  }

  Future submitForm(BuildContext context) async {
    context.loaderOverlay.show();
    await submitItemForm(manucureESP);
    manucureESPCtrl.text = '';
    await submitItemForm(manucureCB);
    manucureCBCtrl.text = '';
    await submitItemForm(manucureCHQ);
    manucureCHQCtrl.text = '';
    await submitItemForm(manucureCoupon);
    manucureCouponCtrl.text = '';
    await submitItemForm(coiffureESP);
    coiffureESPCtrl.text = '';
    await submitItemForm(coiffureCB);
    coiffureCBCtrl.text = '';
    await submitItemForm(coiffureCHQ);
    coiffureCHQCtrl.text = '';
    await submitItemForm(coiffureCoupon);
    coiffureCouponCtrl.text = '';
    await submitItemForm(tip);
    tipCtrl.text = '';
    context.loaderOverlay.hide();
    checkPayment();
  }

  Future submitItemForm(PayMdl item) async {
    if (item.value != 0) {
      DateTime dateTime = Timestamp.now().toDate();
      item.date = '${dateTime.day}/${dateTime.month}/${dateTime.year}';
      GetStorage box = GetStorage();
      String uid = box.read('uid');
      item.uid = uid;
      await db.collection('payment').add(item.toJson()).then((e) {
        toastification.show(
          context: context,
          title: const Text('Nouveau compte créé'),
          autoCloseDuration: const Duration(milliseconds: 1500),
          type: ToastificationType.success,
        );
        item.value = 0;
      });
      await Future.delayed(Durations.medium1);
    }
  }

  checkPayment() {
    bool res = false;
    res = manucureESP.value != 0 ? true : res;
    res = manucureCB.value != 0 ? true : res;
    res = manucureCHQ.value != 0 ? true : res;
    res = manucureCoupon.value != 0 ? true : res;
    res = coiffureESP.value != 0 ? true : res;
    res = coiffureCB.value != 0 ? true : res;
    res = coiffureCHQ.value != 0 ? true : res;
    res = coiffureCoupon.value != 0 ? true : res;
    setState(() {
      resPayment = res;
    });
  }
}
