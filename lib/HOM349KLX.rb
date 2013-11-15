require "rubygems"
require "serialport"

class HOM349KLX

  attr_reader :log, :weight

  def initialize(device, baud, parity, data_bits)
  
    @sp = SerialPort.new("#{device}", baud)
    
    @sp.parity = parity
    
    @sp.data_bits = data_bits 
    
    Thread.new {
      
      while true do
      
        char = @sp.getc
        
        @log = "#{@log}#{char}"
        
        if char.to_i(16) == 13
          @weight = @log
          
          @log = ""
        end
        
      end
      
    }
    
  end

  def close
  
    @sp.close
  
  end

end
