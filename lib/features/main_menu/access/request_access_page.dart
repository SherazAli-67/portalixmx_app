import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:portalixmx_app/l10n/app_localizations.dart';
import 'package:portalixmx_app/models/access_control_model.dart';
import 'package:portalixmx_app/providers/request_access_provider.dart';
import 'package:portalixmx_app/res/app_colors.dart';
import 'package:portalixmx_app/widgets/from_date_and_time_widget.dart';
import 'package:portalixmx_app/widgets/primary_btn.dart';
import 'package:provider/provider.dart';
import '../../../res/app_textstyles.dart';

class RequestAccessPage extends StatefulWidget{
  const RequestAccessPage({super.key});
  @override
  State<RequestAccessPage> createState() => _RequestAccessPageState();
}

class _RequestAccessPageState extends State<RequestAccessPage> {

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  String _selectedAccessRequestID = '';
  @override
  Widget build(BuildContext context) {
    final accessProvider = Provider.of<RequestAccessProvider>(context);
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
              itemCount: accessProvider.allAccessItems.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, mainAxisSpacing: 10,
                childAspectRatio: 2/3
              ),
              itemBuilder: (ctx, index) {
                AccessModel request = accessProvider.allAccessItems[index];
                bool isSelected = _selectedAccessRequestID == request.id;
                // debugPrint("isSelected: $isSelected");
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
                      child:  SvgPicture.asset(accessProvider.getImageByTitle(request.name ?? ''), colorFilter: isSelected ? ColorFilter.mode(Colors.white, BlendMode.srcIn) : null,),
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
                    request.name ?? '',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.tileSubtitleTextStyle
                ),
              ],
            );
          })),
          Consumer<RequestAccessProvider>(builder: (ctx, provider, _){

            return SizedBox(
              height: 50,
              width: double.infinity,
              child: PrimaryBtn(
                onTap: (){
                  if(_selectedAccessRequestID.isEmpty || _selectedTime == null || _selectedDate == null){
                    return;
                  }
                  String accessTitle = provider.allAccessItems.where((accessItem)=> accessItem.id == _selectedAccessRequestID).toList().first.name ?? '';
                  final data = {
                    "id": _selectedAccessRequestID,
                    "requestTime": '${_selectedTime!.hour}:${_selectedTime!.minute}:00',
                    "requestDate": _selectedDate!.toIso8601String()
                  };


                  provider.addRequestAccessControl(data: data, accessTitle: accessTitle, context: context);
                },
                btnText: AppLocalizations.of(context)!.submit,
                isLoading: provider.addingRequestAccess,),
            );
          })

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