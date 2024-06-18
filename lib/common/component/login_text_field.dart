import 'package:flutter/material.dart';
import 'package:wms_project/common/constants/colors.dart';

class CustomLoginTextField extends StatelessWidget {
  final String? hintText;
  final String? errorText;
  final bool obscureText;
  final bool autofocus;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;

  const CustomLoginTextField(
      {this.hintText,
      this.errorText,
      this.obscureText = false,
      this.autofocus = true,
      required this.onChanged,
        this.controller,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final baseBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: INPUT_BORDER_COLOR,
        width: 1.0,
      ),
    );

    return TextFormField(
      cursorColor: BODY_TEXT_COLOR,
      //비밀번호 암호화 표시
      obscureText: obscureText,
      controller: controller,
      autofocus: autofocus,
      //값이 바뀔때마다 실행
      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(20),
        hintText: hintText,
        errorText: errorText,
        hintStyle: TextStyle(
          color: BODY_TEXT_COLOR,
          fontSize: 14.0,
        ),
        //배경색
        fillColor: INPUT_BG_COLOR,
        //배경색 유,무 설정
        filled: true,
        //input 상태의 기본 스타일 세팅
        border: baseBorder,
        enabledBorder: baseBorder,
        //copyWith 기본테마는 유지하면서 변경
        focusedBorder: baseBorder.copyWith(
          borderSide: baseBorder.borderSide.copyWith(
            color: BODY_TEXT_COLOR,
          ),
        ),
      ),
    );
  }
}
