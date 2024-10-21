import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'package:json_serializable/json_serializable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'card_item.g.dart';

@JsonSerializable()
class CardItem {
  final String uid;
  final String image;
  final String avatar;
  final String title;
  final String user;

  CardItem({
    required this.uid,
    required this.image,
    required this.avatar,
    required this.title,
    required this.user,
  });

  factory CardItem.fromJson(Map<String, dynamic> json) =>_$CardItemFromJson(json);

  Map<String,dynamic> toJson()=> _$CardItemToJson(this);
}

Future<List<CardItem>> fetchCardItems() async {
  final response = await http.get(Uri.parse('http://192.168.0.41:8080/cardlistview'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => CardItem.fromJson(data)).toList();
  } else {
    throw Exception('Failed to load card items');
  }
}
