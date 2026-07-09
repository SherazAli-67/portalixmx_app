import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../core/models/community_poll_model.dart';
import '../../../../core/res/app_colors.dart';
import '../../../../core/res/app_textstyles.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/datetime_format_helpers.dart';
import '../../../services/community_polls_service/community_polls_service.dart';
import '../../widgets/bg_gradient_screen.dart';
import '../../widgets/primary_btn.dart';

class CommunityPollsDetailPage extends StatefulWidget {
  const CommunityPollsDetailPage({super.key, required this.poll});
  final CommunityPollModel poll;

  @override
  State<CommunityPollsDetailPage> createState() => _CommunityPollsDetailPageState();
}

class _CommunityPollsDetailPageState extends State<CommunityPollsDetailPage> {
  final _service = CommunityPollsService.instance;
  String? _myVoteOptionId;
  bool _loadingMyVote = true;
  String? _selectedOptionId;
  bool _submitting = false;

  @override
  void initState() {
    super.initState();
    _loadMyVote();
  }

  Future<void> _loadMyVote() async {
    final id = await _service.getMyVoteOptionId(widget.poll.id);
    if (!mounted) return;
    setState(() {
      _myVoteOptionId = id;
      _loadingMyVote = false;
    });
  }

  Future<void> _submitVote() async {
    if (_submitting) return;
    final loc = AppLocalizations.of(context)!;
    final selected = _selectedOptionId;
    if (selected == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(loc.pollSelectOption)));
      return;
    }
    setState(() => _submitting = true);
    try {
      await _service.submitVote(pollId: widget.poll.id, optionId: selected);
      await _loadMyVote();
      if (mounted) setState(() => _selectedOptionId = null);
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(loc.pollVoteFailed)));
      }
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  bool _isExpired(CommunityPollModel poll) {
    final end = poll.endsAt;
    if (end == null) return false;
    return DateTime.now().isAfter(end);
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return StreamBuilder<CommunityPollModel>(
      stream: _service.watchPoll(widget.poll.id),
      initialData: widget.poll,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return BgGradientScreen(
            child: Center(child: Text('${snapshot.error}')),
          );
        }
        final poll = snapshot.data ?? widget.poll;
        final expired = _isExpired(poll);
        final hasVoted = _myVoteOptionId != null;
        final canVote = !expired && !hasVoted && !_loadingMyVote;

        return BgGradientScreen(
          child: Column(
            spacing: 20,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 65),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const BackButton(color: Colors.white),
                    Text(loc.communityPolls, style: AppTextStyles.regularTextStyle),
                    const SizedBox(width: 20),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        spacing: 20,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(poll.createdBy, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.darkGreyColor2)),
                              if (poll.endsAt != null)
                                Text(
                                  loc.pollEndsAt(DateTimeFormatHelpers.formatDateTime(poll.endsAt!)),
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.darkGreyColor2),
                                ),
                            ],
                          ),
                          Text(poll.question, maxLines: 5, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black)),
                          if (poll.imageUrl != null && poll.imageUrl!.isNotEmpty)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(imageUrl: poll.imageUrl!, fit: BoxFit.cover),
                            ),
                          if (expired) Text(loc.pollEnded, style: TextStyle(color: AppColors.darkGreyColor2)),
                          if (hasVoted && !expired) Text(loc.pollAlreadyVoted, style: TextStyle(color: AppColors.darkGreyColor2)),
                          if (_loadingMyVote) const Center(child: Padding(padding: EdgeInsets.all(16), child: CircularProgressIndicator())),
                          if (!_loadingMyVote)
                            Column(
                              spacing: 8,
                              children: poll.options.map((option) {
                                if (canVote) {
                                  final selected = _selectedOptionId == option.id;
                                  return GestureDetector(
                                    onTap: () => setState(() => _selectedOptionId = option.id),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(13),
                                        border: Border.all(color: selected ? AppColors.btnColor : AppColors.greyColor2),
                                        color: const Color(0xffEFEEFF).withValues(alpha: 0.3),
                                      ),
                                      padding: const EdgeInsets.all(15),
                                      child: Row(
                                        children: [
                                          Icon(selected ? Icons.radio_button_checked : Icons.radio_button_off, color: AppColors.primaryColor, size: 22),
                                          const SizedBox(width: 12),
                                          Expanded(child: Text(option.text, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: AppColors.primaryColor))),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                                return _TallyOptionRow(option: option, poll: poll, highlight: option.id == _myVoteOptionId);
                              }).toList(),
                            ),
                          if (canVote && !_loadingMyVote)
                            SizedBox(
                              width: double.infinity,
                              child: PrimaryBtn(
                                onTap: _submitVote,
                                btnText: loc.pollVote,
                                isLoading: _submitting,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _TallyOptionRow extends StatelessWidget {
  const _TallyOptionRow({required this.option, required this.poll, this.highlight = false});
  final PollOption option;
  final CommunityPollModel poll;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    final total = poll.options.fold<int>(0, (a, o) => a + o.voteCount);
    final pct = total > 0 ? option.voteCount / total : 0.0;
    final pctLabel = total > 0 ? (100 * option.voteCount / total).round() : 0;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: highlight ? AppColors.btnColor : AppColors.greyColor2),
        color: const Color(0xffEFEEFF).withValues(alpha: 0.3),
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          Row(
            children: [
              Expanded(child: Text(option.text, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: AppColors.primaryColor))),
              Text('$pctLabel%', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.darkGreyColor2)),
            ],
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: pct,
              minHeight: 6,
              backgroundColor: AppColors.greyColor2.withValues(alpha: 0.3),
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.btnColor),
            ),
          ),
        ],
      ),
    );
  }
}
