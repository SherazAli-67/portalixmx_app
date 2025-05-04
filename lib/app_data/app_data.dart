class AppData {
  static final List<String> days = [
    'MON', 'TUE','WED', 'THU', 'FRI','SAT', 'SUN'
  ];

  static String getDayByID(int id){
    switch(id){
      case 0:
        return 'MON';
      case 1:
        return 'TUE';
      case 2:
        return 'WED';
      case 3:
        return 'THU';
      case 4:
        return 'FRI';
      case 5:
        return 'SAT';
      case 6:
        return 'SUN';
      default:
        return 'MON';

    }
  }
}