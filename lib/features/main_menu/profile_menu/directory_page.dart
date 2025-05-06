import 'package:flutter/material.dart';
import 'package:portalixmx_app/features/main_menu/profile_menu/directory_detail_page.dart';
import 'package:portalixmx_app/res/app_colors.dart';
import 'package:portalixmx_app/widgets/bg_gradient_screen.dart';

import '../../../res/app_textstyles.dart';

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
                Text("Directory", style: AppTextStyles.regularTextStyle),
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
                          hintText: "Search",
                          hintStyle: AppTextStyles.hintTextStyle
                        ),
                      )
                    ),
                    Expanded(child: ListView.builder(
                        itemCount: 10,
                        itemBuilder: (ctx, index){
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Material(
                              color: AppColors.lightGreyBackgroundColor,
                              child: ListTile(
                                onTap: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (_)=> DirectoryDetailPage())),
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
                          );
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
