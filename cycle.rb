require 'yaml'
require 'net/http'

#set password for router root user
router_pass = ''

cnf = YAML::load_file(File.join(__dir__, 'config.yml'))

# puts cnf['current_mac']

line_num=1
all_macs = []

text=File.open('homepass_macs.txt').read
text.each_line do |line|

  all_macs.push(line)

end

total_macs = all_macs.length
p total_macs
mac_val = all_macs[cnf['current_mac']-1].strip.split(':')

p mac_val

url = URI.parse('http://192.168.1.28:8080/apply.cgi')
req = Net::HTTP::Post.new(url.path)
req.basic_auth 'root', router_pass
req.set_form_data(

'submit_button' => 'WanMAC',
'action' => 'ApplyTake',
'change_action' => '',
'submit_type' => '',
'mac_clone_enable' => 1,
'def_hwaddr' => 6,
'def_hwaddr_0' => '00',
'def_hwaddr_1' => '21',
'def_hwaddr_2' => '29',
'def_hwaddr_3' => 'AA',
'def_hwaddr_4' => '6B',
'def_hwaddr_5' => '1A',
'def_whwaddr' => 6,
'def_whwaddr_0' => mac_val[0],
'def_whwaddr_1' => mac_val[1],
'def_whwaddr_2' => mac_val[2],
'def_whwaddr_3' => mac_val[3],
'def_whwaddr_4' => mac_val[4],
'def_whwaddr_5' => mac_val[5],
)


resp = Net::HTTP.new(url.host, url.port).start {|http| http.request(req) }
puts resp

if cnf['current_mac'] == total_macs
	cnf['current_mac'] =1
else
	cnf['current_mac']+=1
end

File.open(File.join(__dir__, 'config.yml'), 'w') {
	|f| f.write(YAML::dump(cnf)) 
}