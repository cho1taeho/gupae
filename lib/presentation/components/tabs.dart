
import 'package:flutter/material.dart';



class TabsWidget extends StatelessWidget {
  final List<String> labels;
  final int selectedindex;
  final Function(int) onValueChange;

  const TabsWidget({super.key, required this.labels, required this.selectedindex, required this.onValueChange});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                for (int i = 0; i < (labels ?? []).length; i++)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: ElevatedButton(
                        onPressed: () {
                          onValueChange(i);
                        },
                        child: Text(labels[i]),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: i == selectedindex ? Colors.blue : Colors.red,
                          foregroundColor: i == selectedindex ? Colors.red : Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
