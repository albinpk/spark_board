import 'dart:async';
import 'dart:convert';

import '../utils/common.dart';

part 'user_provider.g.dart';

@riverpod
class User extends _$User {
  @override
  UserData? build() {
    final token = ref.storage.getString(StorageConstants.token);
    if (token == null) return null;
    final data = _decode(token);
    if (data == null) return null;
    final tokenData = UserData.fromJson(data);
    ref.keepAlive();
    return tokenData;
  }

  Json<dynamic>? _decode(String token) {
    final splitToken = token.split('.');
    if (splitToken.length != 3) {
      L.severe('AuthToken: Invalid token');
      return null;
    }
    try {
      final payloadBase64 = splitToken[1];
      final normalizedPayload = base64.normalize(payloadBase64);
      final payloadString = utf8.decode(base64.decode(normalizedPayload));
      final decodedPayload = jsonDecode(payloadString);
      return decodedPayload as Json<dynamic>;
    } catch (e) {
      L.severe('AuthToken: Invalid payload', e);
      return null;
    }
  }

  Future<void> logout() async {
    await ref.storage.clear();
    ref.go(const LoginRoute().location);
    Future.delayed(const Duration(seconds: 1), ref.invalidateSelf);
  }
}

class UserData {
  const UserData({
    required this.userId,
    required this.name,
    required this.email,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      userId: json['userId'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
    );
  }

  final String userId;
  final String name;
  final String email;

  @override
  String toString() => 'TokenData(userId: $userId,name: $name,email: $email)';
}
