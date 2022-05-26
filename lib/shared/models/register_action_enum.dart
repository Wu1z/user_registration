enum RegisterAction {
  insert('created'),
  update('updated'),
  delete('deleted');

  final String value;

  const RegisterAction(this.value);
}