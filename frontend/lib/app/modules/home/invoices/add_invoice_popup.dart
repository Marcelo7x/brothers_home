import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:frontend/app/modules/home/home_store.dart';
import 'package:frontend/app/modules/home/invoices/invoice_store.dart';
import 'package:frontend/app/modules/home/widget/select_date_popup.dart';
import 'package:frontend/domain/category.dart';
import 'package:intl/intl.dart';

class AddInvoicePopup extends StatefulWidget {
  const AddInvoicePopup({Key? key}) : super(key: key);

  @override
  State<AddInvoicePopup> createState() => _AddInvoicePopupState();
}

class _AddInvoicePopupState extends State<AddInvoicePopup> {
  @override
  Widget build(BuildContext context) {
    final InvoiceStore invoicesController = Modular.get<InvoiceStore>();

    return AlertDialog(
      title: !invoicesController.isModify
          ? const Text("Adicionar Gasto")
          : const Text("Modificar Gasto"),
      contentPadding: const EdgeInsets.all(10),
      actionsPadding: const EdgeInsets.only(bottom: 5, left: 5, right: 5),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      content: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * .5,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Observer(builder: (_) {
                  return DropdownButton(
                    borderRadius: BorderRadius.circular(18),
                    hint: const Text("Selecione uma categoria"),
                    underline: Container(
                      height: 2,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    value: invoicesController.category,
                    items: invoicesController.categories.map((Category e) {
                      return DropdownMenuItem<Category>(
                        value: e,
                        child: Text(toBeginningOfSentenceCase(e.name)!),
                      );
                    }).toList(),
                    onChanged: (Category? e) {
                      invoicesController.setCategory(e!);
                    },
                  );
                }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Selecione o dia: "),
                    GestureDetector(
                      child: Row(
                        children: [
                          Observer(builder: (_) {
                            return Text(
                              "${invoicesController.date.day}/${invoicesController.date.month}/${invoicesController.date.year}",
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary),
                            );
                          }),
                          Padding(
                            padding: const EdgeInsets.only(left: 3),
                            child: Icon(Icons.calendar_month,
                                color: Theme.of(context).colorScheme.primary),
                          )
                        ],
                      ),
                      onTap: () => showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return SelectDatePopup(
                              context: context,
                              invoicesController: invoicesController);
                        },
                      ),
                    ),
                  ],
                ),
                TextField(
                    controller: invoicesController.description,
                    maxLines: 2,
                    maxLength: 100,
                    decoration: const InputDecoration(
                      label: Text("Adicione uma descri????o"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    )),
                TextField(
                    controller: invoicesController.price,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      label: Text("Digite o valor"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    )),
                Observer(builder: (_) {
                  return DropdownButton<bool?>(
                    borderRadius: BorderRadius.circular(18),
                    hint: invoicesController.isPayed == null
                        ? const Text("Em aberto")
                        : invoicesController.isPayed == false
                            ? const Text("Pago por mim")
                            : Text(
                                "pago por todos",
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              ),
                    underline: Container(
                      height: 2,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    value: invoicesController.isPayed,
                    items: const [
                      DropdownMenuItem<bool?>(
                        value: null,
                        child: Text("Em aberto"),
                      ),
                      DropdownMenuItem<bool?>(
                        value: true,
                        child: Text("Pago por mim"),
                      ),
                      DropdownMenuItem<bool?>(
                        value: false,
                        child: Text("Pago por todos"),
                      ),
                    ],
                    onChanged: (bool? e) {
                      invoicesController.setPaid(e);
                    },
                  );
                }),
              ]),
        ),
      ),
      actions: <Widget>[
        // define os bot??es na base do dialogo
        ElevatedButton(
          child: const Text("Adicionar"),
          onPressed: () async {
            if (invoicesController.description.text == "" ||
                invoicesController.category == null ||
                invoicesController.price!.value == 0.00) {
              return;
            }
            print('jklashd');

            !invoicesController.isModify
                ? await invoicesController.addInvoice()
                : await invoicesController.modifyInvoice();

            Navigator.of(context).pop();
            await Modular.get<HomeStore>().reload();
            Modular.to.navigate('/home/');
          },
        ),
        TextButton(
          child: Text(
            "Cancelar",
            style: TextStyle(
              color: Theme.of(context).colorScheme.error,
            ),
          ),
          onPressed: () {
            invoicesController.clearInput();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
