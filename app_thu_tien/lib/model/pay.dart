// ignore_for_file: unnecessary_getters_setters

class PayMdl {
  late String _uid = '';
  late int _typeService = 0;
  late int _typePayment = 0;
  late double _value = 0;
  late String _date = '';
  bool _isTip = false;

  PayMdl({
    String uid = '',
    int typeService = 0,
    int typePayment = 0,
    double value = 0,
    bool isTip = false,
  }) {
    if (uid != '') {
      _uid = uid;
    }
    if (typeService != 0) {
      _typeService = typeService;
    }
    if (typePayment != 0) {
      _typePayment = typePayment;
    }
    if (value != 0) {
      _value = value;
    }
    if (isTip) {
      _isTip = isTip;
    }
  }

  String get uid => _uid;
  set uid(String uid) => _uid = uid;
  int get typeService => _typeService;
  set typeService(int typeService) => _typeService = typeService;
  int get typePayment => _typePayment;
  set typePayment(int typePayment) => _typePayment = typePayment;
  double get value => _value;
  set value(double value) => _value = value;
  String get date => _date;
  set date(String date) => _date = date;
  bool get isTip => _isTip;
  set isTip(bool isTip) => _isTip = isTip;

  PayMdl.fromJson(Map<String, dynamic> json) {
    _uid = json['uid'].toString();
    _typeService = int.tryParse(json['type_service'].toString()) ?? 0;
    _typePayment = int.tryParse(json['type_payment'].toString()) ?? 0;
    _value = double.tryParse(json['value'].toString()) ?? 0;
    _date = json['date'].toString();
    _isTip = bool.tryParse(json['isTip'].toString()) ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = _uid;
    data['type_service'] = _typeService;
    data['type_payment'] = _typePayment;
    data['value'] = _value;
    data['date'] = _date;
    data['isTip'] = _isTip;
    return data;
  }
}
