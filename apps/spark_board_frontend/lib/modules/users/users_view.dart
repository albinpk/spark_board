import 'package:flutter/material.dart';
import 'package:flutter_cora_riverpod/flutter_cora_riverpod.dart';

import 'users_state.dart';

class UsersView extends CoraConsumerView<UsersState> {
  const UsersView({super.key});

  @override
  UsersState createState() => UsersState();

  @override
  Widget build(BuildContext context, UsersState state) {
    return const Scaffold(
      body: Center(
        child: Text('Users'),
      ),
    );
  }
}
