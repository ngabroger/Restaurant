import 'package:flutter/material.dart';

class Bookmark extends StatefulWidget {
  const Bookmark({Key? key}) : super(key: key);

  @override
  _BookmarkState createState() => _BookmarkState();
}

class _BookmarkState extends State<Bookmark> {
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (isFavorite == false) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Adding To Bookmark'),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Deleting From Bookmark'),
            ),
          );
        }
        setState(() {
          isFavorite = !isFavorite;
        });
      },
      icon: Icon(
        isFavorite ? Icons.bookmark : Icons.bookmark_border_rounded,
        color: Colors.red[400],
      ),
    );
  }
}
