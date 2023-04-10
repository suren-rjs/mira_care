import 'package:flutter/material.dart';
import 'package:mira_care/presentation/components/journal_event.dart';

class JournalEventList extends StatelessWidget {
  const JournalEventList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double scrHeight = MediaQuery.of(context).size.height;
    double scrWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.zero,
      height: scrHeight * 0.7,
      width: scrWidth * 0.9,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: 10,
        itemBuilder: (context, index) {
          return const JournalEvent();
        },
      ),
    );
  }
}
