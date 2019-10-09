# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Community.create([
  { name: "Diet",
    description: "Work on your diet goals, including gaining weight, cutting back on certain items,
                  and food sourcing." },
  { name: "Exercise",
    description: "Goals might include going to classes x times per week, incorporating running into your routine
                  , etc." },
  { name: "Career",
    description: "Network, discover new career paths, quit your current job, etc." },
  { name: "Finance",
    description: "Pay down debt, work on budgeting, invest." },
  { name: "Social",
    description: "Go to more concerts, dance with friends on the weekend, host board game nights." },
  { name: "Hobby",
    description: "Dedicate more time towards a passion, pick up a new hobby, recruit others." },
  { name: "Education",
    description: "Download a relevant learning application, do x lessons per day, go to a meetup, study x hours per week." }
  ])
