import 'package:flutter/material.dart';
import 'package:portalixmx_app/core/models/user_model.dart';
import 'package:portalixmx_app/core/res/app_colors.dart';
import 'package:portalixmx_app/core/res/app_textstyles.dart';
import 'package:portalixmx_app/l10n/app_localizations.dart';
import 'package:portalixmx_app/presentation/widgets/primary_btn.dart';

class SelectEmergencyContactsSheet extends StatefulWidget {
  const SelectEmergencyContactsSheet({
    super.key,
    this.scrollController,
    this.scrollPhysics,
    required this.residents,
    required this.initiallySelectedIds,
  });

  final ScrollController? scrollController;
  final ScrollPhysics? scrollPhysics;
  final List<UserModel> residents;
  final Set<String> initiallySelectedIds;

  @override
  State<SelectEmergencyContactsSheet> createState() => _SelectEmergencyContactsSheetState();
}

class _SelectEmergencyContactsSheetState extends State<SelectEmergencyContactsSheet> {
  late final Set<String> _selectedIds;

  @override
  void initState() {
    super.initState();
    _selectedIds = {...widget.initiallySelectedIds};
  }

  void _toggle(String userId) {
    setState(() {
      if (_selectedIds.contains(userId)) {
        _selectedIds.remove(userId);
      } else {
        _selectedIds.add(userId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Material(
      color: Colors.white,
      child: Padding(
        padding: const .all(15.0),
        child: Column(
          crossAxisAlignment: .start,
          spacing: 10,
          children: [
            Text(localization.selectEmergencyContacts, style: AppTextStyles.btnTextStyle.copyWith(color: AppColors.primaryColor),),
            Expanded(
              child: widget.residents.isEmpty
                  ? Center(child: Text(localization.noResidentsFound),)
                  : ListView.separated(
                      controller: widget.scrollController,
                      physics: widget.scrollPhysics,
                      itemCount: widget.residents.length,
                      separatorBuilder: (_, index) => const SizedBox(height: 10),
                      itemBuilder: (ctx, index) {
                        final resident = widget.residents[index];
                        final isSelected = _selectedIds.contains(resident.userID);
                        return Material(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: .circular(15), side: BorderSide(color: AppColors.borderColor2)),
                          child: ListTile(
                            onTap: () => _toggle(resident.userID),
                            contentPadding: const .only(left: 10, right: 8),
                            leading: CircleAvatar(
                              backgroundColor: AppColors.btnColor,
                              child: Center(child: Icon(Icons.person, color: Colors.white,),),
                            ),
                            title: Text(resident.userName, style: AppTextStyles.tileTitleTextStyle,),
                            subtitle: Text(resident.phoneNum ?? '', style: AppTextStyles.tileSubtitleTextStyle,),
                            trailing: Checkbox(
                              value: isSelected,
                              activeColor: AppColors.primaryColor,
                              onChanged: (_) => _toggle(resident.userID),
                            ),
                          ),
                        );
                      },
                    ),
            ),
            SizedBox(
              width: .infinity,
              child: PrimaryBtn(
                onTap: () => Navigator.pop(context, _selectedIds.toList()),
                btnText: localization.saveContacts,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
