import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:rotasegura/custom/datePicker.dart';
import 'package:rotasegura/helpers/maskeds.dart';
import 'package:rotasegura/helpers/validations.dart';

class CustomTextFormField {
  static Widget textFormDataField(BuildContext context,
      {String label = "Data",
      @required TextEditingController controller,
      Function(DateTime) onConfirm,

      Function(DateTime) onChange,
      TextStyle labelStyle,
      bool enabled = true}) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      readOnly: true,
      decoration: InputDecoration(
          labelText: label, labelStyle: labelStyle, enabled: enabled),
      onTap: () {
        DatePicker.showPicker(context,
            pickerModel: DatePickerCustom(),
            showTitleActions: true,
            locale: LocaleType.pt,
            onConfirm: onConfirm);
      },
    );
  }


  static Widget textFormField(
      {String label,
      @required TextEditingController controller,
      String hintText,
      Function onTap,
      TextInputType keyboard = TextInputType.text,
      bool obscureText = false,

      TextStyle labelStyle,
      bool enabled = true}) {

    return TextFormField(
      controller: controller,
      onTap: onTap,
      obscureText: obscureText,
      keyboardType: keyboard,
      enabled: enabled,
      decoration: InputDecoration(
        labelStyle: labelStyle,
        hintText: hintText,
        labelText: label,
      ),
    );
  }


  static Widget textFormDropField(
      {String label,
      @required TextEditingController controller,
      String hintText,
      Icon icon,
      TextStyle labelStyle,
      bool enabled = true}) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: label,
        suffixIcon: icon,
        labelStyle: labelStyle,
      ),
    );
  }

  static Widget textformCepField(
      {@required TextEditingController controller,
      String label = "Cep",
      TextStyle labelStyle,
      bool enabled = true}) {

    return TextFormField(
      maxLength: 9,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.done,
      enabled: enabled,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: labelStyle,
      ),

      controller: controller,
      inputFormatters: [
        MasksCEP(
          mask: 'xxxxx-xxx',
          separator: '-',
        ),
      ],
      validator: (value) {
        return Validations.cepValidation(value) ? null : "Cep inválido";
      },
    );
  }
}

