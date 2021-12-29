class Food {
  String? thname;
  String? enname;
  int? price;
  String? foodvalue;

  Food(this.thname, this.enname, this.price, this.foodvalue);

  static getFood() {
    return [
      Food('พิซซ่า', 'Pizza', 99, 'pizza'),
      Food('ชาบู', 'Chabu', 89, 'chabu'),
      Food('ซูซิ', 'Sushi', 39, 'sushi'),
      Food('สเต็ก', 'Steak', 69, 'steak'),
      Food('โรตี', 'Roti', 19, 'roti'),
    ];
  }
}
