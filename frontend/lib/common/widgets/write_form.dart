import 'package:flutter/material.dart';
// import 'package:frontend/common/widgets/form_button.dart';

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
          ElevatedButton(
            onPressed: onSubmit, // disabled 처리 예정
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.tealAccent[700]?.withValues(alpha: 0.6),
              foregroundColor: Colors.white, // 텍스트 색
              textStyle: const TextStyle(fontWeight: FontWeight.bold),
              padding: const EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              minimumSize: const Size(100, 40),
            ),
            child: Text('SUBMIT', textAlign: TextAlign.center),
          ),
          SizedBox(height: 8),
          // GestureDetector(
          //   onTap: onSubmit,
          //   child: FormButton(disabled: false, payload: 'SUBMIT'),
          // ),
        ],
      ),
    );
  }
}
