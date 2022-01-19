import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqlite_app/routes/app_routes.dart';
import '../models/user.dart';
import '../provider/users.dart';
import '../components/user_tile.dart';
import '../data/dummy_users.dart';

class UserList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Users users = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('list of user'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.USER_FORM);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: ListView.builder(
        itemBuilder: (ctx, i) => UserTile(users.byIndex(i)),
        itemCount: users.count,
      ),
    );
  }
}
