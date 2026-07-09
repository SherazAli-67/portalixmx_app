import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:portalixmx_app/presentation/widgets/bg_gradient_screen.dart';
import '../../../core/res/app_textstyles.dart';

class PreviewImageScreen extends StatelessWidget{
  final String imageUrl;
  final String title;
  const PreviewImageScreen({super.key, required this.imageUrl, required this.title});
  @override
  Widget build(BuildContext context) {
    return BgGradientScreen(child: Column(
      spacing: 20,
      children: [
        Padding(padding: EdgeInsets.only(top: 65),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BackButton(color: Colors.white,),
              Text(title, style: AppTextStyles.regularTextStyle,),
              const SizedBox(width: 20)
            ],
          ),
        ),

        Expanded(
          child: Card(
            color: Colors.white,
            elevation: 0,
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))
            ),
            child: SizedBox(
              width: .infinity,
                // padding: const EdgeInsets.only(top: 36.0, left: 18, right: 18),
                child: ClipRRect(
                    borderRadius:BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                    child: InteractiveViewer(child: CachedNetworkImage(imageUrl: imageUrl, fit: .cover,)))
            ),
          ),
        )
      ],
    ),);
  }
  
}