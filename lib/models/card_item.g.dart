// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardItem _$CardItemFromJson(Map<String, dynamic> json) => CardItem(
      uid: json['uid'] as String,
      image: json['image'] as String,
      avatar: json['avatar'] as String,
      title: json['title'] as String,
      user: json['user'] as String,
    );

Map<String, dynamic> _$CardItemToJson(CardItem instance) => <String, dynamic>{
      'uid': instance.uid,
      'image': instance.image,
      'avatar': instance.avatar,
      'title': instance.title,
      'user': instance.user,
    };
