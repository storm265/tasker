enum StorageDataType {
  email('email'),
  password('password'),
  username('username'),
  accessToken('accessToken'),
  refreshToken('refreshToken'),
  id('id'),
  avatarUrl('avatarUrl');

  final String type;
  const StorageDataType(this.type);
}