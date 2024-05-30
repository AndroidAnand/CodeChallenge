class ApiEndPoints {
  static const String getCountries = "countries";
  static String getStates(String countryId) =>"countries/$countryId/states";
}