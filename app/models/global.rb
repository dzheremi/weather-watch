class Global

  BOM_BASE_URL = 'http://www.bom.gov.au'
  OBSERVATION_PRODUCT_CODE = ['60801', '60803']
  OBSERVATION_TABLE_DEFAULT_SIZE = 50
  TEMP_FIELD_NAME = 'Air Temperature'
  PRES_FIELD_NAME = 'Pressure'
  HUMI_FIELD_NAME = 'Relative Humidity'
  MINI_READING_TYPES = [
      'Air Temperature',
      'Pressure',
      'Rainfall',
      'Relative Humidity',
      'Wind Direction',
      'Wind Speed'
  ]
  STATISTICS_READING_TYPES = [
      {name: 'Air Temperature', min: true, max: true, avg: true},
      {name: 'Pressure', min: true, max: true, avg: true},
      {name: 'Wind Speed', min: false, max: true, avg: true},
      {name: 'Wind Gust Speed', min: false, max: true, avg: true},
      {name: 'Dew Point', min: true, max: true, avg: true},
      {name: 'Rainfall', min: false, max: true, avg: false}
  ]
  RECORDS_READING_TYPES = [
      {name: 'Highest Recorded Temperature', reading_name: 'Air Temperature', max: true},
      {name: 'Lowest Recorded Temperature', reading_name: 'Air Temperature', max: false},
      {name: 'Fastest Wind Speed', reading_name: 'Wind Speed', max: true},
      {name: 'Fastest Wind Gust', reading_name: 'Wind Gust Speed', max: true},
      {name: 'Most Rain in a Single Day', reading_name: 'Rainfall', max: true}
  ]
  AVERAGE_OBSERVATIONS_LIMIT = 100

end
