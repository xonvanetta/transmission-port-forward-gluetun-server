require 'json'
require 'net/http'
require 'net/https'
require 'securerandom'
require 'socket'
require 'logger'

@logger = Logger.new('qbt_forwarded_port.log', 10, 1024000)

QBT_USERNAME = ENV['QBT_USERNAME'] || 'admin'
QBT_PASSWORD = ENV['QBT_PASSWORD'] || 'adminadmin'
QBT_ADDR = ENV['QBT_ADDR'] || 'http://localhost:8080' # ex. http://10.0.1.48:8080
PORT_FILE = ENV['PORT_FILE'] || '/config/forwarded_port.txt' # ex. /config/forwarded_port.txt


# PORT FILE METHODS
def port_forward_assignment
  forwarded_port = File.read(PORT_FILE).strip
rescue StandardError => e
  @logger.error("Port file read failed (#{e.message})")
  puts "Port file read failed (#{e.message})"
end
# ----------

# QBITTORRENT METHODS
def qbt_auth_login
  uri = URI("#{QBT_ADDR}/api/v2/auth/login?username=#{QBT_USERNAME}&password=#{QBT_PASSWORD}")
  http = Net::HTTP.new(uri.host, uri.port)
  req =  Net::HTTP::Get.new(uri)
  http.request(req)
rescue StandardError => e
  @logger.error("HTTP Request failed (#{e.message})")
  puts "HTTP Request failed (#{e.message})"
end

def qbt_app_preferences(sid)
  uri = URI("#{QBT_ADDR}/api/v2/app/preferences")
  http = Net::HTTP.new(uri.host, uri.port)
  req =  Net::HTTP::Get.new(uri)
  req.add_field "Cookie", sid
  http.request(req)
rescue StandardError => e
  @logger.error("HTTP Request failed (#{e.message})")
  puts "HTTP Request failed (#{e.message})"
end

def qbt_app_setPreferences(sid, forwarded_port)
  uri = URI("#{QBT_ADDR}/api/v2/app/setPreferences?json=%7B%22listen_port%22:%20#{forwarded_port}%7D")
  http = Net::HTTP.new(uri.host, uri.port)
  req =  Net::HTTP::Get.new(uri)
  req.add_field "Cookie", sid
  http.request(req)
rescue StandardError => e
  @logger.error("HTTP Request failed (#{e.message})")
  puts "HTTP Request failed (#{e.message})"
end
# ----------

# get sid from qbt
sid = qbt_auth_login["set-cookie"].split(";")[0]

# get existing port from qbt
qbt_port = JSON.parse(qbt_app_preferences(sid).body)["listen_port"]
@logger.info("current qbt port: #{qbt_port}")
puts "current qbt port: #{qbt_port}"

# get port from file
forwarded_port = port_forward_assignment
@logger.info("forwarded_port: #{forwarded_port}")
puts "forwarded_port: #{forwarded_port}"

# set new port in qbt
if forwarded_port != qbt_port
  response = qbt_app_setPreferences(sid, forwarded_port)
  @logger.info("qbt port changed to #{forwarded_port} (response status: #{response.code}: #{response.message})")
  puts "qbt port changed to #{forwarded_port} (response status: #{response.code}: #{response.message})"
end

@logger.close
