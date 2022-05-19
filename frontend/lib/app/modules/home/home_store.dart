import 'dart:convert';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  @observable
  int selectedIndex = 0;

  @observable
  var page_controller = PageController();

  @observable
  int? id = Modular.args.data;

  @observable
  List<dynamic>? invoices;

  @observable
  List<dynamic> categories = [];

  @observable
  int? invoice_id;

  @observable
  Map select_invoice = {};

  @observable
  bool is_modify = false;

  @observable
  List<Map<dynamic, dynamic>> users = [{}];

  @observable
  List<Map<dynamic, dynamic>> category_percents = [{}];

  @observable
  int total_invoice = 0;

  @observable
  int any_payed = 0;

  @observable
  int total_invoice_person = 0;

  @observable
  PickerDateRange dateRange = PickerDateRange(
      DateTime.utc(DateTime.now().year, DateTime.now().month - 1, 20),
      DateTime.utc(DateTime.now().year, DateTime.now().month, 20));

  @observable
  Map<String, dynamic> category = {};

  @observable
  bool? is_payed;

  @observable
  TextEditingController description = TextEditingController();

  @observable
  MoneyMaskedTextController? price = MoneyMaskedTextController(
      leftSymbol: "R\$ ", decimalSeparator: ',', thousandSeparator: '.');

  @observable
  DateTime date = DateTime.now();

  @observable
  bool loading = false;

  @action
  setPageAndIndex(int index) {
    selectedIndex = index;

    page_controller.animateToPage(index,
        duration: const Duration(milliseconds: 200), curve: Curves.easeOut);
  }

  @action
  setIndex(int index) {
    selectedIndex = index;
  }

  @action
  set_category(Map<String, dynamic> e) {
    category = e;
  }

  @action
  set_paid(bool? e) {
    is_payed = e;
    print(is_payed);
  }

  @action
  set_dateRange(PickerDateRange dt) async {
    dateRange = dt;

    // if (dt.startDate != null && dt.endDate != null) {
    //   final prefs = await SharedPreferences.getInstance();
    //   await prefs.setStringList('dateRange',
    //       [dt.startDate!.toIso8601String(), dt.endDate!.toIso8601String()]);
    // }
  }

  @action
  get_invoices() async {
    if (dateRange.startDate == null || dateRange.endDate == null) {
      return;
    }

    loading = true;

    final prefs = await SharedPreferences.getInstance();
    int? home_id = prefs.getInt('home_id');

    String url = await SharedPreferences.getInstance()
        .then((value) => value.getString('url')!);

    var result = await Dio().post(
      url + 'list-invoices-date-interval',
      data: jsonEncode([
        {
          'first_date': dateRange.startDate!.toIso8601String().toString(),
          'last_date': dateRange.endDate!.toIso8601String().toString(),
          'homeid': home_id,
        }
      ]),
    );

    invoices = jsonDecode(result.data);

    for (var e in invoices!) {
      e['invoice']['date'] = DateTime.parse(e['invoice']['date']);
    }

    calc_total();

    //print(invoices);

    loading = false;
  }

  @action
  get_categories() async {
    loading = true;

    final prefs = await SharedPreferences.getInstance();
    String url = await SharedPreferences.getInstance()
        .then((value) => value.getString('url')!);

    var result;

    try {
      result = await Dio().get(url + 'list-categories');
    } on Exception catch (e) {
      print(e);
    }

    categories = jsonDecode(result.data);

    //print("Cateories....: ${categories}");

    loading = false;
  }

  @action
  set_date(DateTime dt) {
    date = dt;
  }

  @action
  set_select_invoice(I) {
    select_invoice = I;
  }

  modify(e) {
    is_modify = true;
    category = {
      'category': {
        'categoryId': e['invoice']['categoryId'],
        'name': e['category']['name']
      }
    };
    description.text = e['invoice']['description'];
    price!.updateValue(int.parse(e['invoice']['price']) / 100);
    date = e['invoice']['date'];
    invoice_id = e['invoice']['invoiceid'];
    is_payed = e['invoice']['paid'];
  }

  @action
  clear_input() {
    description.text = "";
    category = {};
    price!.updateValue(0.00);
    date = DateTime.now();
    is_modify = false;
    is_payed = null;
  }

  @action
  add_invoice() async {
    loading = true;

    final prefs = await SharedPreferences.getInstance();
    bool? logged = prefs.getBool('is_logged');
    String url = await SharedPreferences.getInstance()
        .then((value) => value.getString('url')!);

    int? id;
    int? home_id;
    if (logged != null && logged) {
      id = prefs.getInt('id');
      home_id = prefs.getInt('home_id');
      print(home_id);
    }

    try {
      var result = await Dio()
          .post(
        url + 'add-invoice',
        data: jsonEncode([
          {
            "description": description.text,
            "categoryId": category['category']['categoryId'],
            "price": (price!.numberValue * 100).toInt().toString(),
            "date": date.toIso8601String().toString(),
            "userId": id.toString(),
            "homeId": home_id.toString(),
            "paid": is_payed
          }
        ]),
      )
          .then((value) {
        clear_input();
      });
    } on Exception catch (e) {
      print('add_invoice:  nao conseguiu adicionar invoice');
      print(e);
    }

    loading = false;
  }

  @action
  modify_invoice() async {
    loading = true;

    final prefs = await SharedPreferences.getInstance();
    bool? logged = prefs.getBool('is_logged');
    String url = await SharedPreferences.getInstance()
        .then((value) => value.getString('url')!);

    int? id;
    int? home_id;
    if (logged != null && logged) {
      id = prefs.getInt('id');
    }

    try {
      var result = await Dio()
          .post(
        url + 'modify-invoice',
        data: jsonEncode([
          {
            "description": description.text,
            "categoryId": category['category']['categoryId'],
            "price": (price!.numberValue * 100).toInt().toString(),
            "date": date.toIso8601String().toString(),
            "userId": id.toString(),
            "invoiceId": invoice_id.toString(),
            "paid": is_payed
          }
        ]),
      )
          .then((value) {
        description.text = "";
        category = {};
        price!.updateValue(0.00);
        date = DateTime.now();
        is_payed = null;
      });
    } on Exception catch (e) {
      print('modify_invoice:  nao conseguiu modificar invoice');
      print(e);
    }

    is_modify = false;
    loading = false;
  }

  @action
  remove_invoice({required user_id, required invoice_id}) async {
    loading = true;

    final prefs = await SharedPreferences.getInstance();
    bool? logged = prefs.getBool('is_logged');
    String url = await SharedPreferences.getInstance()
        .then((value) => value.getString('url')!);

    int? id;
    int? home_id;
    if (logged != null && logged) {
      id = prefs.getInt('id');
      if (id != user_id) {
        loading = false;
        return;
      }
    }
    print("$id $invoice_id");

    try {
      var result = await Dio().post(
        url + 'remove-invoice',
        data: jsonEncode([
          {
            "userId": id.toString(),
            "invoiceId": invoice_id.toString(),
          }
        ]),
      );
    } on Exception catch (e) {
      print('remove_invoice:  nao conseguiu remover invoice');
      print(e);
    }

    loading = false;
  }

  @action
  calc_total() async {
    final prefs = await SharedPreferences.getInstance();
    bool? logged = prefs.getBool('is_logged');
    String url = await SharedPreferences.getInstance()
        .then((value) => value.getString('url')!);

    int? home_id;
    if (logged != null && logged) {
      home_id = prefs.getInt('home_id');
    }

    int? num_users;
    try {
      var result = await Dio().post(
        url + 'number-users',
        data: jsonEncode([
          {
            "homeId": home_id.toString(),
          }
        ]),
      );

      List<dynamic> data = jsonDecode(result.data);

      num_users = data[0][""]?["count"];
    } on Exception catch (e) {
      print('calc_total:  nao conseguiu obter o numero de users');
      print(e);
    }

    total_invoice = 0;
    any_payed = 0;
    users = [{}];
    category_percents = [{}];
    var aux = [{}];
    var aux_category = [{}];

    invoices?.forEach((element) {
      total_invoice += int.parse(element['invoice']['price']);
      any_payed += element['invoice']['paid'] == false
          ? int.parse(element['invoice']['price'])
          : 0;
      aux[0][element['invoice']['userid']] =
          aux[0][element['invoice']['userid']] == null
              ? {
                  'value': int.parse(element['invoice']['price']),
                  'name': element['users']['name'],
                  'paid': element['invoice']['paid'] == true
                      ? int.parse(element['invoice']['price'])
                      : 0,
                }
              : {
                  'value': aux[0][element['invoice']['userid']]['value']! +
                      int.parse(element['invoice']['price']),
                  'name': element['users']['name'],
                  'paid': element['invoice']['paid'] == true
                      ? aux[0][element['invoice']['userid']]['paid']! +
                          int.parse(element['invoice']['price'])
                      : aux[0][element['invoice']['userid']]['paid']!,
                };

      aux_category[0][element['category']['name']] =
          aux_category[0][element['category']['name']] == null
              ? {
                  'value': int.parse(element['invoice']['price']),
                  'name': element['category']['name']
                }
              : {
                  'value': aux_category[0][element['category']['name']]
                          ['value']! +
                      int.parse(element['invoice']['price']),
                  'name': element['category']['name']
                };
    });

    if (((total_invoice / num_users!) - (any_payed / num_users)) % num_users ==
        0) {
      total_invoice_person =
          ((total_invoice / num_users) - (any_payed / num_users)).toInt();
    } else {
      total_invoice_person =
          ((total_invoice / num_users) - (any_payed / num_users) + 1).toInt();
    }

    aux[0].forEach((id, value) {
      users.add({
        id: ((((value['value'] * 100) / total_invoice)) / 100),
        'r': Random().nextInt(255),
        'g': Random().nextInt(255),
        'b': Random().nextInt(255),
        'name': value['name'],
        'paid': value['paid'],
      });
    });
    users.removeAt(0);

    aux_category[0].forEach((id, value) {
      category_percents.add({
        'value': ((((value['value'] * 100) / total_invoice)) / 100),
        'name': value['name'],
        'r': Random().nextInt(255),
        'g': Random().nextInt(255),
        'b': Random().nextInt(255),
      });
    });
    category_percents.removeAt(0);

    print("User: ${users}");
  }

  @action
  logout() async {
    loading = true;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('id', -1);
    await prefs.setBool('is_logged', false);

    loading = false;

    Modular.to.navigate('/login/');
  }
}
