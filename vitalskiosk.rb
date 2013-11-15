require 'sinatra'
#require 'sinatra/base'
require 'active_record'
require 'serialport'
require 'rack'
require 'logger'

require Sinatra::Application.root + '/lib/controller'
require Sinatra::Application.root + '/lib/tm2655'
  
class BPKiosk
  
  settings = YAML.load_file("settings.yml")["device"]
  
  configure do
    set :title, 'Open BP Kiosk'
    set :device, settings["port"] #TODO: move to a config yaml
    set :baud, settings["baud"]
    set :printer_port, 4242
    db_config = {:adapter => 'sqlite3',
                 :database => Sinatra::Application.root + '/db/bpkiosk.db'}
    
    ActiveRecord::Base.establish_connection(db_config)
  end    
end
