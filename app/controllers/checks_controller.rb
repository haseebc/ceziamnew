require "rubygems"
require 'net/ssh'
require 'net/scp'
require "crack"
require "json"
require 'open-uri'

class ChecksController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create, :show]

  def new
    @check = Check.new
  end

  def create
    # Run the check using the user input
    targeth = params[:hostname] # Need to secure this action!!!
    ports_to_check = "20,21,25,53,67,80,135,137,138,139,161,389,445,548,1433,3389"

    @jumphost = "ceziam.com"
    @username = "root"
    @password = "ill3matic"
    @cmd = "nmap -sV -oX /var/www/html/output2.xml -p #{ports_to_check} #{targeth}"

    begin
      ssh = Net::SSH.start(@jumphost, @username, :password => @password)
      res = ssh.exec!(@cmd)
      ssh.close
      puts res
      rescue
      puts "Unable to connect to #{@jumphost} using #{@username}/#{@password}"
    end

    # Convert the XML file into JSON file
    unparsed_doc = open("http://ceziam.com:8080/output2.xml")
    myXML2  = Crack::XML.parse(unparsed_doc)
    myJSON2 = myXML2.to_json

    # Create the check and store the JSON object
    @check = Check.new(hostname: params[:hostname])
    @check.user = current_user
    @check.fullresponse = myJSON2

    # Save the check
    if @check.save
        redirect_to check_path(@check)
    else
      # Redirect to the home page
      redirect_to root_path
    end

    #attacksurface_check
    #this is using a hacked version of Enumall.sh, which is based on the Recon-Ng. Enumall.sh uses Google scraping, Bing scraping, Baidu scraping, Netcraft, and brute forcing using a wordlist. You can see a demo of the script here:
    @cmd_attack_surface = "/home/haseeb/tools/recon-ng/domain/enumall.py #{targeth}"
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
    url = "http://ceziam.com:8080/#{targeth}.json"
    serialized_subdomains = open(url).read
    subdomains = JSON.parse(serialized_subdomains)
    @subdomains_neat = JSON.pretty_generate(subdomains)


  end

  def show
    @check = Check.find(params[:id])
  end
  

  

  private

  def hostname_param
    params.require(:check).permit(:hostname)
  end

end