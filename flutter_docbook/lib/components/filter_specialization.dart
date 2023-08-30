enum FilterSpecialization {
  all('All'),
  pediatrics('Pediatrics'),
  generalMedicine('General Medicine'),
  eyeSpecialist('Eye Specialist'),
  orthopedics('Orthopedics');

  final String value;
  const FilterSpecialization(this.value);
}
