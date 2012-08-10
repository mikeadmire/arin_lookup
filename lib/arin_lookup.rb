require 'json'
require 'open-uri'

class Arin
  attr_accessor :registration_date, :end_address, :start_address, :net_desc,
    :update_date, :name, :handle

  def self.lookup(ip)
    arin = self.new
    json = arin.get_json(ip)
    arin.assign(json)
    arin
  end

  def get_json(ip)
    begin
      reply = open("http://whois.arin.net/rest/ip/#{ip}.json").read
      JSON.parse(reply)['net']
    rescue
      warn "Unable to connect to ARIN API"
    end
  end

  def assign(json)
    @update_date = json['updateDate']['$'] if defined?(json['updateDate']['$'])
    @registration_date = json['registrationDate']['$'] if defined?(json['registrationDate']['$']) 

    block =  json['netBlocks']['netBlock']
    @end_address = block['endAddress']['$'] if defined? block['endAddress']['$']
    @start_address = block['startAddress']['$'] if defined? block['startAddress']['$']
    @net_desc = block['description']['$'] if defined? block['description']['$']

    @name = json['orgRef']['@name'] if defined? json['orgRef']['@name']
    @name = json['customerRef']['@name'] if defined? json['customerRef']['@name']
    @handle = json['orgRef']['@handle'] if defined? json['orgRef']['@handle']
    @handle = json['customerRef']['@handle'] if defined? json['customerRef']['@handle']
  end
end

if __FILE__ == $0
  aq = Arin.lookup('127.0.0.1')
  p aq
end
