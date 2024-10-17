import 'package:flutter/material.dart';
import 'package:guardian/data/models/password_schema.dart';
import 'package:guardian/data/repositories/password_repository.dart';
import 'package:guardian/view/screens/password_details_screen.dart';
import 'package:guardian/view/widgets/password_tile.dart';
import 'package:provider/provider.dart';

class CategoryPasswordsScreen extends StatelessWidget {
  final Categories category;
  const CategoryPasswordsScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final passwordRepository = Provider.of<PasswordRepository>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("${category.toString().split(".").last}"),
      ),
      body: FutureBuilder<List<Password>>(
        future: passwordRepository.watchPasswordsByCategory(category),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
                child: Text(
              'No passwords in this category',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 24,
              ),
            ));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final password = snapshot.data![index];
              return PasswordTile(
                password: password,
              );
            },
          );
        },
      ),
    );
  }
}
