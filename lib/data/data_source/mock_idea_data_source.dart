import 'package:feedback_loop/data/models/comment_model.dart';
import 'package:feedback_loop/data/models/idea_model.dart';

class MockIdeaDataSource {
  final List<IdeaModel> _ideas = [
    const IdeaModel(
      id: 'idea_1',
      authorId: 'user_1',
      authorName: 'Deb Josh',
      authorRole: "Passionné d'informatique",
      authorInitial: 'D',
      timeAgo: '2h',
      title: "Plateforme collaborative d'idées",
      description:
          'Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam epat.',
      rating: 4.0,
      voteCount: 1050,
      commentCount: 41,
      hasVoted: false,
      voteDistribution: {5: 680, 4: 210, 3: 100, 2: 40, 1: 20},
    ),
    const IdeaModel(
      id: 'idea_2',
      authorId: 'user_2',
      authorName: 'Conceptia',
      authorRole: 'Chef de projet',
      authorInitial: 'C',
      timeAgo: '1j',
      title: 'Système de gamification agile',
      description:
          'Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam epat.',
      rating: 3.7,
      voteCount: 5800,
      commentCount: 206,
      hasVoted: false,
      voteDistribution: {5: 2500, 4: 1800, 3: 900, 2: 400, 1: 200},
    ),
    const IdeaModel(
      id: 'idea_3',
      authorId: 'user_3',
      authorName: 'Dioda',
      authorRole: 'Ingénieur logiciel',
      authorInitial: 'D',
      timeAgo: '10min',
      title: 'Architecture offline-first mobile',
      description:
          'Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam epat.',
      rating: 3.1,
      voteCount: 90,
      commentCount: 10,
      hasVoted: false,
      voteDistribution: {5: 25, 4: 20, 3: 25, 2: 12, 1: 8},
    ),
    const IdeaModel(
      id: 'idea_4',
      authorId: 'user_4',
      authorName: 'Ribery Duboc',
      authorRole: 'Founder AfriCorp',
      authorInitial: 'R',
      timeAgo: '21h',
      title: 'Incubateur de startups panafricain',
      description:
          'Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam epat.',
      rating: 2.5,
      voteCount: 52,
      commentCount: 32,
      hasVoted: false,
      voteDistribution: {5: 8, 4: 10, 3: 15, 2: 12, 1: 7},
    ),
  ];

  final Map<String, List<CommentModel>> _comments = {
    'idea_1': [
      const CommentModel(
        id: 'comment_1',
        ideaId: 'idea_1',
        authorName: 'Samuel Ivou',
        authorInitial: 'S',
        timeAgo: '2h',
        rating: 3.0,
        content:
            'Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud',
      ),
    ],
  };

  Future<List<IdeaModel>> getIdeas() async {
    await Future.delayed(const Duration(milliseconds: 150));
    return List.unmodifiable(_ideas);
  }

  Future<IdeaModel> createIdea({
    required String title,
    required String description,
    String? imageUrl,
  }) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final newIdea = IdeaModel(
      id: 'idea_${DateTime.now().millisecondsSinceEpoch}',
      authorId: 'user_1',
      authorName: 'Deb Josh',
      authorRole: "Passionné d'informatique",
      authorInitial: 'D',
      timeAgo: "À l'instant",
      title: title,
      description: description,
      imageUrl: imageUrl,
      rating: 5.0,
      voteCount: 1,
      commentCount: 0,
      hasVoted: true,
      userVote: 5.0,
      voteDistribution: const {5: 1, 4: 0, 3: 0, 2: 0, 1: 0},
    );
    _ideas.insert(0, newIdea);
    return newIdea;
  }

  Future<void> voteIdea({
    required String ideaId,
    required double rating,
  }) async {
    await Future.delayed(const Duration(milliseconds: 150));
    final index = _ideas.indexWhere((idea) => idea.id == ideaId);
    if (index != -1) {
      final current = _ideas[index];
      final newVoteCount = current.voteCount + 1;
      final newRating =
          ((current.rating * current.voteCount) + rating) / newVoteCount;
      final intStar = rating.round().clamp(1, 5);
      final newDist = Map<int, int>.from(current.voteDistribution);
      newDist[intStar] = (newDist[intStar] ?? 0) + 1;

      _ideas[index] = current.copyWith(
        rating: double.parse(newRating.toStringAsFixed(1)),
        voteCount: newVoteCount,
        hasVoted: true,
        userVote: rating,
        voteDistribution: newDist,
      ) as IdeaModel;
    }
  }

  Future<List<CommentModel>> getComments(String ideaId) async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _comments[ideaId] ?? [];
  }

  Future<void> addComment({
    required String ideaId,
    required String content,
    required double rating,
  }) async {
    await Future.delayed(const Duration(milliseconds: 150));
    final newComment = CommentModel(
      id: 'comment_${DateTime.now().millisecondsSinceEpoch}',
      ideaId: ideaId,
      authorName: 'Deb Josh',
      authorInitial: 'D',
      timeAgo: "À l'instant",
      rating: rating,
      content: content,
    );
    if (!_comments.containsKey(ideaId)) {
      _comments[ideaId] = [];
    }
    _comments[ideaId]!.add(newComment);

    final ideaIndex = _ideas.indexWhere((i) => i.id == ideaId);
    if (ideaIndex != -1) {
      _ideas[ideaIndex] = _ideas[ideaIndex].copyWith(
        commentCount: _ideas[ideaIndex].commentCount + 1,
      ) as IdeaModel;
    }
  }
}
