import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:frontend/app/modules/home/home_store.dart';
import 'package:frontend/app/modules/home/widget/addInvoicePopup.dart';
import 'package:frontend/app/modules/home/widget/selectDate.dart';
import 'package:frontend/app/modules/home/widget/selectRageDate.dart';
import 'package:frontend/app/modules/home/widget/showInformationPopup.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeStore> {
  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    Intl.defaultLocale = 'pt_BR';
    var numberFormat = NumberFormat('##0.00');

    var id = Modular.args.data;
    var logo = AssetImage("images/logo.png");

    controller.get_invoices();

    //Calendario para selecionar range de datas
    // void _selectRageDate() async {
    //   showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       // retorna um objeto do tipo Dialog
    //       return AlertDialog(
    //         title: const Text("Selecione o intevalo"),
    //         content: SfDateRangePicker(
    //           view: DateRangePickerView.year,
    //           initialSelectedRange: controller.dateRange,
    //           selectionMode: DateRangePickerSelectionMode.range,
    //           onSelectionChanged: (DateRangePickerSelectionChangedArgs date) =>
    //               controller.set_dateRange(date.value),
    //         ),
    //         actions: <Widget>[
    //           // define os botões na base do dialogo
    //           ElevatedButton(
    //             child: Text("Confirmar"),
    //             onPressed: () {
    //               controller.get_invoices();
    //               Navigator.of(context).pop();
    //             },
    //           ),
    //         ],
    //       );
    //     },
    //   );
    // }

    // void _selectDate() {
    //   showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       // retorna um objeto do tipo Dialog
    //       return AlertDialog(
    //         title: const Text("Selecione o dia"),
    //         content: SfDateRangePicker(
    //           view: DateRangePickerView.month,
    //           selectionMode: DateRangePickerSelectionMode.single,
    //           onSelectionChanged: (DateRangePickerSelectionChangedArgs date) =>
    //               controller.set_date(date.value),
    //         ),
    //         actions: <Widget>[
    //           // define os botões na base do dialogo
    //           TextButton(
    //             child: Text("Fechar"),
    //             onPressed: () {
    //               Navigator.of(context).pop();
    //             },
    //           ),
    //         ],
    //       );
    //     },
    //   );
    // }

    //adicionar conta
    // void _addInvoicePopup({modify = false}) async {
    //   showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    // retorna um objeto do tipo Dialog
    // return AlertDialog(
    //   title: !modify
    //       ? const Text("Adicionar Gasto")
    //       : const Text("Modificar Gasto"),
    //   contentPadding: const EdgeInsets.all(10),
    //   actionsPadding: const EdgeInsets.only(bottom: 5, left: 5, right: 5),
    //   actionsAlignment: MainAxisAlignment.spaceBetween,
    //   content: SingleChildScrollView(
    //     child: Container(
    //       height: _height * .4,
    //       child: Column(
    //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //           children: [
    //             TextField(
    //                 controller: controller.category,
    //                 decoration: const InputDecoration(
    //                   label: Text("Adicione uma categoria"),
    //                   border: OutlineInputBorder(
    //                       borderRadius:
    //                           BorderRadius.all(Radius.circular(20))),
    //                 )),
    //             TextField(
    //                 controller: controller.description,
    //                 decoration: const InputDecoration(
    //                   label: Text("Adicione uma descrição"),
    //                   border: OutlineInputBorder(
    //                       borderRadius:
    //                           BorderRadius.all(Radius.circular(20))),
    //                 )),
    //             Row(
    //               children: [
    //                 const Text("Selecione o dia: "),
    //                 GestureDetector(
    //                   child: Row(
    //                     children: [
    //                       Observer(builder: (_) {
    //                         return Text(
    //                           "${controller.date.day}/${controller.date.month}/${controller.date.year}",
    //                           style: const TextStyle(
    //                               color: Colors.blueAccent),
    //                         );
    //                       }),
    //                       const Padding(
    //                         padding: EdgeInsets.only(left: 3),
    //                         child: Icon(Icons.calendar_month,
    //                             color: Colors.blueAccent),
    //                       )
    //                     ],
    //                   ),
    //                   onTap: () => showDialog(
    //                     context: context,
    //                     builder: (BuildContext context) {
    //                       return SelectData();
    //                     },
    //                   ),
    //                 ),
    //               ],
    //             ),
    //             TextField(
    //                 controller: controller.price,
    //                 keyboardType: TextInputType.number,
    //                 decoration: const InputDecoration(
    //                   label: Text("Digite o valor"),
    //                   border: OutlineInputBorder(
    //                       borderRadius:
    //                           BorderRadius.all(Radius.circular(20))),
    //                 )),
    //           ]),
    //     ),
    //   ),
    //   actions: <Widget>[
    //     // define os botões na base do dialogo
    //     ElevatedButton(
    //       child: Text("Adicionar"),
    //       onPressed: () async {
    //         !modify
    //             ? await controller.add_invoice()
    //             : await controller.modify_invoice();

    //         Navigator.of(context).pop();
    //         Modular.to.navigate('/home/');
    //       },
    //     ),
    //     TextButton(
    //       child: Text(
    //         "Cancelar",
    //         style: TextStyle(
    //           color: Theme.of(context).colorScheme.error,
    //         ),
    //       ),
    //       onPressed: () {
    //         Navigator.of(context).pop();
    //       },
    //     ),
    //   ],
    // );
    //     },
    //   );
    // }

    // void _show_information(var e) {
    //   showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       // retorna um objeto do tipo Dialog
    //       return Observer(builder: (_) {
    //         return AlertDialog(
    //           content: SizedBox(
    //             height: _height * .4,
    //             child: Column(
    //               children: [
    //                 Column(
    //                   crossAxisAlignment: CrossAxisAlignment.center,
    //                   children: [
    //                     Row(
    //                       mainAxisAlignment: MainAxisAlignment.center,
    //                       children: [
    //                         const Padding(
    //                           padding: EdgeInsets.only(right: 3, top: 7),
    //                           child: Text(
    //                             "R\$",
    //                             style: TextStyle(
    //                               fontSize: 14,
    //                               fontWeight: FontWeight.normal,
    //                             ),
    //                           ),
    //                         ),
    //                         Text(
    //                           "${(numberFormat.format(int.parse(e['invoice']['price']) / 100))}",
    //                           style: const TextStyle(
    //                             fontSize: 32,
    //                             fontWeight: FontWeight.bold,
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                     const Padding(
    //                         padding: EdgeInsets.only(
    //                       left: 5,
    //                     )),
    //                     Text(
    //                       "${e['invoice']['date'].day}/${e['invoice']['date'].month}/${e['invoice']['date'].year}",
    //                       style: const TextStyle(
    //                         fontSize: 14,
    //                         fontWeight: FontWeight.normal,
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //                 Padding(
    //                   padding: const EdgeInsets.all(20),
    //                   child: Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                     children: [
    //                       Column(
    //                           mainAxisAlignment: MainAxisAlignment.center,
    //                           children: [
    //                             const Text(
    //                               "Categoria",
    //                               style: TextStyle(
    //                                 fontSize: 14,
    //                                 fontWeight: FontWeight.normal,
    //                               ),
    //                             ),
    //                             Text(
    //                               e['invoice']['category'].toString(),
    //                               style: const TextStyle(
    //                                 fontSize: 20,
    //                                 fontWeight: FontWeight.bold,
    //                               ),
    //                             ),
    //                           ]),
    //                       Column(
    //                           mainAxisAlignment: MainAxisAlignment.center,
    //                           children: [
    //                             const Text(
    //                               "Usuário",
    //                               style: TextStyle(
    //                                 fontSize: 14,
    //                                 fontWeight: FontWeight.normal,
    //                               ),
    //                             ),
    //                             Text(
    //                               e['users']['name'].toString(),
    //                               style: const TextStyle(
    //                                 fontSize: 20,
    //                                 fontWeight: FontWeight.bold,
    //                               ),
    //                             ),
    //                           ]),
    //                     ],
    //                   ),
    //                 ),
    //                 Column(
    //                   children: [
    //                     const Text(
    //                       "Descrição",
    //                       style: TextStyle(
    //                         fontSize: 14,
    //                         fontWeight: FontWeight.normal,
    //                       ),
    //                     ),
    //                     Text(
    //                       e['invoice']['description'].toString(),
    //                       style: const TextStyle(
    //                         fontSize: 20,
    //                         fontWeight: FontWeight.bold,
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ],
    //             ),
    //           ),
    //           actions: <Widget>[
    //             e['invoice']['userid'] == controller.id
    //                 ? ElevatedButton(
    //                     onPressed: () async {
    //                       controller.modify(e);
    //                       _addInvoicePopup(modify: true);
    //                       controller.is_modify = false;
    //                     },
    //                     child: Row(
    //                       children: const [
    //                         Icon(Icons.edit_road),
    //                         Text("Editar"),
    //                       ],
    //                     ),
    //                   )
    //                 : Container(),
    //             e['invoice']['userid'] == controller.id
    //                 ? ElevatedButton(
    //                     onPressed: () {
    //                       showDialog(
    //                           context: context,
    //                           builder: (BuildContext context) {
    //                             // retorna um objeto do tipo Dialog
    //                             return AlertDialog(
    //                               title: const Text(
    //                                   "Tem certeza que deseja excluir essa conta?"),
    //                               actions: <Widget>[
    //                                 TextButton(
    //                                   onPressed: () async {
    //                                     await controller.remove_invoice(
    //                                         user_id: e['invoice']['userid'],
    //                                         invoice_id: e['invoice']
    //                                             ['invoiceid']);

    //                                     Navigator.of(context).pop();
    //                                     Navigator.of(context).pop();

    //                                     await controller.get_invoices();
    //                                   },
    //                                   child: const Text("Sim"),
    //                                 ),
    //                                 ElevatedButton(
    //                                   onPressed: () {
    //                                     Navigator.of(context).pop();
    //                                   },
    //                                   child: Text("Cancelar"),
    //                                 ),
    //                               ],
    //                             );
    //                           });
    //                     },
    //                     child: Row(
    //                       children: const [
    //                         Icon(Icons.delete),
    //                         Text("Excluir"),
    //                       ],
    //                     ),
    //                   )
    //                 : Container(),
    //             TextButton(
    //               onPressed: () {
    //                 Navigator.of(context).pop();
    //               },
    //               child: const Text("Fechar"),
    //             ),
    //           ],
    //         );
    //       });
    //     },
    //   );
    // }

    // Lista de contas
    List<Widget> _listWidget = <Widget>[
      Container(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                //header
                height: _height * 0.1,
                width: _width * 0.9,
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.money_off),
                        Text(
                          "Contas do mês",
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          child: Observer(builder: (_) {
                            return Text(
                                "Intervalo: ${controller.dateRange.startDate?.day}/${controller.dateRange.startDate?.month}/${controller.dateRange.startDate?.year} a ${controller.dateRange.endDate?.day}/${controller.dateRange.endDate?.month}/${controller.dateRange.endDate?.year}");
                          }),
                          onTap: () => showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return SelectRageData();
                            },
                          ),
                        ),
                        GestureDetector(
                          onTap: () => showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return SelectRageData();
                            },
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Icon(
                              Icons.calendar_month,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Observer(builder: (_) {
                return Container(
                  height: _height * .75,
                  width: _width * .95,
                  margin: const EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: controller.invoices != null &&
                          !controller.loading &&
                          controller.invoices!.isNotEmpty
                      ? RefreshIndicator(
                          onRefresh: () async =>
                              await controller.get_invoices(),
                          child: ListView(
                            children: controller.invoices!
                                .map(
                                  (e) => GestureDetector(
                                    onTap: () async {
                                      await controller.set_select_invoice(e);
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return ShowInformationPopup();
                                        },
                                      );
                                    },
                                    child: Container(
                                      height: 65,
                                      //margin: EdgeInsets.only(top: 5),
                                      padding:
                                          EdgeInsets.fromLTRB(20, 0, 20, 0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                height: 50,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          e['invoice']
                                                                  ['category']
                                                              .toString(),
                                                          style: const TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        const Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 5)),
                                                        Text(
                                                          "${e['invoice']['date'].day}/${e['invoice']['date'].month}",
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      e['users']['name']
                                                          .toString(),
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  const Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 5, top: 7),
                                                    child: Text(
                                                      "R\$",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    "${(numberFormat.format(int.parse(e['invoice']['price']) / 100))}",
                                                    style: const TextStyle(
                                                      fontSize: 28,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 5),
                                            child: Divider(
                                              height: 5,
                                              thickness: 1,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onPrimary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        )
                      : controller.invoices != null &&
                              controller.invoices!.isEmpty
                          ? RefreshIndicator(
                              onRefresh: () async =>
                                  await controller.get_invoices(),
                              child: const Center(
                                  child: Text("Ainda não há contas")))
                          : const CircularProgressIndicator(),
                );
              })
            ],
          ),
        ),
      ),
      SafeArea(
        child: Column(
          children: [
            Container(
              //header
              height: _height * 0.1,
              width: _width * 0.9,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.graphic_eq),
                      Text(
                        "Balanço",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        child: Observer(builder: (_) {
                          return Text(
                              "Intervalo: ${controller.dateRange.startDate?.day}/${controller.dateRange.startDate?.month}/${controller.dateRange.startDate?.year} a ${controller.dateRange.endDate?.day}/${controller.dateRange.endDate?.month}/${controller.dateRange.endDate?.year}");
                        }),
                        onTap: () => showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return SelectRageData();
                          },
                        ),
                      ),
                      GestureDetector(
                        onTap: () => showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return SelectRageData();
                          },
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Icon(
                            Icons.calendar_month,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Observer(builder: (_) {
              return Container(
                height: _height * .75,
                width: _width * .95,
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Text("Total do período: R\$ "),
                        ),
                        Text(
                          "${numberFormat.format(controller.total_invoice / 100)}",
                          style: const TextStyle(
                            fontSize: 28,
                            //fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Text("Valor por morador: R\$ "),
                        ),
                        Text(
                          "${numberFormat.format(controller.total_invoice_person / 100)}",
                          style: const TextStyle(
                            fontSize: 28,
                            //fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        "Gasto por Morador",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Wrap(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        children: controller.users.map((e) {
                      return Container(
                        height: 30,
                        margin: EdgeInsets.fromLTRB(10, 20, 10, 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color.fromARGB(
                              255,
                              e['r'],
                              e['g'],
                              e['b'],
                            ),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: 120,
                        child: Text(
                          e['name'].toString().toUpperCase() +
                              " ${(e.values.first * 100).round().toString()}%",
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      );
                    }).toList()),
                    Container(
                      width: _width * .8,
                      height: 25,
                      margin: EdgeInsets.only(top: 5),
                      child: Row(
                        children: controller.users
                            .map(
                              (e) => Container(
                                height: 25,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(
                                    255,
                                    e['r'],
                                    e['g'],
                                    e['b'],
                                  ),
                                ),
                                width: _width * .8 * (e.values.first),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
      SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 30,
              width: 100,
              child: ElevatedButton(
                  child: Text("Sair"),
                  onPressed: () {
                    controller.logout();
                  }),
            ),
          ],
        ),
      ),
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Observer(builder: (_) {
        return Container(
          width: _width,
          height: _height,
          child: PageView(
            controller: controller.page_controller,
            children: _listWidget,
            onPageChanged: (index) => controller.setIndex(index),
          ),
        );
      }),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).scaffoldBackgroundColor,
        shape: const CircularNotchedRectangle(),
        child: Container(
          width: _width,
          child: Row(
            children: [
              Container(
                width: _width * 0.75,
                child: Observer(builder: (_) {
                  return BottomNavigationBar(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    elevation: 0,
                    currentIndex: controller.selectedIndex,
                    onTap: (index) => controller.setPageAndIndex(index),
                    items: const [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.money_off),
                        label: "Contas",
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.graphic_eq),
                        label: "Balanço",
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.settings),
                        label: "Opções",
                      ),
                    ],
                  );
                }),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (BuildContext context) {
            return AddInvoicePopup();
          },
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}
