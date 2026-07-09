import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portalixmx_app/l10n/app_localizations.dart';
import 'package:portalixmx_app/presentation/widgets/payment_status_widget.dart';
import 'package:provider/provider.dart';
import '../../../core/common_ui.dart';
import '../../../core/models/payment_model.dart';
import '../../../core/res/app_colors.dart';
import '../../../core/res/app_textstyles.dart';
import '../../../providers/datetime_format_helpers.dart';
import '../../../providers/payments_provider/payment_provider.dart';
import '../../../router/app_router.dart';
import '../../widgets/full_page_loading_widget.dart';
import '../../widgets/loading_widget.dart';

class PaymentsMenu extends StatelessWidget{
  const PaymentsMenu({super.key});

  @override
  Widget build(BuildContext context) {

    final localization = AppLocalizations.of(context)!;
    return ChangeNotifierProvider(
      create: (_)=> PaymentProvider(),
      builder: (ctx, child){
        return Consumer<PaymentProvider>(builder: (ctx, provider, child){
          return Stack(
            children: [
              Padding(
                padding: const .symmetric(horizontal: 15.0),
                child: Column(
                  spacing: 22,
                  children: [
                    Stack(
                      children: [
                        Align(
                            alignment: .center,
                            child: Padding(
                              padding: const .only(top: 35.0, bottom: 11),
                              child: Text(localization.paymentsAndBilling, textAlign: .center, style: AppTextStyles.headingTextStyle,),
                            )),
                        const SizedBox(width: 40,),
                      ],
                    ),
                    Expanded(
                        child: provider.loadingPayments
                            ? LoadingWidget()
                            : ((){
                          final list = provider.getFilteredPayments(localization);
                          return RefreshIndicator(
                            onRefresh: provider.refreshPayments,
                            child: list.isEmpty
                                ? ListView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              children: [
                                SizedBox(
                                  height: 200,
                                  child: Center(
                                    child: Text("No payment requests found", style: AppTextStyles.regularTextStyle,),
                                  ),
                                ),
                              ],
                            )
                                : ListView.builder(
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemCount: list.length,
                                itemBuilder: (ctx, index){
                                  PaymentModel payment = list[index];
                                  return GestureDetector(
                                    onTap: ()=> _onItemTap(payment, context, provider),
                                    child: Container(
                                        margin: .only(bottom: 10),
                                        padding: .symmetric(horizontal: 12, vertical: 15),
                                        decoration: BoxDecoration(color: Colors.white, borderRadius: .circular(15)),
                                        child: Row(
                                          spacing: 17,
                                          crossAxisAlignment: .start,
                                          children: [
                                            CircleAvatar(
                                              backgroundColor: AppColors.primaryColor.withValues(alpha: 0.1),
                                              child: Center(child: Text('${payment.paymentForTitle[0]}${payment.paymentForTitle[0]}', style: AppTextStyles.tileTitleTextStyle.copyWith(color: AppColors.primaryColor),),),
                                            ),
                                            Expanded(
                                              child: Column(
                                                spacing: 2,
                                                crossAxisAlignment: .start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: .spaceBetween,
                                                    children: [
                                                      Text(payment.paymentForTitle, style: AppTextStyles.tileTitleTextStyle.copyWith(color: AppColors.primaryColor),),
                                                      Text("\$${payment.amount}", style: TextStyle(fontSize: 12, fontWeight: .w700, color: AppColors.btnColor),)
                                                    ],
                                                  ),
                                                  Text(DateTimeFormatHelpers.formatDateTime(payment.dateTime), style: TextStyle(fontSize: 10, fontWeight: .w500, color: AppColors.serviceSubTitleGreyColor),),
                                                  const SizedBox(height: 3,),
                                                  Row(
                                                    spacing: 20,
                                                    children: [
                                                      Expanded(child: Text(payment.description, style: AppTextStyles.emergencyContactTitleTextStyle,)),
                                                      FutureBuilder(future: provider.getPaymentStatus(paymentID: payment.paymentID), builder: (ctx, snapshot){
                                                        if(snapshot.connectionState == .waiting){
                                                          return LoadingWidget(color: AppColors.primaryColor,);
                                                        }
                                                        if(snapshot.data != null){
                                                          return PaymentStatusWidget(status: snapshot.requireData ?? PaymentStatus.pending);
                                                        }

                                                        return SizedBox();
                                                      })
                                                    ],
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        )
                                    ),
                                  );
                                }),
                          );
                        })()
                    )
                  ],
                ),
              ),
              if(provider.updatingPayment)
                FullPageLoadingWidget()
            ],
          );
        });
      },
    );
  }

  void _onItemTap(PaymentModel payment, BuildContext context, PaymentProvider provider)async {
    PaymentModel? updatedPayment =  await context.push(NamedRoutes.paymentDetail.routeName, extra: payment);
    if(updatedPayment != null){
      String? error = await provider.updatePayment(updatedPayment);
      if(error != null){
        CommonUI.showSnackBarMessage(context, isError: true, message: error);
      }else{
        CommonUI.showSnackBarMessage(context, isSuccess: true, message: "Your receipt is submitted to the admin");
      }
    }
  }
}