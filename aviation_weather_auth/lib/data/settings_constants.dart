enum Pressure {
  hPA,
  inHg,
  mmHg;

  static String get name => 'Pressure';
}

enum Temperature {
  Celsius('\u00B0C'),
  Farenheit('\u00B0F'),
  Kelvin('\u00B0K');

  const Temperature(this.message);

  final String message;

  static String get name => 'Temperature';
}

enum Mode {
  Light,
  Dark;

  static String get name => 'Mode';
}

enum AltitudeUnit {
  Meters,
  Feet;

  static String get name => 'Altitude Unit';
}

enum WindSpeed {
  kmh,
  ms,
  kts;

  static String get name => 'Wind Speed';
}

enum DistanceUnit {
  Kilometers,
  Miles,
  NauticalMiles;

  static String get name => 'Distance Unit';
}

enum ClockSystem {
  h12('12 Hour'),
  h24('24 Hour');

  const ClockSystem(this.message);

  final String message;

  static String get name => 'Clock System';
}

enum MapStyle {
  Style1,
  Style2,
  Style3;

  static String get name => 'Map Style';
}
