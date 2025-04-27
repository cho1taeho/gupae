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
  int _toiletPaperIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('화장실 추가'),
      content: Column(
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
          TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: '비밀번호',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('취소'),
        ),
        ElevatedButton(
          onPressed: () {
            // 여기서 제출 처리
            final floor = _floorController.text.trim();
            final hasPaper = _toiletPaperIndex == 0;
            final password = _passwordController.text.trim();

            if (floor.isEmpty || password.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('모든 항목을 입력하세요.')),
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
