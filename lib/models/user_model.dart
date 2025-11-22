class UserModel {
  int? id;
  String nama;
  String username;
  String telepon;
  String alamat;
  String password;
  String? avatarUrl;

  UserModel({
    this.id,
    required this.nama,
    required this.username,
    required this.telepon,
    required this.alamat,
    required this.password,
    this.avatarUrl,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'nama': nama,
        'username': username,
        'telepon': telepon,
        'alamat': alamat,
      'password': password,
      'avatarUrl': avatarUrl,
      };

  factory UserModel.fromMap(Map<String, dynamic> m) => UserModel(
        id: m['id'] as int?,
        nama: m['nama'] ?? '',
        username: m['username'] ?? '',
        telepon: m['telepon'] ?? '',
        alamat: m['alamat'] ?? '',
        password: m['password'] ?? '',
        avatarUrl: m['avatarUrl'],
      );

  Map<String, dynamic> toJson() => toMap();

  factory UserModel.fromJson(Map<String, dynamic> m) => UserModel.fromMap(m);
}
