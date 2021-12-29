class Drink {
  String? thname;
  int? price;
  bool? checked;

  Drink(this.thname, this.price, this.checked);

  static getDrink() {
    return [
      Drink('กาแฟดำ', 99, true),
      Drink('คาราเมล', 89, false),
      Drink('โกโก้', 39, false),
      Drink('ชาเขียว', 69, false),
      Drink('ชาไทย', 19, false),
    ];
  }
}
