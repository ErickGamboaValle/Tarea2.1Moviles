import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var textController = TextEditingController();
  int selectedRadio = 0;
  bool switchEnabled = false;
  var tipController = TextEditingController();
  var radioGroup = {
    0: "Amazing 20%",
    1: "Good 18%",
    2: "Okay 15%",
  };
  double tip = 0.0;
  tipCalculation() {
    var cost_of_service = double.parse(textController.text ?? "0");
    if (selectedRadio == 0) {
      tip = cost_of_service * 1.20;
    } else if (selectedRadio == 1) {
      tip = cost_of_service * 1.18;
    } else {
      tip = cost_of_service * 1.15;
    }
    if (switchEnabled) {
      tip = tip.ceilToDouble();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tip time'),
      ),
      body: ListView(
        children: [
          SizedBox(height: 14),
          ListTile(
            leading: Icon(Icons.room_service),
            title: Padding(
              padding: EdgeInsets.only(right: 24),
              child: TextField(
                controller: textController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Ingresar propina",
                    border: OutlineInputBorder()),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.dinner_dining),
            title: Text("How was the service?"),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: radioGroup.entries
                .map((element) => ListTile(
                      leading: Radio(
                          value: element.key,
                          groupValue: selectedRadio,
                          onChanged: (CurrentSelectedRadio) {
                            selectedRadio = CurrentSelectedRadio;
                            setState(() {});
                          }),
                      title: Text("${element.value}"),
                    ))
                .toList(),
          ),
          ListTile(
            leading: Icon(Icons.credit_card),
            title: Text("Round up tip"),
            trailing: Switch(
                value: switchEnabled,
                onChanged: (switchstate) {
                  switchEnabled = switchstate;
                  setState(() {});
                }),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: MaterialButton(
                      child: Text(
                        "CALCULATE",
                        style: TextStyle(color: Colors.grey[200]),
                      ),
                      onPressed: () {
                        tipCalculation();
                        setState(() {});
                        print("Valor del text field: ${textController.text}");
                      },
                      color: Colors.green),
                ),
              ),
            ],
          ),
          Text("Tip amount: \$${tip.toStringAsFixed(2)}"),
        ],
      ),
    );
  }
}
