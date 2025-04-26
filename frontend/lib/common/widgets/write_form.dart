import 'package:flutter/material.dart';

class WriteForm extends StatelessWidget {
  const WriteForm({
    super.key,
    required this.contentsController,
    required this.onSubmit,
  });

  final TextEditingController contentsController;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          TextField(
            autocorrect: false,
            controller: contentsController,
            maxLines: null, // 자동 줄바꿈 활성화
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
            ),
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 20),
          Spacer(),
          ElevatedButton(onPressed: onSubmit, child: Text('SUBMIT')),
        ],
      ),
    );
  }
}
