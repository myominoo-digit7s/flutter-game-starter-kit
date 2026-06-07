import 'package:equatable/equatable.dart';

class GameResult extends Equatable {
  final int score;
  final int bestScore;
  final int coinsEarned;
  final Duration duration;
  final bool isNewBestScore;

  const GameResult({
    required this.score,
    required this.bestScore,
    required this.coinsEarned,
    required this.duration,
    required this.isNewBestScore,
  });

  GameResult copyWith({
    int? score,
    int? bestScore,
    int? coinsEarned,
    Duration? duration,
    bool? isNewBestScore,
  }) {
    return GameResult(
      score: score ?? this.score,
      bestScore: bestScore ?? this.bestScore,
      coinsEarned: coinsEarned ?? this.coinsEarned,
      duration: duration ?? this.duration,
      isNewBestScore: isNewBestScore ?? this.isNewBestScore,
    );
  }

  @override
  List<Object?> get props => [
    score,
    bestScore,
    coinsEarned,
    duration,
    isNewBestScore,
  ];
}
