# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

State.all.each do |s|
  s.destroy
end
State.create([
    {
        name: 'Victoria',
        abbreviation: 'vic',
        product_group: 'IDV'
    },
    {
        name: 'New South Wales',
        abbreviation: 'nsw',
        product_group: 'IDN'
    },
    {
        name: 'Queensland',
        abbreviation: 'qld',
        product_group: 'IDQ'
    },
    {
        name: 'Tasmania',
        abbreviation: 'tas',
        product_group: 'IDT'
    },
    {
        name: 'Northern Territory',
        abbreviation: 'nt',
        product_group: 'IDD'
    },
    {
        name: 'Western Australia',
        abbreviation: 'wa',
        product_group: 'IDW'
    },
    {
        name: 'South Australia',
        abbreviation: 'sa',
        product_group: 'IDS'
    },
    {
        name: 'Antarctica',
        abbreviation: 'ant',
        product_group: 'IDT'
    }
                      ])

Metric.all.each do |m|
  m.destroy
end
Metric.create([
    {
        name: 'Degrees Celsius',
        abbreviation: '°C'
    },
    {
        name: 'Meters',
        abbreviation: 'm'
    },
    {
        name: 'Kilometres Per Hour',
        abbreviation: 'km/h'
    },
    {
        name: 'Hectopascals',
        abbreviation: 'hPa'
    },
    {
        name: 'Millimetres',
        abbreviation: 'mm'
    },
    {
        name: 'Percent',
        abbreviation: '%'
    },
    {
        name: 'Kilometres',
        abbreviation: 'km'
    }
                        ])

ReadingType.all.each do |r|
  r.destroy
end
celsius = Metric.where(name: 'Degrees Celsius').first
meters = Metric.where(name: 'Meters').first
kph = Metric.where(name: 'Kilometres Per Hour').first
hpa = Metric.where(name: 'Hectopascals').first
mm = Metric.where(name: 'Millimetres').first
percent = Metric.where(name: 'Percent').first
km = Metric.where(name: 'Kilometres').first
ReadingType.create([
    {
        display_order: 2,
        name: 'Temperature (Apparent)',
        bom_field_name: 'apparent_t',
        numeric: true,
        metric_id: celsius.id
    },
    {
        display_order: 15,
        name: 'Cloud',
        bom_field_name: 'cloud',
        numeric: false,
        metric_id: nil
    },
    {
        display_order: 16,
        name: 'Cloud Base Distance',
        bom_field_name: 'cloud_base_m',
        numeric: true,
        metric_id: meters.id
    },
    {
        display_order: 17,
        name: 'Cloud Type',
        bom_field_name: 'cloud_type',
        numeric: false,
        metric_id: nil
    },
    {
        display_order: 3,
        name: 'Delta-T',
        bom_field_name: 'delta_t',
        numeric: true,
        metric_id: celsius.id
    },
    {
        display_order: 12,
        name: 'Wind Gust Speed',
        bom_field_name: 'gust_kmh',
        numeric: true,
        metric_id: kph.id
    },
    {
        display_order: 1,
        name: 'Air Temperature',
        bom_field_name: 'air_temp',
        numeric: true,
        metric_id: celsius.id
    },
    {
        display_order: 4,
        name: 'Dew Point',
        bom_field_name: 'dewpt',
        numeric: true,
        metric_id: celsius.id
    },
    {
        display_order: 5,
        name: 'Pressure',
        bom_field_name: 'press',
        numeric: true,
        metric_id: hpa.id
    },
    {
        display_order: 6,
        name: 'Pressure (MSL)',
        bom_field_name: 'press_msl',
        numeric: true,
        metric_id: hpa.id
    },
    {
        display_order: 7,
        name: 'Pressure (QNH)',
        bom_field_name: 'press_qnh',
        numeric: true,
        metric_id: hpa.id
    },
    {
        display_order: 8,
        name: 'Pressure Trend',
        bom_field_name: 'press_tend',
        numeric: true,
        metric_id: hpa.id
    },
    {
        display_order: 9,
        name: 'Rainfall',
        bom_field_name: 'rain_trace',
        numeric: true,
        metric_id: mm.id
    },
    {
        display_order: 10,
        name: 'Relative Humidity',
        bom_field_name: 'rel_hum',
        numeric: true,
        metric_id: percent.id
    },
    {
        display_order: 14,
        name: 'Visibility',
        bom_field_name: 'vis_km',
        numeric: true,
        metric_id: km.id
    },
    {
        display_order: 13,
        name: 'Wind Direction',
        bom_field_name: 'wind_dir',
        numeric: false,
        metric_id: nil
    },
    {
        display_order: 11,
        name: 'Wind Speed',
        bom_field_name: 'wind_spd_kmh',
        numeric: true,
        metric_id: kph.id
    }
                   ])

Timezone.all.each do |t|
  t.destroy
end
Timezone.create([
    {
        name: 'Eastern Daylight Time',
        abbreviation: 'EDT',
        location: 'Melbourne'
    },
    {
        name: 'Eastern Standard Time',
        abbreviation: 'EST',
        location: 'Brisbane'
    },
    {
        name: 'Central Standard Time',
        abbreviation: 'CST',
        location: 'Darwin'
    },
    {
        name: 'Central Daylight Time',
        abbreviation: 'CDT',
        location: 'Adelaide'
    },
    {
        name: 'Western Standard Time',
        abbreviation: 'WST',
        location: 'Perth'
    }
                ])