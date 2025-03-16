
import 'package:flutter/material.dart';

class BoardingItem extends StatefulWidget {
  const BoardingItem({super.key, required this.item});

  final Map<String, String> item;

  @override
  State<BoardingItem> createState() => _BoardingItemState();
}

class _BoardingItemState extends State<BoardingItem> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            widget.item['image']!,
            width: 250,
            height: 250,
            fit: BoxFit.fill,
          ),
          const SizedBox(height: 16),
          Text(
            widget.item['title']!,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              fontFamily: "Inter",
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            widget.item['description']!,
            style:
             TextStyle(fontSize: 14, color: Colors.grey[800]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ); ;
  }
}
