import 'package:flutter/material.dart';
import 'package:portalixmx_app/l10n/app_localizations.dart';
import 'package:portalixmx_app/res/app_colors.dart';
import 'package:portalixmx_app/res/app_textstyles.dart';

class PaymentsMenu extends StatefulWidget{
  const PaymentsMenu({super.key});

  @override
  State<PaymentsMenu> createState() => _PaymentsMenuState();
}

class _PaymentsMenuState extends State<PaymentsMenu> {
  int _selectedServiceTypeIndex = 0;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        spacing: 20,
        children: [
          Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(top: 35.0),
                child: Text(AppLocalizations.of(context)!.paymentsAndBilling, textAlign: TextAlign.center, style: AppTextStyles.headingTextStyle,),
              )),
          const SizedBox(height: 20,),
          Row(
            spacing: 10,
            children: [
              _buildServiceTypeTab(serviceTypeTitle: AppLocalizations.of(context)!.currentService, index: 0),
              _buildServiceTypeTab(serviceTypeTitle: AppLocalizations.of(context)!.otherServices, index: 1),


            ],
          ),
          Expanded(
            child: ListView.builder(
                itemCount: 5,
                itemBuilder: (ctx, index){
                  return Container(
                    margin: EdgeInsets.only(bottom: 10),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: Row(
                      spacing: 17,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor: AppColors.primaryColor.withValues(alpha: 0.1),
                          child: Center(child: Text("SN", style: AppTextStyles.tileTitleTextStyle.copyWith(color: AppColors.primaryColor),),),
                        ),
                        Expanded(
                          child: Column(
                            spacing: 2,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(AppLocalizations.of(context)!.serviceName, style: AppTextStyles.tileTitleTextStyle.copyWith(color: AppColors.primaryColor),),
                                  Text("\$500", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.btnColor),)
                                ],
                              ),
                              Text("Sep 20, 2024", style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: AppColors.serviceSubTitleGreyColor),),
                              const SizedBox(height: 3,),
                              _buildServiceInfoItemWidget(serviceText: AppLocalizations.of(context)!.maintenance, serviceCharges: 300),
                              _buildServiceInfoItemWidget(serviceText: AppLocalizations.of(context)!.cleaningOfCommonAreas, serviceCharges: 200),
                              _buildServiceInfoItemWidget(serviceText: AppLocalizations.of(context)!.garbageCollection, serviceCharges: 100),
                            ],
                          ),
                        )
                      ],
                    )
                  );
                }),
          )
        ],
      ),
    );
  }

  Widget _buildServiceTypeTab({required String serviceTypeTitle, required int index}) {
    bool isSelected = index == _selectedServiceTypeIndex;
    return Expanded(child: ElevatedButton(
        style: isSelected ? ElevatedButton.styleFrom(backgroundColor: AppColors.btnColor): null,
        onPressed: ()=> setState(()=>  _selectedServiceTypeIndex = index),
        child: Text(serviceTypeTitle, style: AppTextStyles.tabsTextStyle.copyWith(color: isSelected ? Colors.white : AppColors.primaryColor),)));
  }


  Widget _buildServiceInfoItemWidget({required String serviceText, required int serviceCharges}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(serviceText, style: TextStyle(fontSize: 10,
            fontWeight: FontWeight.w500,
            color: AppColors.serviceSubTitleGreyColor),),
        Text("\$$serviceCharges", style: TextStyle(fontSize: 10,
            fontWeight: FontWeight.w500,
            color: AppColors.serviceSubTitleGreyColor),),

      ],
    );
  }
}