import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:portalixmx_app/app_data/app_data.dart';
import 'package:portalixmx_app/features/main_menu/access/access_summary_page.dart';
import 'package:portalixmx_app/l10n/app_localizations.dart';
import 'package:portalixmx_app/models/access_request_model.dart';
import 'package:portalixmx_app/res/app_colors.dart';
import 'package:portalixmx_app/widgets/from_date_and_time_widget.dart';
import 'package:portalixmx_app/widgets/primary_btn.dart';
import '../../../res/app_textstyles.dart';

class RequestAccessPage extends StatefulWidget{
  const RequestAccessPage({super.key});

  @override
  State<RequestAccessPage> createState() => _RequestAccessPageState();
}

class _RequestAccessPageState extends State<RequestAccessPage> {

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  int _selectedAccessRequestID = 1;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 15,
        children: [
          Align(
              alignment: Alignment.center,
              child: Text(AppLocalizations.of(context)!.requestAccess, style: AppTextStyles.bottomSheetHeadingTextStyle,)),
          const SizedBox(height: 10,),
          FromDateAndTimeWidget(title: AppLocalizations.of(context)!.from, onDateTap: _onDateTap, onTimeTap: _onTimeTap, selectedDate: _selectedDate, selectedTime: _selectedTime, showTitle: false,),
          Text(AppLocalizations.of(context)!.accessFor, style: AppTextStyles.tileSubtitleTextStyle.copyWith(color: Color(0xff666666)),),
          Expanded(child: GridView.builder(
              itemCount: AppData.getRequestAccessList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, mainAxisSpacing: 10), itemBuilder: (ctx, index){
                AccessRequestModel request = AppData.getRequestAccessList[index];
                bool isSelected = _selectedAccessRequestID == request.id;
                debugPrint("isSelected: $isSelected");
            return  Column(
              spacing: 6,
              children: [
                ElevatedButton(
                    onPressed: (){
                      _selectedAccessRequestID = request.id;
                      setState(() {});
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isSelected ? AppColors.primaryColor :  Colors.white,
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.0)),
                      padding: EdgeInsets.zero
                    ),
                    child:Padding(
                      padding: const EdgeInsets.all(15.0),
                      child:  SvgPicture.asset(request.icon, colorFilter: isSelected ? ColorFilter.mode(Colors.white, BlendMode.srcIn) : null,),
                    ),),
               /* Card(
                  margin: EdgeInsets.zero,
                  color: isSelected ? AppColors.primaryColor :  Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0)),
                  elevation: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child:  SvgPicture.asset(request.icon, colorFilter: isSelected ? ColorFilter.mode(Colors.white, BlendMode.srcIn) : null,),
                  ),
                ),*/
                Text(
                    request.title,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.tileSubtitleTextStyle
                ),
              ],
            );
          })),
          SizedBox(
            height: 50,
            width: double.infinity,
            child: PrimaryBtn(onTap: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=> AccessSummaryPage()));
            }, btnText: AppLocalizations.of(context)!.submit),
          )

        ],
      ),
    );
  }

  void _onDateTap()async{
    DateTime? datePicked = await showDatePicker(context: context, firstDate: DateTime.now(), lastDate: DateTime.now().add(Duration(days: 365)));
    if(datePicked != null){
      _selectedDate = datePicked;
      setState(() {});
    }
  }

  void _onTimeTap()async{
    TimeOfDay? timePicked = await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if(timePicked != null){
      _selectedTime = timePicked;
      setState(() {});
    }
  }
}