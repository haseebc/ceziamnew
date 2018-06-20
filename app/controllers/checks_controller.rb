require "rubygems"
require 'net/ssh'
require 'net/scp'
require "crack"
require "json"
require 'open-uri'
require 'pry'

class ChecksController < ApplicationController

    def new
        @check = Check.new
    end

    def create  
        # raise 
        # run check using the user input (hostname)
        # targeth = @check.hostname
        # @targeth = targeth
        
        # @check= Check.new(hostname_param)

        targeth = params[:check]["hostname"]
        # targeth = @check.hostname
        @targeth = targeth
        

        @jumphost = "ceziam.com"
        @username = "root"
        @password = "ill3matic"
        @cmd = "nmap -sV -oX /var/www/html/output2.xml -p 21,22,80,3389 #{@targeth}"
        
            begin
                ssh = Net::SSH.start(@jumphost, @username, :password => @password)
                res = ssh.exec!(@cmd)
                ssh.close
                puts res
            rescue
                puts "Unable to connect to #{@jumphost} using #{@username}/#{@password}"
            end

            sleep 12

        # convert the XML file into JSON file
        unparsed_doc = open("http://ceziam.com:8080/output2.xml")
        myXML2  = Crack::XML.parse(unparsed_doc)
        myJSON2 = myXML2.to_json

        # create the check and store the JSON object
        @check = Check.new(hostname_param)   
        @check.user = current_user
        @check.fullresponse = myJSON2

        # save the check
        if @check.save
            redirect_to @check
        else 
            # redirect to the home page
            render 'new'
        end        
    end
    
    def show 
        @check = Check.find(params[:id])
    end

    private 

    def hostname_param
        params.require(:check).permit(:hostname)
    end
end

