enum Dirt {
  none,
  rainStains,
  dust,
  fingerprints,
  birdDroppings,
  smudges,
  pollen,
  insectMarks,
}

class SmartWindow {
  final bool isOpen;
  final bool isLocked;

  final List<Dirt> dirtTypes;
  const SmartWindow({
    required this.isOpen,
    required this.isLocked,
    required this.dirtTypes,
  });
  get getIsOpen => isOpen;
  get getIsLocked => isLocked;
  bool get getIsDirty => dirtTypes.any(
        (dirt) => dirt != Dirt.none,
      );
}
