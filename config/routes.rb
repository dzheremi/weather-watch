WeatherApp::Application.routes.draw do

  root 'site#index'

  get 'capitals' => 'site#capitals'

  get 'map' => 'site#map'
  get 'sub_map' => 'site#sub_map'

  get 'favorites' => 'site#favorites'
  get 'toggle_favorite/:id' => 'authentication#toggle_favorite'

  get 'station/:id' => 'site#station'
  get 'station/:id/map' => 'site#station_map'
  get 'station/:id/chart' => 'site#station_chart'
  get 'stations/:keyword' => 'stations#search'

  get 'state/:state' => 'site#state'

  get 'records' => 'site#records'

  get 'observations/:id' => 'observations#show'
  get 'observations/:id/:readings' => 'observations#show'

  get 'table/:id' => 'observations#observation_table'
  get 'table/:id/:readings' => 'observations#observation_table'

  get 'statistics/:id' => 'observations#statistics_table'

  get 'chart/temperature/:id' => 'observations#temperature_chart'
  get 'chart/temperature/:id/:readings' => 'observations#temperature_chart'
  get 'chart/pressure/:id' => 'observations#pressure_chart'
  get 'chart/pressure/:id/:readings' => 'observations#pressure_chart'
  get 'chart/humidity/:id' => 'observations#humidity_chart'
  get 'chart/humidity/:id/:readings' => 'observations#humidity_chart'

  get 'login' => 'authentication#login'
  post 'login' => 'authentication#process_login'

  get 'logout' => 'authentication#logout'

  get 'register' => 'authentication#register'
  post 'register' => 'authentication#save_user'

  get 'user' => 'authentication#edit_user'
  post 'user' => 'authentication#update_user'

  get 'password' => 'authentication#edit_password'
  post 'password' => 'authentication#update_password'

  get 'about' => 'site#about'

end
