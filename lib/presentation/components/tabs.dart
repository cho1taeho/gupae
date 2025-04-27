import 'package:flutter/material.dart';

class TabsWidget extends StatelessWidget {
  final List<String> labels;
  final int selectedindex;
  final Function(int) onValueChange;

  const TabsWidget({
    super.key,
    required this.labels,
    required this.selectedindex,
    required this.onValueChange,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          for (int i = 0; i < labels.length; i++)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: OutlinedButton(
                  onPressed: () {
                    onValueChange(i);
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: i == selectedindex ? Colors.blue : Colors.transparent,
                    side: BorderSide(
                      color: i == selectedindex ? Colors.blue : Colors.grey,
                    ),
                    foregroundColor: i == selectedindex ? Colors.white : Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(labels[i]),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
