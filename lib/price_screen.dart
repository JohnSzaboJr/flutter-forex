import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'forex_data.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  ForexData forexData = ForexData();
  Map currencies = {
    'from': 'EUR',
    'to': 'EUR',
  };
  double exchanged = 1.0;

  DropdownButton<String> androidDropdown(String location) {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: currencies[location],
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          currencies[location] = value;
        });
        updateData();
      },
    );
  }

  CupertinoPicker iOSPicker(String location) {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        currencies[location] = currenciesList[selectedIndex];
        updateData();
      },
      children: pickerItems,
    );
  }

  void updateData() async {
    var result =
        await forexData.getExchangeRate(currencies['to'], currencies['from']);
    setState(() {
      exchanged = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Currency Exchange'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 ${currencies['from']} = $exchanged ${currencies['to']}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Platform.isIOS ? iOSPicker('from') : androidDropdown('from'),
                Platform.isIOS ? iOSPicker('to') : androidDropdown('to'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
