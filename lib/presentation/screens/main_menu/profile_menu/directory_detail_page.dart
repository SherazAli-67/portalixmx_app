import 'package:flutter/material.dart';
import 'package:portalixmx_app/core/models/visitor_model.dart';
import 'package:portalixmx_app/l10n/app_localizations.dart';
import '../../../../core/res/app_textstyles.dart';
import '../../../widgets/bg_gradient_screen.dart';
import '../homepage//widgets/vistor_info_item_widget.dart';

class DirectoryDetailPage extends StatelessWidget{
  const DirectoryDetailPage({super.key, this.visitor});
  final BaseVisitor? visitor;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final name = visitor?.name ?? localization.directory;
    final contact = visitor?.contact;
    final accessFor = visitor?.accessFor;
    return BgGradientScreen(child: Column(
      spacing: 20,
      children: [
        Padding(padding: EdgeInsets.only(top: 65),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BackButton(color: Colors.white,),
              Text(name, style: AppTextStyles.regularTextStyle,),
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
            child: Padding(
                padding: const EdgeInsets.only(top: 36.0, left: 18, right: 18),
                child: Column(
                  spacing: 15,
                  children: [
                    VisitorInfoItemWidget(
                      title: localization.accessFor,
                      subTitle: (accessFor == null || accessFor.isEmpty) ? localization.informationUnavailable : accessFor,
                      showDivider: true,),
                    VisitorInfoItemWidget(
                      title: localization.contact,
                      subTitle: (contact == null || contact.isEmpty) ? localization.informationUnavailable : contact,
                      showDivider: true,)
                  ],
                )
            ),
          ),
        )
      ],
    ),);
  }
}
