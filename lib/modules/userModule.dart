class UserModule {
  late final String newusername;
  late final String newpassword;
  int anzahlFahrten = 0;
  void set addFahrten(anzahlFahrten){
    anzahlFahrten++;
  }
  UserModule(this.newusername,this.newpassword);
}