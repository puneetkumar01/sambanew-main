import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/apptheme.dart';
import '../util/config.dart';

class MyTextField extends StatelessWidget {
  String hintText;
  var color;
  var icon;
  var preicon;
  bool readOnly;
  var validation;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatters;
  var ontap;
  var ontapSuffix;
  final bool obsecureText;
  final bool isSuffixIcon;
  final TextEditingController? textEditingController;
  MyTextField(
      {super.key,
      required this.hintText,
      required this.color,
      this.icon,
      this.ontapSuffix,
      this.obsecureText = false,
      this.isSuffixIcon = false,
      this.readOnly = false,
      this.preicon,
      this.ontap,
      this.textInputType,
      this.inputFormatters,
      this.textEditingController,
      this.validation});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: getProportionateScreenHeight(8),
          bottom: getProportionateScreenHeight(8)),
      child: TextFormField(
          keyboardType: textInputType,
          onTap: ontap,
          readOnly: readOnly,
          inputFormatters: inputFormatters,
          controller: textEditingController,
          obscureText: obsecureText,
          validator: validation,
          cursorColor: AppTheme.primaryColor,
          style: const TextStyle(fontSize: 14),
          decoration: InputDecoration(
              labelStyle: Theme.of(context).textTheme.displaySmall,
              counterText: '',
              errorStyle: GoogleFonts.roboto(fontSize: 12),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color.fromRGBO(225, 30, 61, 1),
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(15.0),
              ),
              prefixIcon: preicon,
              hintStyle: Theme.of(context).textTheme.displaySmall,
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color.fromRGBO(225, 30, 61, 1),
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(15.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color.fromRGBO(228, 223, 223, 1),
                  width: 0.8,
                ),
                borderRadius: BorderRadius.circular(15.r),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color.fromRGBO(228, 223, 223, 1),
                   width: 0.8,
                ),
                borderRadius: BorderRadius.circular(15.r),
              ),
              border:  OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.r),
                  borderSide: const BorderSide(
                    
                color: Color.fromRGBO(228, 223, 223, 1),
                  width: 0.8,
              )),
              // filled: true,
              //  fillColor: Colors.white,
              contentPadding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
              hintText: hintText,
              floatingLabelStyle:
                  const TextStyle(color: Color.fromRGBO(245, 73, 53, 1)),
              suffixIcon: isSuffixIcon
                  ? GestureDetector(
                      onTap: ontapSuffix,
                      child: !obsecureText
                          ? Icon(
                              Icons.visibility_off,
                              size: 18.h,
                              color: Colors.grey,
                            )
                          : Icon(
                              Icons.visibility,
                              size: 18.h,
                              color: Colors.grey,
                            ),
                    )
                  : icon)),
    );
  }
}
