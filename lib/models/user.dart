class BCUser {
  final String uid;

  BCUser({required this.uid});
}

class BCUserData {
  final String uid;
  final String name;
  final String type;
  final int bottle;

  BCUserData(
      {required this.uid,
      required this.name,
      required this.type,
      required this.bottle});
}
