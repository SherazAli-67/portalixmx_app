import 'package:flutter/material.dart';
import 'package:portalixmx_app/core/models/user_model.dart';
import 'package:portalixmx_app/core/models/zkbio_qr_model.dart';
import 'package:portalixmx_app/core/res/app_textstyles.dart';
import 'package:portalixmx_app/l10n/app_localizations.dart';
import 'package:portalixmx_app/presentation/widgets/bg_gradient_screen.dart';
import 'package:portalixmx_app/presentation/widgets/loading_widget.dart';
import 'package:portalixmx_app/presentation/widgets/zkbio_qr_widget.dart';
import 'package:portalixmx_app/providers/profile_provider.dart';
import 'package:portalixmx_app/services/zkbio_access_service/zkbio_access_service.dart';
import 'package:provider/provider.dart';

class MyAccessQrPage extends StatefulWidget {
  const MyAccessQrPage({super.key});

  @override
  State<MyAccessQrPage> createState() => _MyAccessQrPageState();
}

class _MyAccessQrPageState extends State<MyAccessQrPage> {
  final _zkbioService = ZkbioAccessService.instance;
  ZkbioQrModel? _qr;
  String? _error;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadQr();
  }

  Future<void> _loadQr() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final qr = await _zkbioService.getResidentQr();
      if (mounted) {
        setState(() {
          _qr = qr;
          _loading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = _zkbioService.mapFirebaseError(e);
          _loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final user = context.watch<ProfileProvider>().user;

    return BgGradientScreen(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 65),
            child: Row(
              children: [
                const BackButton(color: Colors.white),
                Expanded(
                  child: Text(
                    l10n.myAccessQr,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.regularTextStyle,
                  ),
                ),
                const SizedBox(width: 48),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: _buildBody(context, l10n, user),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, AppLocalizations l10n, UserModel? user) {
    if (user != null && !user.isApproved) {
      return Center(
        child: Text(
          l10n.accountNotApprovedForQr,
          textAlign: TextAlign.center,
          style: AppTextStyles.subHeadingTextStyle,
        ),
      );
    }

    if (_loading) {
      return const Center(child: LoadingWidget());
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 16,
          children: [
            Text(
              _error!,
              textAlign: TextAlign.center,
              style: AppTextStyles.subHeadingTextStyle.copyWith(color: Colors.red),
            ),
            TextButton(
              onPressed: _loadQr,
              child: Text(l10n.tryAgain),
            ),
          ],
        ),
      );
    }

    if (_qr == null) {
      return Center(child: Text(l10n.zkbioNotConfigured));
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          l10n.myAccessQrDescription,
          textAlign: TextAlign.center,
          style: AppTextStyles.subHeadingTextStyle,
        ),
        const SizedBox(height: 24),
        ZkbioQrWidget(
          qrPayload: _qr!.qrPayload,
          onRefresh: () async {
            final refreshed = await _zkbioService.getResidentQr();
            setState(() => _qr = refreshed);
            return refreshed.qrPayload;
          },
        ),
      ],
    );
  }
}
