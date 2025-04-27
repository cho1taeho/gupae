import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gupae/presentation/components/tabs.dart';

class AddToiletDialog extends StatefulWidget {
  final LatLng selectedLocation;

  const AddToiletDialog({super.key, required this.selectedLocation});

  @override
  State<AddToiletDialog> createState() => _AddToiletDialogState();
}

class _AddToiletDialogState extends State<AddToiletDialog> {
  final TextEditingController _floorController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  int _toiletPaperIndex = -1;
  int _passwordIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('화장실 추가'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _floorController,
              decoration: const InputDecoration(
                labelText: '층수',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('휴지', style: TextStyle(fontSize: 16)),
            ),
            TabsWidget(
              labels: ['있음', '없음'],
              selectedindex: _toiletPaperIndex,
              onValueChange: (index) {
                setState(() {
                  _toiletPaperIndex = index;
                });
              },
            ),
            const SizedBox(height: 12),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('비밀번호', style: TextStyle(fontSize: 16)),
            ),
            TabsWidget(
              labels: ['있음', '없음'],
              selectedindex: _passwordIndex,
              onValueChange: (index) {
                setState(() {
                  _passwordIndex = index;
                });
              },
            ),
            const SizedBox(height: 12),
            if (_passwordIndex == 0)
              TextField(
                controller: _passwordController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: '비밀번호 입력',
                  border: OutlineInputBorder(),
                ),
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('취소'),
        ),
        ElevatedButton(
          onPressed: () {
            final floor = _floorController.text.trim();
            final hasPaper = _toiletPaperIndex == 0;
            final password = _passwordIndex == 0 ? _passwordController.text.trim() : '';

            if (floor.isEmpty || _toiletPaperIndex == -1 || _passwordIndex == -1 || (_passwordIndex == 0 && password.isEmpty)) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('모든 항목을 선택하세요.')),
              );
              return;
            }

            Navigator.of(context).pop({
              'floor': floor,
              'hasPaper': hasPaper,
              'password': password,
              'location': widget.selectedLocation,
            });
          },
          child: const Text('추가'),
        ),
      ],
    );
  }
}
