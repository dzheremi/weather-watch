# WeatherWatch

*This was a university submission from 2015*

I was required to create an application in any language / framework to capture weather information from the Australian [Bureau of Meteorology]([http://www.bom.gov.au/](http://www.bom.gov.au/)

I elected to use Ruby on Rails, and created a platform which:

* Captured and stored all weather observations from all weather stations within Australia and Antartica using a background service

* Provided a web application to view and search for observations, with map integration via [OpenStreetMap]([https://www.openstreetmap.org](https://www.openstreetmap.org/)

* Provided detailed charts and analytics utilising [ChartJS]([https://www.chartjs.org/](https://www.chartjs.org/)

* Provided basic REST enpoints to retrieve observations in JSON format



### Tech Stack

- Rails 4.0.10

- Postgresql

- SemanticUI

- ChartJS



### Usage

Install GEM dependencies:

```bash
bundle install
```

Setup database environment:

```bash
bin/rake db:create
bin/rake db:migrate
bin/rake db:seed
```

Start web server:

```bash
bin/rails server
```

Fetch all weather stations:

```bash
bin/rails runner Scraper.new.update_stations
```

Start background scraper:

```bash
bin/rails runner Scraper.new.update_observations
```
