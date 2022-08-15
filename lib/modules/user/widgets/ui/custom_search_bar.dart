import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextField(
        onChanged: (value) {
          // Method For Searching
        },
        decoration: _decoration(),
      ),
    );
  }

  InputDecoration _decoration() {
    return const InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          borderSide: BorderSide(color: Colors.white),
        ),
        fillColor: Colors.white,
        filled: true,
        hintStyle: TextStyle(fontSize: 15),
        hintText: 'Donde quieres jugar hoy?',
        suffixIcon: Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        isDense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 8));
  }
}
