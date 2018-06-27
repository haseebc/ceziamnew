require "rubygems"
require 'net/ssh'
require 'net/scp'
require "crack"
require "json"
require 'open-uri'

class CheckService 
    def initialize(target)
        @target = target
        @check = Check.new(hostname: target)
    end

    def run
        ports_check_response = ports_check(@target)  
        @check.fullresponse = ports_check_response if ports_check_response

        subdomain_response = subdomains_check(@target)
        @check.attacksurface = subdomain_response if subdomain_response

        return @check
    end

    def ports_check(target)
        ports_to_check = "20,21,25,53,67,80,135,137,138,139,161,389,445,548,1433,3389"
    
        @jumphost = "websec.app"
        @username = "root"
        @password = ENV["PASS_SECRET"] 
        @cmd = "nmap -sV -oX /var/www/html/output2.xml -p #{ports_to_check} #{@target}"
    
        begin
          ssh = Net::SSH.start(@jumphost, @username, :password => @password)
          res = ssh.exec!(@cmd)
          ssh.close
          puts res
          rescue
          puts "Unable to connect to #{@jumphost} using #{@username}/#{@password}"
        end
    
        # Convert the XML file into JSON file
        unparsed_doc = open("http://websec.app:8080/output2.xml")
        myXML2  = Crack::XML.parse(unparsed_doc)
        myJSON2 = myXML2.to_json
    
        return myJSON2
      end
    
      def subdomains_check(target)
        @jumphost = "websec.app"
        @username = "root"
        @password = ENV["PASS_SECRET"]
    
        #attacksurface_check
        #this is using a hacked version of Enumall.sh, which is based on the Recon-Ng. Enumall.sh uses Google scraping, Bing scraping, Baidu scraping, Netcraft, and brute forcing using a wordlist. You can see a demo of the script here:
        @cmd_attack_surface = "/home/haseeb/tools/recon-ng/domain/enumall.py #{target}"
        @cmd_send_to_apache = "mv * /var/www/html/"
    
        begin
          ssh = Net::SSH.start(@jumphost, @username, :password => @password)
          res = ssh.exec!(@cmd_attack_surface)
          res = ssh.exec!(@cmd_send_to_apache)
          ssh.close
          puts res
          rescue
          puts "Unable to connect to #{@jumphost} using #{@username}/#{@password}"
        end
    
        #Get the newly created json file and have it neat to present in HTML
        url = "http://websec.app:8080/#{target}.json"
        serialized_subdomains = open(url).read
        subdomains = JSON.parse(serialized_subdomains)
        # @subdomains_neat = JSON.pretty_generate(subdomains)
    
        return subdomains
      end
end
