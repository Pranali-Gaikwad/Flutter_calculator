import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Simple Interest Calculator Application',
    home: SimpleInterest(),
    theme: ThemeData(
        primaryColor: Colors.indigo, accentColor: Colors.indigoAccent),
  ));
}

class SimpleInterest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SimpleInterestState();
  }
}

class _SimpleInterestState extends State<SimpleInterest> {
  var _currencies = ['Rupees', 'Dollar', 'Pounds'];
  final _minPadding = 5.0;
  var _displayResult = '';
  var _currentDropdownItemSelected = '';
  var _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _currentDropdownItemSelected = _currencies[0];
  }

  TextEditingController principalController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController yearController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.headline6;
    return Scaffold(
        appBar: AppBar(
          title: Text('Simple Interest Calculator'),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(_minPadding * 2),
            child: ListView(
              children: [
                getImageAsset(),
                Padding(
                    padding:
                        EdgeInsets.only(top: _minPadding, bottom: _minPadding),
                    child: TextFormField(
                      style: textStyle,
                      controller: principalController,
                      keyboardType: TextInputType.number,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Enter principal Amount';
                        } else if (double.parse(value) > 99999999999.0) {
                          return 'Enter Principal Amount below 99999999999';
                        }
                        return 'Enter Valid Principal Amount';
                      },
                      decoration: InputDecoration(
                          labelText: "Principal",
                          labelStyle: textStyle,
                          hintText: "Enter principal Amt e.g 12000",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    )),
                Padding(
                    padding:
                        EdgeInsets.only(top: _minPadding, bottom: _minPadding),
                    child: TextFormField(
                      style: textStyle,
                      controller: rateController,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Enter Rate Percentage';
                        }else if(double.parse(value)>= 100.0){
                          return 'Enter Rate Percentage below 100';
                        }
                        return 'Enter Valid Rate Percentage';
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "Enter Interest",
                          hintText: "In percent",
                          labelStyle: textStyle,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    )),
                Padding(
                    padding:
                        EdgeInsets.only(top: _minPadding, bottom: _minPadding),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            style: textStyle,
                            controller: yearController,
                            keyboardType: TextInputType.number,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'Enter term in Years';
                              } return 'Enter Valid term';
                            },
                            decoration: InputDecoration(
                                labelText: "Term",
                                labelStyle: textStyle,
                                hintText: "Enter Term in years",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0))),
                          ),
                        ),
                        Container(
                          width: _minPadding * 5,
                        ),
                        Expanded(
                            child: DropdownButton<String>(
                          items: _currencies.map((String newValue) {
                            return DropdownMenuItem<String>(
                              value: newValue,
                              child: Text(newValue),
                            );
                          }).toList(),
                          value: _currentDropdownItemSelected,
                          onChanged: (String newValueSelected) {
                            _onSelectingDropDown(newValueSelected);
                          },
                        )),
                      ],
                    )),
                Padding(
                    padding:
                        EdgeInsets.only(top: _minPadding, bottom: _minPadding),
                    child: Row(
                      children: [
                        Expanded(
                          child: RaisedButton(
                              color: Theme.of(context).accentColor,
                              child: Text("Calculate", style: textStyle),
                              onPressed: () {
                                setState(() {
                                  if (_formKey.currentState.validate()) {
                                    _displayResult = _calculateTotalAmt();
                                  }
                                });
                              }),
                        ),
                        Expanded(
                          child: RaisedButton(
                              child: Text(
                                "Reset",
                                style: textStyle,
                              ),
                              onPressed: () {
                                setState(() {
                                  _reset();
                                });
                              }),
                        ),
                      ],
                    )),
                Padding(
                  padding:
                      EdgeInsets.only(top: _minPadding, bottom: _minPadding),
                  child: Text(
                    _displayResult,
                    style: textStyle,
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('images/money.jpg');
    Image image = Image(
      image: assetImage,
      width: 200.0,
      height: 200.0,
    );
    return Container(
      child: image,
      margin: EdgeInsets.all(_minPadding * 5),
    );
  }

  void _onSelectingDropDown(String newValueSelected) {
    setState(() {
      this._currentDropdownItemSelected = newValueSelected;
    });
  }

  String _calculateTotalAmt() {
    double principal = double.parse(principalController.text);
    double rate = double.parse(rateController.text);
    double time = double.parse(yearController.text);
    double totalAmtPayable = principal + (principal * rate * time) / 100;
    String result =
        'After $time your investment will be $totalAmtPayable in $_currentDropdownItemSelected';
    return result;
  }

  void _reset() {
    principalController.text = '';
    rateController.text = '';
    yearController.text = '';
    _currentDropdownItemSelected = _currencies[0];
    _displayResult = '';
  }
}
