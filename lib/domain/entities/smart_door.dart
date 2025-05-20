class SmartDoor {
  final bool isOpen;
  final bool isLocked;
  const SmartDoor({
    required this.isOpen,
    required this.isLocked,
  });

  get getIsOpen => isOpen;
  get getIsLocked => isLocked;
}
