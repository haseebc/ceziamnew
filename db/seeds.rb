puts "Cleaning database..."

Vulnerability.destroy_all
Check.destroy_all
User.destroy_all

puts "Creating Ceziam users..."

User.create!(email: "jonathan@ceziam.com", password: "123456")
User.create!(email: "haseeb@ceziam.com", password: "123456")
User.create!(email: "santiago@ceziam.com", password: "123456")
User.create!(email: "haruka@ceziam.com", password: "123456")

puts "Number of checks: #{Check.count} (should be 0)"

puts "Number of vulnerabilities: #{Vulnerability.count} (should be 0)"

puts "Number of users: #{User.count} (should be 4)"

puts "Check the seed file for credentials"

puts "Done"