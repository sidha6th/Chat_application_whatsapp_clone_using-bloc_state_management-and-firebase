import 'package:chat_app/extra/exports/exports.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    this.keybordType = TextInputType.number,
    required this.errorValidator,
    this.hint = '',
    this.textColor = white,
    required this.textEditingController,
    this.color = green,
    Key? key,
  }) : super(key: key);
  final TextEditingController textEditingController;
  final Color color;
  final Color textColor;
  final String hint;
  final Function errorValidator;
  final TextInputType keybordType;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value)=>errorValidator(value),
      validator: (String? value) => errorValidator(value),
      cursorColor: color,
      cursorHeight: 25,
      style: TextStyle(color: textColor),
      keyboardType: keybordType,
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: textColor),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: color,
            width: 2,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: color,
            width: 2,
          ),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
            width: 2,
          ),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: color,
            width: 2,
          ),
        ),
      ),
    );
  }
}
