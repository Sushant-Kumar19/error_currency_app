import 'mission_model.dart';

List<Mission> allMissions = [
  Mission(
    id: 1,
    title: 'Click a Laptop',
    description: 'Take a clear photo of a laptop',
    rewardPoints: 50,
    validTags: ['laptop', 'notebook', 'computer'],
  ),

  Mission(
    id: 2,
    title: 'Click an Earphone',
    description: 'Take a clear photo of an earphone',
    rewardPoints: 30,
    validTags: ['earphone', 'headset', 'earbuds', 'wire', 'black'],
  ),

  Mission(
    id: 3,
    title: 'Click a Door',
    description: 'Take a clear photo of a door',
    rewardPoints: 20,
    validTags: ['door', 'entrance', 'gate'],
  ),

  // 🇮🇳 NEW MISSION
  Mission(
    id: 4,
    title: 'Click Indian Currency',
    description: 'Take a clear photo of Indian currency (note or coin)',
    rewardPoints: 40,
    validTags: [
      'currency',
      'money',
      'banknote',
      'coin',
      'rupee',
      'cash',
      'indian rupee',
    ],
  ),
];
