import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../core/models/community_poll_model.dart';
import '../../core/res/firebase_constant.dart';

class CommunityPollsService {
  static final CommunityPollsService _instance = CommunityPollsService._internal();
  factory CommunityPollsService() => _instance;
  CommunityPollsService._internal();

  static CommunityPollsService get instance => _instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  CollectionReference _getPollsCollection() {
    return _firestore.collection(FirebaseConst.communityPollsCol);
  }

  Map<String, dynamic> _normalizePollMap(Map<String, dynamic> data) {
    final copy = Map<String, dynamic>.from(data);
    final ca = copy['createdAt'];
    if (ca is Timestamp) copy['createdAt'] = ca.millisecondsSinceEpoch;
    final ea = copy['endsAt'];
    if (ea is Timestamp) copy['endsAt'] = ea.millisecondsSinceEpoch;
    return copy;
  }

  CommunityPollModel _pollFromSnapshot(DocumentSnapshot snap) {
    final data = snap.data() as Map<String, dynamic>?;
    if (data == null) {
      throw Exception('Poll not found');
    }
    return CommunityPollModel.fromMap({..._normalizePollMap(data), 'id': snap.id});
  }

  static DateTime? _endDateTime(dynamic raw) {
    if (raw == null) return null;
    if (raw is Timestamp) return raw.toDate();
    if (raw is int) return DateTime.fromMillisecondsSinceEpoch(raw);
    return DateTime.fromMillisecondsSinceEpoch((raw as num).toInt());
  }

  Future<List<CommunityPollModel>> getPolls(String societyID) async {
    try {
      final snapshot = await _getPollsCollection()
          .where('societyID', isEqualTo: societyID)
          .get();
      return snapshot.docs.map((doc) => _pollFromSnapshot(doc)).toList();
    } catch (e) {
      throw Exception('Failed to get polls: $e');
    }
  }

  Stream<CommunityPollModel> watchPoll(String pollId) {
    return _getPollsCollection().doc(pollId).snapshots().map(_pollFromSnapshot);
  }

  Future<String?> getMyVoteOptionId(String pollId) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return null;
    final doc = await _getPollsCollection()
        .doc(pollId)
        .collection(FirebaseConst.communityPollVotesSub)
        .doc(uid)
        .get();
    if (!doc.exists) return null;
    final data = doc.data();
    return data?['optionId'] as String?;
  }

  Future<void> submitVote({required String pollId, required String optionId}) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) {
      throw Exception('Not signed in');
    }
    final pollRef = _getPollsCollection().doc(pollId);
    final voteRef = pollRef.collection(FirebaseConst.communityPollVotesSub).doc(uid);

    await _firestore.runTransaction((transaction) async {
      final pollSnap = await transaction.get(pollRef);
      if (!pollSnap.exists) {
        throw Exception('Poll not found');
      }
      final pollData = pollSnap.data() as Map<String, dynamic>;
      final end = _endDateTime(pollData['endsAt']);
      if (end != null && DateTime.now().isAfter(end)) {
        throw Exception('Poll has ended');
      }
      final voteSnap = await transaction.get(voteRef);
      if (voteSnap.exists) {
        throw Exception('Already voted');
      }
      final optionsList = pollData['options'];
      if (optionsList is! List) {
        throw Exception('Invalid poll');
      }
      final options = optionsList.map((e) => Map<String, dynamic>.from(e as Map)).toList();
      var found = false;
      for (var i = 0; i < options.length; i++) {
        if (options[i]['id'] == optionId) {
          options[i]['voteCount'] = (options[i]['voteCount'] as int? ?? 0) + 1;
          found = true;
          break;
        }
      }
      if (!found) {
        throw Exception('Invalid option');
      }
      transaction.set(voteRef, {
        'optionId': optionId,
        'votedAt': FieldValue.serverTimestamp(),
      });
      transaction.update(pollRef, {'options': options});
    });
  }
}
