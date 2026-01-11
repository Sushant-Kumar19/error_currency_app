import 'package:real_world_app/features/missions/mission_model.dart';

// import '../missions/mission_model.dart';

class UserProvider {
  static int walletPoints = 0;
  static final List<Mission> completedMissions = [];

  static get walletPointsNotifier => null;

  static void addPoints(int points, Mission mission) {
    walletPoints += points;

    if (!completedMissions.contains(mission)) {
      completedMissions.add(mission);
    }
  }
}
