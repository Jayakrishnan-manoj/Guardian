import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:guardian/data/models/password_schema.dart';
import 'package:guardian/data/repositories/password_repository.dart';
import 'package:guardian/view/constants/colors.dart';
import 'package:guardian/view/constants/constants.dart';
import 'package:guardian/view/widgets/password_tile.dart';
import 'package:provider/provider.dart';

class AllPasswordsScreen extends StatefulWidget {
  const AllPasswordsScreen({super.key});

  @override
  State<AllPasswordsScreen> createState() => _AllPasswordsScreenState();
}

class _AllPasswordsScreenState extends State<AllPasswordsScreen> {
  Categories? selectedCategory;
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final passwordRepository = Provider.of<PasswordRepository>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Saved Passwords"),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onTapOutside: (_) {
                searchFocusNode.unfocus();
              },
              focusNode: searchFocusNode,
              controller: searchController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColors.blueAppColor, width: 2),
                    borderRadius: BorderRadius.circular(15)),
                hintText: "Search",
                hintStyle: TextStyle(color: AppColors.subTextColor),
                prefixIcon: Icon(
                  Icons.search,
                  color: AppColors.blueAppColor,
                ),
                filled: true,
                fillColor: AppColors.tileColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                print(value);
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  // Add "All" ChoiceChip manually
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ChoiceChip(
                      padding: EdgeInsets.all(8),
                      label: Text(
                        "All",
                        style: TextStyle(color: Colors.white),
                      ),
                      selected: selectedCategory == null,
                      onSelected: (bool selected) {
                        setState(() {
                          selectedCategory = null;
                        });
                      },
                      backgroundColor: AppColors.tileColor,
                      selectedColor: AppColors.blueAppColor,
                    ),
                  ),
                  ...Categories.values.map((Categories category) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ChoiceChip(
                        padding: EdgeInsets.all(8),
                        label: Text(
                          category.toString().substring(11),
                          style: TextStyle(color: Colors.white),
                        ),
                        selected: selectedCategory == category,
                        onSelected: (bool selected) {
                          setState(() {
                            selectedCategory = category;
                          });
                        },
                        backgroundColor: AppColors.tileColor,
                        selectedColor: AppColors.blueAppColor,
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
            Gap(10),
            Expanded(
              child: FutureBuilder(
                  future: selectedCategory == null
                      ? passwordRepository.getAllPasswords()
                      : passwordRepository
                          .watchPasswordsByCategory(selectedCategory!),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text("Error Loading Passwords");
                    }
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                          child: Text(
                        "You haven't saved any passwords!",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ));
                    }

                    final passwords = snapshot.data!
                        .where((password) =>
                            password.title.toLowerCase().startsWith(searchQuery))
                        .toList();
                    return ListView.builder(
                        itemCount: passwords.length,
                        itemBuilder: (context, index) {
                          final password = passwords[index];
                          return PasswordTile(
                            password: password,
                          );
                        });
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
