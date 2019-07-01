// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) {
  return Event(
      json['id'] as String,
      json['type'] as String,
      json['actor'] == null
          ? null
          : Actor.fromJson(json['actor'] as Map<String, dynamic>),
      json['repo'] == null
          ? null
          : EventRepo.fromJson(json['repo'] as Map<String, dynamic>),
      json['payload'] == null
          ? null
          : Payload.fromJson(json['payload'] as Map<String, dynamic>),
      json['public'] as bool,
      json['created_at'] as String);
}

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'actor': instance.actor,
      'repo': instance.repo,
      'payload': instance.payload,
      'public': instance.public,
      'created_at': instance.createdAt
    };

Actor _$ActorFromJson(Map<String, dynamic> json) {
  return Actor(
      json['id'] as int,
      json['login'] as String,
      json['display_login'] as String,
      json['gravatar_id'] as String,
      json['url'] as String,
      json['avatar_url'] as String);
}

Map<String, dynamic> _$ActorToJson(Actor instance) => <String, dynamic>{
      'id': instance.id,
      'login': instance.login,
      'display_login': instance.displayLogin,
      'gravatar_id': instance.gravatarId,
      'url': instance.url,
      'avatar_url': instance.avatarUrl
    };

EventRepo _$EventRepoFromJson(Map<String, dynamic> json) {
  return EventRepo(
      json['id'] as int, json['name'] as String, json['url'] as String);
}

Map<String, dynamic> _$EventRepoToJson(EventRepo instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'url': instance.url
    };

Payload _$PayloadFromJson(Map<String, dynamic> json) {
  return Payload(json['action'] as String);
}

Map<String, dynamic> _$PayloadToJson(Payload instance) =>
    <String, dynamic>{'action': instance.action};
