import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portalixmx_app/core/helpers/status_display_helper.dart';
import 'package:portalixmx_app/l10n/app_localizations.dart';
import 'package:portalixmx_app/router/app_router.dart';
import 'package:portalixmx_app/services/complaints_service/complaints_service.dart';
import '../../../../core/helpers/image_url_helper.dart';
import '../../../../core/models/complaints_model.dart';
import '../../../../core/res/app_textstyles.dart';
import '../../../../providers/datetime_format_helpers.dart';
import '../../../widgets/bg_gradient_screen.dart';
import '../../../widgets/loading_widget.dart';
import '../homepage//widgets/vistor_info_item_widget.dart';

class ComplaintSummaryPage extends StatelessWidget{
  const ComplaintSummaryPage({super.key, required this.complaint});
  final ComplaintModel complaint;
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return BgGradientScreen(child: Column(
      spacing: 20,
      children: [
        Padding(padding: const EdgeInsets.only(top: 65),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const BackButton(color: Colors.white,),
              Expanded(child: Text(complaint.complaint, style: AppTextStyles.regularTextStyle, textAlign: TextAlign.center, overflow: TextOverflow.ellipsis,)),
              const SizedBox(width: 20)
            ],
          ),
        ),

        Expanded(
          child: Card(
            color: Colors.white,
            elevation: 0,
            margin: EdgeInsets.zero,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))
            ),
            child: StreamBuilder<ComplaintModel?>(
              stream: ComplaintsService.instance.watchComplaintById(complaint.id),
              initialData: complaint,
              builder: (context, snapshot) {
                final current = snapshot.data ?? complaint;
                return Padding(
                  padding: const EdgeInsets.only(top: 36.0, left: 18, right: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        spacing: 20,
                        children: [
                          Expanded(
                            child: VisitorInfoItemWidget(
                              title: localization.date, subTitle: DateTimeFormatHelpers.formatDateTime(current.createdAt), ),
                          ),
                          Expanded(
                              child: VisitorInfoItemWidget(
                                title: localization.status, subTitle: StatusDisplayHelper.label(current.status, localization),)
                          ),
                        ],
                      ),
                      const Divider(),
                      VisitorInfoItemWidget(title: localization.complaint, subTitle: current.complaint, showDivider: true),
                      Text(localization.photos, style: AppTextStyles.visitorDetailTitleTextStyle,),
                      Expanded(child: snapshot.connectionState == ConnectionState.waiting && snapshot.data == null
                          ? const LoadingWidget()
                          : GridView.builder(
                          itemCount: current.images.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,   mainAxisSpacing: 10, crossAxisSpacing: 10),
                          itemBuilder: (ctx, index){
                        return GestureDetector(
                          onTap: ()=> context.push(NamedRoutes.previewImage.routeName, extra: {
                            'title' : current.complaint,
                            'imageUrl': ImageUrlHelper.getImageUrl(current.images[index])
                          }),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: CachedNetworkImage(imageUrl: ImageUrlHelper.getImageUrl(current.images[index]), height: 75, fit: BoxFit.cover,),
                          ),
                        );
                      }))
                    ],
                  )
                );
              }
            ),
          ),
        )
      ],
    ),);
  }

}
