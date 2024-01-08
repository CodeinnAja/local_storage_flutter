import 'package:flutter/material.dart';
import 'package:flutter_local_storage_notes_app/utils/card_color.dart';
import '../models/note_model.dart';

class CardWIdget extends StatelessWidget {
  final int index;
  final Note notes;
  const CardWIdget({super.key, required this.notes, required this.index});

  double getMinHeight(int index) {
    switch (index % 4) {
      case 0:
        return 100;
      case 1:
        return 150;
      case 2:
        return 150;
      case 3:
        return 100;
      default:
        return 100;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = CardColor[index % CardColor.length];
    final minTinggi = getMinHeight(index);
    return Card(
      color: color,
      child: Container(
        constraints: BoxConstraints(minHeight: minTinggi),
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Text(
              notes.title,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
