#enable :sessions
use Rack::Session::Pool, :expire_after => 2592000

require "json"

helpers do
    
end

get '/' do
  $bpmachine = TM2655.new settings.device, settings.baud
  erb :index  
end

get '/read' do
  if $bpmachine.nil?
    $bpmachine = TM2655.new settings.device, settings.baud
  end
  erb :read  
end

get '/stop' do
  if $bpmachine.nil?
    $bpmachine = TM2655.new settings.device, settings.baud
  end
  
  $bpmachine.stop
  
  sleep 20
end

get '/start' do
  if $bpmachine.nil?
    $bpmachine = TM2655.new settings.device, settings.baud
  end
  
  $bpmachine.start
  
  sleep 30
  
  $bpmachine.response
  
  $bpmachine.bp 
  
  sleep 20
  
  $bpmachine.response 
  
  $bpmachine.pulse 
  
  sleep 20
  
  $bpmachine.response
  
end

get '/readings' do
  if $bpmachine.nil?
    $bpmachine = TM2655.new settings.device, settings.baud
  end
  erb :readings  
end

get '/display_bp' do
  if $bpmachine.nil?
    $bpmachine = TM2655.new settings.device, settings.baud
  end
  
  result = {}
  
  result["systolic"] = $bpmachine.systolic rescue nil
  result["diastolic"] = $bpmachine.diastolic rescue nil
  result["pulse"] = $bpmachine.pulse_rate rescue nil
  result["pulse_env"] = $bpmachine.pulses rescue []
    
  result.to_json  
    
end

