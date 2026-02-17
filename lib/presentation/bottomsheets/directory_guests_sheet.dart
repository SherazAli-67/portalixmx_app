import 'package:flutter/material.dart';
import 'package:portalixmx_app/core/models/visitor_model.dart';
import 'package:portalixmx_app/core/res/app_colors.dart';
import 'package:portalixmx_app/core/res/app_textstyles.dart';
import 'package:portalixmx_app/presentation/widgets/guest_item_widget.dart';
import 'package:portalixmx_app/presentation/widgets/primary_btn.dart';
import 'package:portalixmx_app/presentation/widgets/regular_visitor_item_widget.dart';
import 'package:portalixmx_app/providers/home_provider.dart';
import 'package:provider/provider.dart';

class DirectoryGuestsSheet extends StatelessWidget{
  const DirectoryGuestsSheet({super.key, this.scrollController, this.scrollPhysics});
  final ScrollController? scrollController;
  final ScrollPhysics? scrollPhysics;
  @override
  Widget build(BuildContext context) {
    final provider= Provider.of<HomeProvider>(context);
    return Material(
      color: Colors.white,
      child: Padding(
        padding: const .all(15.0),
        child: Column(
          crossAxisAlignment: .start,
          spacing: 10,
          children: [
            Text("Guests Directory", style: AppTextStyles.btnTextStyle.copyWith(color: AppColors.primaryColor),),
            Expanded(child: ListView.separated(itemBuilder: (ctx, index){
              BaseVisitor visitor = provider.visitors[index];
              return visitor is GuestVisitor
                  ? GuestItemWidget(guest: visitor, onDeleteTap: (val) {}, onTap: ()=> Navigator.pop(context, visitor),)
                  : RegularVisitorItemWidget(visitor: visitor as RegularVisitor, onDeleteTap: (val) {}, onTap: ()=> Navigator.pop(context, visitor),);
            }, separatorBuilder: (_, index) => const SizedBox(height: 10,), itemCount: provider.visitors.length)),

            SizedBox(
                width: .infinity,
                child: PrimaryBtn(onTap: (){}, btnText: 'Add New Guest'))
          ],
        ),
      )
    );
  }

}