import 'package:flutter/material.dart';
import 'package:portalixmx_app/core/models/visitor_model.dart';
import 'package:portalixmx_app/l10n/app_localizations.dart';
import 'package:portalixmx_app/presentation/widgets/guest_item_widget.dart';
import 'package:portalixmx_app/presentation/widgets/loading_widget.dart';
import 'package:portalixmx_app/presentation/widgets/regular_visitor_item_widget.dart';
import 'package:portalixmx_app/providers/directory_provider.dart';
import 'package:provider/provider.dart';
import '../../../../core/res/app_colors.dart';
import '../../../../core/res/app_textstyles.dart';
import '../../../widgets/bg_gradient_screen.dart';

class DirectoryPage extends StatefulWidget {
  const DirectoryPage({super.key});

  @override
  State<DirectoryPage> createState() => _DirectoryPageState();
}

class _DirectoryPageState extends State<DirectoryPage> {
   final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DirectoryProvider>(context);
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
                Text(AppLocalizations.of(context)!.directory, style: AppTextStyles.regularTextStyle),
                const SizedBox(width: 40),
              ],
            ),
          ),
          Expanded(
            child: Card(
              color: AppColors.lightGreyBackgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 17),
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(99),
                            borderSide: BorderSide.none
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(99),
                              borderSide: BorderSide.none
                          ),
                          hintText: AppLocalizations.of(context)!.search,
                          hintStyle: AppTextStyles.hintTextStyle
                        ),
                      )
                    ),
                    Expanded(child: provider.loadingDirectoryGuests ? LoadingWidget() : ListView.builder(
                        itemCount: provider.directoryGuests.length,
                        itemBuilder: (ctx, index){
                          BaseVisitor visitor = provider.directoryGuests[index];
                          return Padding(
                            padding: const .only(bottom: 10.0),
                            child: visitor is GuestVisitor
                                ? GuestItemWidget(
                                guest: visitor,
                                onDeleteTap: (val) => provider.deleteVisitor(visitor.id))
                                : RegularVisitorItemWidget(
                                visitor: visitor as RegularVisitor,
                                onDeleteTap: (val) => provider.deleteVisitor(visitor.id)),
                          );
                         /* return Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Material(
                              color: AppColors.lightGreyBackgroundColor,
                              child: ListTile(
                                onTap: ()=> context.push(NamedRoutes.directoryDetail.routeName),
                                contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)
                                ),
                                tileColor: Colors.white,
                                leading: CircleAvatar(
                                  backgroundColor: AppColors.btnColor,
                                  child: Center(child: Icon(Icons.person, color: Colors.white,),),
                                ),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Muhammad Ali", style: AppTextStyles.tileTitleTextStyle,),
                                    Text("Mobile App Developer", style: AppTextStyles.tileSubtitleTextStyle,)
                                  ],
                                ),
                                trailing: IconButton(onPressed: (){}, icon: Icon(Icons.more_vert_rounded)),
                              ),
                            ),
                          );*/
                    }))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
