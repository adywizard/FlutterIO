enum Topics {
  topicFeedConveyor(name: '/motors/feedConveyor', description: 'Feed Conveyor'),
  topicEntryCoveyor(
    name: '/motors/entryConveyor',
    description: 'Entry Conveyor',
  ),
  topicLoad(name: '/motors/load', description: 'Load/Left'),
  topicUnload(name: '/motors/unload', description: 'Unload/Right'),
  topicTurn(name: '/motors/turn', description: 'Turn'),
  topicRightConveyor(
    name: '/motors/rightConveyor',
    description: 'Right Conveyor',
  ),
  topicLeftConveyor(name: '/motors/leftConveyor', description: 'Left Conveyor'),
  topicEmitters(name: '/emitters/emit', description: 'Emitter'),
  topicSemi(name: '/start/semiAuto', description: 'Unload line'),
  willTopic(name: '/last/will/app', description: 'I died'),
  diconnectedTopic(name: '/app/diconnected', description: 'Disconnected Topic'),
  connectedTopic(name: '/app/connected', description: 'Connected Topic'),
  topicDailyGoal(name: '/dailyBoxesGoal', description: 'Daily Goal');

  const Topics({required this.name, required this.description});

  final String name;
  final String description;
}

enum TopicsIn {
  topicAtEntry(name: '/sensors/atEntry', description: 'At Entry'),
  topicAtLoad(name: '/sensors/atTurntable', description: 'At Turntable'),
  topicAtUnload(name: '/sensors/atFront', description: 'At Front'),
  topicAtleft(name: '/sensors/atLeft', description: 'At Left'),
  topicAtRight(name: '/sensors/atRight', description: 'At Right'),
  topicBoxCountSmall(
    name: '/sensors/boxCountSmall',
    description: 'Box Count Small',
  ),
  topicBoxCountBig(name: '/sensors/boxCountBig', description: 'Box Count Big'),
  topicBoxTotal(name: 'sensors/boxTotal', description: 'Box Count Total'),

  topicPlcOnline(name: 'plc/online', description: 'PLC Online'),
  topicBoxHeight(name: '/sensors/boxHeight', description: 'Box Height');

  const TopicsIn({required this.name, required this.description});

  final String name;
  final String description;
}
