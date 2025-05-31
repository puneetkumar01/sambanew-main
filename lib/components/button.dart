import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/apptheme.dart';

class Button extends StatelessWidget {
  Button({super.key, required this.tittle, this.tap});
  final String tittle;
  var tap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: tap,
      child: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: const Color(0x8C333335).withOpacity(0.1),
                offset: const Offset(1, 1),
                blurRadius: 4.0,
                spreadRadius: 2
              ),
            ],
            color: AppTheme.primaryColor,
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: IntrinsicHeight(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  child: Text(
                    tittle,
                    style: GoogleFonts.inter(
                        fontSize: 15,
                        color: AppTheme.whiteBackgroundColor,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Positioned(
                    right:20,
                    child: Icon(
                      Icons.arrow_forward,
                      color: AppTheme.whiteBackgroundColor,
                    )),
              ],
            ),
          )),
    );
  }
}
