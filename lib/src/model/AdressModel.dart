class Adress{
  final String adress;
  final String nation;
  final String state;
  final String postpin;
  final String city;


  Adress({required this.adress,required this.nation,required this.state,required this.postpin,required this.city});

  static Adress fromjson(Map<String,dynamic>json) =>Adress(adress:json['adress'], nation:json['nation'], state:json['state'], postpin:json['postpin'], city:json['city']);
  
}