enum Measure {
  // 1
  gram,
  ounce,
  kilogram,
  pound,
  // 2
  milliliter,
  liter,
  // 3
  piece,
  // 4
  meter,
  centimeter,
  inch,
}

List<Map<String, dynamic>> measureListOptions(){
  return [
    {'value': Measure.kilogram, 'label': 'Kilogram'},
    {'value': Measure.meter, 'label': 'Meter'},
    {'value': Measure.piece, 'label': 'Pieces'},
    {'value': Measure.liter, 'label': 'Liter'},
    {'value': Measure.pound, 'label': 'Pound'},
    {'value': Measure.ounce, 'label': 'Ounce'},
    {'value': Measure.gram, 'label': 'Gram'},
    {'value': Measure.milliliter, 'label': 'Milliliter'},
    {'value': Measure.centimeter, 'label': 'Centimeter'},
    {'value': Measure.inch, 'label': 'Inch'},
  ];
}

String measureAbbr(Measure measure){
  if(measure.name == 'meter') return 'm';
  if(measure.name == 'centimeter') return 'cm';
  if(measure.name == 'kilogram') return 'kg';
  if(measure.name == 'piece') return 'pcs';
  if(measure.name == 'ounce') return 'oz';
  if(measure.name == 'pound') return 'lb';
  if(measure.name == 'milliliter') return 'ml';
  if(measure.name == 'liter') return 'l';
  if(measure.name == 'inch') return 'in';
  return measure.name;
}

String measureConvert(Measure from, Measure to, double value, {int fractionDigits = 2}){
  if(from == to) return value.toString();
  
  if(from == Measure.milliliter && to == Measure.liter) return (value * 0.001).toStringAsFixed(fractionDigits);
  if(from == Measure.milliliter && to == Measure.ounce) return (value * 0.033814).toStringAsFixed(fractionDigits);
  
  if(from == Measure.liter && to == Measure.milliliter) return (value * 1000).toStringAsFixed(fractionDigits);
  if(from == Measure.liter && to == Measure.ounce) return (value * 33.814).toStringAsFixed(fractionDigits);

  if(from == Measure.gram && to == Measure.kilogram) return (value * 0.001).toStringAsFixed(fractionDigits);
  if(from == Measure.gram && to == Measure.ounce) return (value * 0.035274).toStringAsFixed(fractionDigits);
  if(from == Measure.gram && to == Measure.pound) return (value * 0.0022046).toStringAsFixed(fractionDigits);

  if(from == Measure.kilogram && to == Measure.gram) return (value * 1000).toStringAsFixed(fractionDigits);
  if(from == Measure.kilogram && to == Measure.pound) return (value * 2.2046).toStringAsFixed(fractionDigits);
  if(from == Measure.kilogram && to == Measure.ounce) return (value * 35.274).toStringAsFixed(fractionDigits);

  if(from == Measure.ounce && to == Measure.milliliter) return (value * 29.5735).toStringAsFixed(fractionDigits);
  if(from == Measure.ounce && to == Measure.liter) return (value * 0.0295735).toStringAsFixed(fractionDigits);
  if(from == Measure.ounce && to == Measure.pound) return (value * 0.0625).toStringAsFixed(fractionDigits);
  if(from == Measure.ounce && to == Measure.kilogram) return (value * 0.0283495).toStringAsFixed(fractionDigits);
  if(from == Measure.ounce && to == Measure.gram) return (value * 28.3495).toStringAsFixed(fractionDigits);  

  if(from == Measure.meter && to == Measure.centimeter) return (value * 100).toStringAsFixed(fractionDigits);
  if(from == Measure.meter && to == Measure.inch) return (value * 39.3701).toStringAsFixed(fractionDigits);

  if(from == Measure.centimeter && to == Measure.meter) return (value * 0.01).toStringAsFixed(fractionDigits);
  if(from == Measure.centimeter && to == Measure.inch) return (value * 0.393701).toStringAsFixed(fractionDigits);

  if(from == Measure.pound && to == Measure.ounce) return (value * 16).toStringAsFixed(fractionDigits);
  if(from == Measure.pound && to == Measure.kilogram) return (value * 0.453592).toStringAsFixed(fractionDigits);
  if(from == Measure.pound && to == Measure.gram) return (value * 453.592).toStringAsFixed(fractionDigits);

  if(from == Measure.inch && to == Measure.centimeter) return (value * 2.54).toStringAsFixed(fractionDigits);
  if(from == Measure.inch && to == Measure.meter) return (value * 0.0254).toStringAsFixed(fractionDigits);

  return '';
}