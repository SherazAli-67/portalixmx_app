import 'package:flutter/material.dart';
import 'package:portalixmx_app/l10n/app_localizations.dart';
import '../../../../core/res/app_colors.dart';
import '../../../../core/res/app_textstyles.dart';
import '../../../widgets/bg_gradient_screen.dart';

class ProfileGuardsPage extends StatelessWidget{
  const ProfileGuardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BgGradientScreen(
      child: Column(
        spacing: 20,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 65.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BackButton(color: Colors.white),
                Text(AppLocalizations.of(context)!.guardTracking, style: AppTextStyles.regularTextStyle),
                const SizedBox(width: 40),
              ],
            ),
          ),
          Expanded(
            child: Card(
              color: AppColors.lightGreyBackgroundColor,
              shape: RoundedRectangleBorder(borderRadius: .circular(30)),
              child: Center(
                child: Padding(
                  padding: const .symmetric(horizontal: 24.0),
                  child: Text(
                    AppLocalizations.of(context)!.guardInfoUnavailable,
                    style: AppTextStyles.tileSubtitleTextStyle,
                    textAlign: .center,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
