import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:frontend/app/modules/home/home_store.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

Widget SelectRageDatePopup(BuildContext context, HomeStore homeController, invoicesController) {
  return AlertDialog(
    title: const Text("Selecione o intevalo"),
    content: SfDateRangePicker(
      view: DateRangePickerView.year,
      initialSelectedRange: homeController.dateRange,
      selectionMode: DateRangePickerSelectionMode.range,
      onSelectionChanged: (DateRangePickerSelectionChangedArgs date) =>
          homeController.set_dateRange(date.value),
    ),
    actions: <Widget>[
      // define os botões na base do dialogo
      ElevatedButton(
        child: const Text("Confirmar"),
        onPressed: () {
          invoicesController.get_invoices();
          Navigator.of(context).pop();
        },
      ),
    ],
  );
}

Widget SelectDateInterval(BuildContext context, HomeStore homeController, invoicesController) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text("Intervalo: "),
      GestureDetector(
        child: Observer(builder: (_) {
          return Text(
              "${homeController.dateRange.startDate?.day}/${homeController.dateRange.startDate?.month}/${homeController.dateRange.startDate?.year} a ${homeController.dateRange.endDate?.day}/${homeController.dateRange.endDate?.month}/${homeController.dateRange.endDate?.year}",
              style: TextStyle(color: Theme.of(context).colorScheme.primary));
        }),
        onTap: () => showDialog(
          context: context,
          builder: (BuildContext context) {
            return SelectRageDatePopup(context, homeController, invoicesController);
          },
        ),
      ),
      GestureDetector(
        onTap: () => showDialog(
          context: context,
          builder: (BuildContext context) {
            return SelectRageDatePopup(context, homeController, invoicesController);
          },
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Icon(
            Icons.calendar_month,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    ],
  );
}
