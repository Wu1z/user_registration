enum Profiles {
  user('USER'),
  manager('MANAGER'),
  administrator('ADMINISTRATOR');

  final String name;

  const Profiles(this.name);
}