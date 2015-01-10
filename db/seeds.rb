# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'


alpha = PledgeClass.create(
	name: "Alpha",
	pledge_semester: DateTime.new(2011, 9, 1, 0, 0, 0)
	)
alpha.save
beta = PledgeClass.create(
	name: "Beta",
	pledge_semester: DateTime.new(2012, 1, 1, 0, 0, 0)
	)
beta.save
gamma = PledgeClass.create(
	name: "Gamma",
	pledge_semester: DateTime.new(2012, 9, 1, 0, 0, 0)
	)
gamma.save
delta = PledgeClass.create(
	name: "Delta",
	pledge_semester: DateTime.new(2013, 1, 1, 0, 0, 0)
	)
delta.save
epsilon = PledgeClass.create(
	name: "Epsilon",
	pledge_semester: DateTime.new(2013, 9, 1, 0, 0, 0)
	)
epsilon.save
zeta = PledgeClass.create(
	name: "Zeta",
	pledge_semester: DateTime.new(2014, 1, 1, 0, 0, 0)
	)
zeta.save
eta = PledgeClass.create(
	name: "Eta",
	pledge_semester: DateTime.new(2014, 9, 1, 0, 0, 0)
	)
eta.save

venture = Company.create(
	name: "Bayes Impact",
	description: "Bayes Impact is a super cool startup that went through YC. It's a nonprofit.",
	logo_url: "companies/bayesimpact.png",
	isVenture: true)
venture.save
venture = Company.create(
	name: "Berkeley Tech Review",
	description: "Journalism wooo.",
	logo_url: "companies/btr.png",
	isVenture: true)
venture.save
venture = Company.create(
	name: "Cibo",
	description: "Get fed.",
	logo_url: "companies/cibo.png",
	isVenture: true)
venture.save
venture = Company.create(
	name: "Illuminating Indian Lives",
	description: "Venture from Anant Agarwal.",
	logo_url: "companies/btr.png",
	isVenture: true)
venture.save
venture = Company.create(
	name: "Caviar",
	description: "Get everyone fed.",
	logo_url: "companies/caviar.jpg",
	isVenture: true)
venture.save

bmobilized = Company.create(
	name: "bMobilized",
	description: "Makes your sites mobile.",
	logo_url: "companies/bmobilized.jpg",
	isVenture: false)

user = Brother.create(
	name: "Aryan Falahatpisheh",
	role: "Tech Chair",
	pledge_class: eta,
	grad_year: DateTime.new(2017, 5, 15, 20, 10, 0),
	description: "Aryan is a cool dude I guess",
	active: true,
	major: "Computer Science")

job = Job.create(
	role: "Mobile Engineer Intern",
	description: "Created a website builder in iOS.",
	brother: user,
	company: bmobilized
	)
user.jobs.push(job)
user.save

user = Brother.create(
	name: "Jasmine Stoy",
	role: "President",
	pledge_class: gamma,
	grad_year: DateTime.new(2016, 5, 15, 20, 10, 0),
	description: "I agree that Aryan is cool",
	image_url: "brothers/Jasmine-Stoy.jpg",
	active: true,
	major: "Business Administration")
user.save

user = Brother.create(
	name: "Anant Agarwal",
	role: "Pledgemaster",
	pledge_class: gamma,
	grad_year: DateTime.new(2016, 05, 15, 20, 10, 0),
	description: "Yeah no that guy's hot",
	image_url: "brothers/Anant-Agarwal.jpg",
	active: true,
	major: "Economics")
user.save


event = RushEvent.create(
	name: "Meet the Chapter",
	time: DateTime.new(2013, 9, 4, 6, 30, 0),
	location: "Bancroft Hotel",
	attire: "Business Casual"
	)
event.save
event = RushEvent.create(
	name: "Social Night",
	time: DateTime.new(2013, 9, 4, 6, 30, 0),
	location: "Bancroft Hotel",
	attire: "Business Casual"
	)
event.save
event = RushEvent.create(
	name: "Individual Interviews",
	time: DateTime.new(2013, 9, 4, 6, 30, 0),
	location: "Bancroft Hotel",
	attire: "Business Casual"
	)
event.save

event = RushEvent.create(
	name: "Individual Interviews",
	time: DateTime.new(2013, 9, 4, 6, 30, 0),
	location: "Bancroft Hotel",
	attire: "Business Casual"
	)
event.save




def getBrother(name)
	user = Brother.find_by(name: name)
	if user.nil?
		user = Brother.create(name: name)
		user.save
	end
	return user
end

def getPledgeClass(name)
	pclass = PledgeClass.find_by(name: name)
	if pclass.nil?
		pclass = PledgeClass.create(name: name)
	end
	return pclass
end

def loadActives
	CSV.foreach("db/Raw/Actives.csv", :headers => true) do |row|
		vals = row.to_hash
		name = vals["Name"]

		pledgeClassName = vals["Class"]
		pledgeClassName.strip!
		pledgeClassName = pledgeClassName.downcase
		pledgeClass = getPledgeClass(pledgeClassName)


		gradYear = (vals["Year"]).to_i
		gradDate = DateTime.new gradYear

		brother = getBrother(name)
		brother.grad_year = gradDate
		brother.pledge_class = pledgeClass
		brother.active = true
		brother.major = vals["Major"]
		image_url = "brothers/" + brother.to_image_name
		if (File.exists? ("public/images/" + image_url))
			brother.image_url = image_url
		end
		brother.save
	end

end

loadActives