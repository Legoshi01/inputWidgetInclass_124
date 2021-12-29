import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inputwidgets/models/drink.dart';
import 'package:inputwidgets/models/food.dart';

class Inputwidgets extends StatefulWidget {
  const Inputwidgets({Key? key}) : super(key: key);

  @override
  _InputwidgetsState createState() => _InputwidgetsState();
}

class _InputwidgetsState extends State<Inputwidgets> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _username = TextEditingController();
  TextEditingController _pasw = TextEditingController();

  String? groupfood;
  List<Food>? foods;

  List checkDrink = [];
  List<Drink>? drinks;
//DD
  List<ListItem>? types = ListItem.getItem();
  late List<DropdownMenuItem<ListItem>> _dropdownMenuItem;
  late ListItem _selectedTypeItem;

//
  @override
  void initState() {
    super.initState();
    foods = Food.getFood();
    drinks = Drink.getDrink();
    _dropdownMenuItem = createDropdownMenuItem(types!);
    _selectedTypeItem = _dropdownMenuItem[0].value!;

    print(foods);
  }

  List<DropdownMenuItem<ListItem>> createDropdownMenuItem(
      List<ListItem> types) {
    List<DropdownMenuItem<ListItem>> items = [];

    for (var item in types) {
      items.add(DropdownMenuItem(
        child: Text(item.name!),
        value: item,
      ));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(child: Text('Input Widgets')),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          decoration: BoxDecoration(
              // gradient: LinearGradient(
              //     begin: Alignment.centerLeft,
              //     end: Alignment.centerRight,
              //     colors: [Colors.white, Colors.blue, Colors.purple]
              //     )

              //     gradient: RadialGradient(
              //   colors: [Colors.yellow, Colors.deepPurple],
              // )
              gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  // Add one stop for each color
                  // Values should increase from 0.0 to 1.0
                  stops: [
                0.1,
                0.5,
                0.8,
                0.9
              ],
                  colors: [
                Colors.red,
                Colors.yellow,
                Colors.blue,
                Colors.purple
              ])),
          child: ListView(
            children: [
              textfield(),
              textfieldpasw(),
              const SizedBox(height: 16),
              dropdown(),
              Center(
                  child: Text('Dropdown selected: ${_selectedTypeItem.name}',
                      style: GoogleFonts.itim(
                          textStyle:
                              TextStyle(color: Colors.black, fontSize: 20)))),

              Column(
                children: createRadioFood(),
              ),
              // Text(groupfood.toString()),
              Center(
                  child: Text('Radio Selected: $groupfood',
                      style: GoogleFonts.itim(
                          textStyle:
                              TextStyle(color: Colors.black, fontSize: 20)))),

              const SizedBox(height: 20),
              Column(
                children: createCheckboxDrink(),
              ),
              submitBT(),
            ],
          ),
        ),
      ),
    );
  }

  Center dropdown() {
    return Center(
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
          child: DropdownButton(
            items: _dropdownMenuItem,
            value: _selectedTypeItem,
            onChanged: (ListItem? value) {
              setState(() {
                _selectedTypeItem = value!;
              });
            },
          ),
        ),
      ),
    );
  }

  Widget submitBT() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(150, 5, 150, 5),
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            print(_username.text + '  ' + _pasw.text);
          }
        },
        child: Text('Submit'),
      ),
    );
  }

  Widget textfield() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
        child: TextFormField(
          style: TextStyle(color: Colors.purple),
          controller: _username,
          validator: (vaLue) {
            if (vaLue!.isEmpty) {
              return "please enter username";
            }
            return null;
          },
          decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              labelText: 'Username',
              prefixIcon: Icon(Icons.person),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(32)),
              )),
        ),
      ),
    );
  }

  Widget textfieldpasw() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
      child: TextFormField(
        obscureText: true,
        obscuringCharacter: '*',
        controller: _pasw,
        validator: (vaLue) {
          if (vaLue!.isEmpty) {
            return "please enter your password";
          }
          return null;
        },
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            labelText: 'Password',
            prefixIcon: Icon(Icons.vpn_key),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(32)),
            )),
      ),
    );
  }

  List<Widget> createRadioFood() {
    List<Widget> listFood = [];

    for (var food in foods!) {
      listFood.add(
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(color: Colors.white),
            child: RadioListTile<dynamic>(
              title: Text(
                food.thname!,
                style:
                    GoogleFonts.itim(textStyle: TextStyle(color: Colors.black)),
              ),
              subtitle: Text(
                food.enname!,
                style:
                    GoogleFonts.itim(textStyle: TextStyle(color: Colors.black)),
              ),
              secondary: Text(
                '${food.price} บาท',
                style:
                    GoogleFonts.itim(textStyle: TextStyle(color: Colors.black)),
              ),
              value: food.foodvalue!,
              groupValue: groupfood,
              onChanged: (value) {
                setState(() {
                  groupfood = value;
                });
              },
            ),
          ),
        ),
      );
    }

    return listFood;
  }

  List<Widget> createCheckboxDrink() {
    List<Widget> listDrink = [];

    for (var drink in drinks!) {
      listDrink.add(
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(color: Colors.white),
            child: CheckboxListTile(
              value: drink.checked,
              title: Text(drink.thname!),
              subtitle: Text('${drink.price} บาท'),
              onChanged: (value) {
                setState(() {
                  drink.checked = value;
                });
              },
            ),
          ),
        ),
      );
    }
    return listDrink;
  }
}

class ListItem {
  int? value;
  String? name;

  ListItem(this.value, this.name);

  static getItem() {
    return [
      ListItem(1, 'อาหารปักษ์ใต้'),
      ListItem(2, 'อาหารอีสาน'),
      ListItem(3, 'อาหารต่างชาติ'),
      ListItem(4, 'อาหารเหนือ'),
    ];
  }

  // void add(DropdownMenuItem dropdownMenuItem) {}
}
