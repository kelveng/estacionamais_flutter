import 'package:estaciona_mais/app/common/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextStyles {
  static final titleRegular = GoogleFonts.lexendDeca(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: AppColors.secondary,
  );

  static final appNameBold = GoogleFonts.montserrat(
    fontSize: 25,
    fontWeight: FontWeight.w800,
    color: AppColors.secondary,
  );

  static final appNameBoldWhite = GoogleFonts.montserrat(
    fontSize: 25,
    fontWeight: FontWeight.w800,
    color: AppColors.white,
  );

  static final titleBoldBackground = GoogleFonts.lexendDeca(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.secondary,
  );

  static final titleBoldProcessTicket = GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.secondary,
  );

  static final titleListTile = GoogleFonts.lexendDeca(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    color: AppColors.heading,
  );
  static final trailingRegular = GoogleFonts.lexendDeca(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.heading,
  );

  static final buttonHeading = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.heading,
  );
  static final textFilterDate = GoogleFonts.inter(
    fontSize: 17,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
  );

  static final amountIndicator = GoogleFonts.montserrat(
    fontSize: 25,
    fontWeight: FontWeight.w600,
    color: AppColors.green,
  );

  static final titleBoxProcessGreen = GoogleFonts.inter(
    fontSize: 25,
    fontWeight: FontWeight.w600,
    color: AppColors.green,
  );

  static final titleBoxProcessRed = GoogleFonts.inter(
      fontSize: 25, fontWeight: FontWeight.w600, color: AppColors.red);

  static final titleIndicator = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.background,
  );

  static final subTitleIndicator = GoogleFonts.inter(
    decoration: TextDecoration.underline,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.background,
  );

  static final subTitleWhith = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.background,
  );

  static final subTitleGreen = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.green,
  );

  static final textErrormessage = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.red,
  );
}
