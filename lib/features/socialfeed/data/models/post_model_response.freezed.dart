// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreatePostResponseModel {

 String get message; PostModel get post;
/// Create a copy of CreatePostResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreatePostResponseModelCopyWith<CreatePostResponseModel> get copyWith => _$CreatePostResponseModelCopyWithImpl<CreatePostResponseModel>(this as CreatePostResponseModel, _$identity);

  /// Serializes this CreatePostResponseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreatePostResponseModel&&(identical(other.message, message) || other.message == message)&&(identical(other.post, post) || other.post == post));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,message,post);

@override
String toString() {
  return 'CreatePostResponseModel(message: $message, post: $post)';
}


}

/// @nodoc
abstract mixin class $CreatePostResponseModelCopyWith<$Res>  {
  factory $CreatePostResponseModelCopyWith(CreatePostResponseModel value, $Res Function(CreatePostResponseModel) _then) = _$CreatePostResponseModelCopyWithImpl;
@useResult
$Res call({
 String message, PostModel post
});


$PostModelCopyWith<$Res> get post;

}
/// @nodoc
class _$CreatePostResponseModelCopyWithImpl<$Res>
    implements $CreatePostResponseModelCopyWith<$Res> {
  _$CreatePostResponseModelCopyWithImpl(this._self, this._then);

  final CreatePostResponseModel _self;
  final $Res Function(CreatePostResponseModel) _then;

/// Create a copy of CreatePostResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? message = null,Object? post = null,}) {
  return _then(_self.copyWith(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,post: null == post ? _self.post : post // ignore: cast_nullable_to_non_nullable
as PostModel,
  ));
}
/// Create a copy of CreatePostResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PostModelCopyWith<$Res> get post {
  
  return $PostModelCopyWith<$Res>(_self.post, (value) {
    return _then(_self.copyWith(post: value));
  });
}
}


/// Adds pattern-matching-related methods to [CreatePostResponseModel].
extension CreatePostResponseModelPatterns on CreatePostResponseModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreatePostResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreatePostResponseModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreatePostResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _CreatePostResponseModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreatePostResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _CreatePostResponseModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String message,  PostModel post)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreatePostResponseModel() when $default != null:
return $default(_that.message,_that.post);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String message,  PostModel post)  $default,) {final _that = this;
switch (_that) {
case _CreatePostResponseModel():
return $default(_that.message,_that.post);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String message,  PostModel post)?  $default,) {final _that = this;
switch (_that) {
case _CreatePostResponseModel() when $default != null:
return $default(_that.message,_that.post);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreatePostResponseModel implements CreatePostResponseModel {
  const _CreatePostResponseModel({required this.message, required this.post});
  factory _CreatePostResponseModel.fromJson(Map<String, dynamic> json) => _$CreatePostResponseModelFromJson(json);

@override final  String message;
@override final  PostModel post;

/// Create a copy of CreatePostResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreatePostResponseModelCopyWith<_CreatePostResponseModel> get copyWith => __$CreatePostResponseModelCopyWithImpl<_CreatePostResponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreatePostResponseModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreatePostResponseModel&&(identical(other.message, message) || other.message == message)&&(identical(other.post, post) || other.post == post));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,message,post);

@override
String toString() {
  return 'CreatePostResponseModel(message: $message, post: $post)';
}


}

/// @nodoc
abstract mixin class _$CreatePostResponseModelCopyWith<$Res> implements $CreatePostResponseModelCopyWith<$Res> {
  factory _$CreatePostResponseModelCopyWith(_CreatePostResponseModel value, $Res Function(_CreatePostResponseModel) _then) = __$CreatePostResponseModelCopyWithImpl;
@override @useResult
$Res call({
 String message, PostModel post
});


@override $PostModelCopyWith<$Res> get post;

}
/// @nodoc
class __$CreatePostResponseModelCopyWithImpl<$Res>
    implements _$CreatePostResponseModelCopyWith<$Res> {
  __$CreatePostResponseModelCopyWithImpl(this._self, this._then);

  final _CreatePostResponseModel _self;
  final $Res Function(_CreatePostResponseModel) _then;

/// Create a copy of CreatePostResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? post = null,}) {
  return _then(_CreatePostResponseModel(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,post: null == post ? _self.post : post // ignore: cast_nullable_to_non_nullable
as PostModel,
  ));
}

/// Create a copy of CreatePostResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PostModelCopyWith<$Res> get post {
  
  return $PostModelCopyWith<$Res>(_self.post, (value) {
    return _then(_self.copyWith(post: value));
  });
}
}

// dart format on
