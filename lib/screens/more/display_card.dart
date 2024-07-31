import 'package:flutter/material.dart';

displayCard(context, title, page, cardIcon) {
  return GestureDetector(
    onTap: () => {
      Navigator.push(context, MaterialPageRoute(builder: (context) => page)),
    },
    child: Padding(
      padding: const EdgeInsets.only(
        left: 10.0,
        right: 10.0,
      ),
      child: Card(
        elevation: 0,
        margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: SizedBox(
          width: double.infinity,
          child: ListTile(
            leading: cardIcon,
            title: Text(title),
            trailing: const Icon(Icons.chevron_right_rounded),
          ),
        ),
      ),
    ),
  );
}
