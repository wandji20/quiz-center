# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# quiz = Quiz.create!(title: 'culture')
# question = question.create!(quiz: Quiz.first, 
#   description: 'Which number is divisible by 2 and 3', 
#   answers_attributes: [
#   { value: 1 },
#   { value: 2 },
#   { value: 3 },
#   { value: 6, is_correct: true },
#   { value: 4 }
# ])

Quiz.create!(
  [
    { title: 'mathematics' }, 
    { title: 'history' }, 
    { title: 'Geography' }, 
    { title: 'Football' }
  ]
)
mathematics = Quiz.find_by(title: 'mathematics')
geography = Quiz.find_by(title: 'geography')
history = Quiz.find_by(title: 'history')
football = Quiz.find_by(title: 'football')

questions = [
  { 
    quiz: mathematics,
    description: 'Find a and b such that a/b = -1 and a + b = 0',
    points: 1.5,
    answers_attributes: [
      {value: 'a = -1, b = 0'},
      {value: 'a = -1, b = -1'},
      {value: 'a = -1, b = 1', is_correct: true},
      {value: 'a = 0, b = 1'},
      {value: 'a = -1, b = -1'}
    ]
  }, 
    
  {
    quiz: mathematics,
    description: 'What is 302 in base 4?',
    points: 2,
    answers_attributes: [
      {value: '102323 base 4'},
      {value: '1030 base 4'},
      {value: '102332 base 4'},
      {value: 'none'},
      {value: '10232 base 4', is_correct: true }
    ]
  }, 
  
  {
    quiz: mathematics,
    description: 'What is the perimeter of a unit square?',
    answers_attributes: [
    {value: '1 squared meter'},
    {value: '1 squared unit'},
    {value: '4 squared meters'},
    {value: '4 squared units', is_correct: true},
    {value: '4 units'}
    ]
  }, 
  
  {
    quiz: mathematics,
    description: 'What is the square root of zero?',
    answers_attributes: [
      {value: '0', is_correct: true},
      {value: '1'},
      {value: '2'},
      {value: '0.5'},
      {value: 'none'}
    ]
  }, 
  
  {
    quiz: mathematics,
    description: 'The 11th element of the sequence 1, 1/4, 1/9,.. is?',
    points: 1.5,
    answers_attributes: [
      {value: '2/242', is_correct: true},
      {value: '1/11'},
      {value: '2/121'},
      {value: '1/120'},
      {value: '11/121'}
    ]
  },

  {
    quiz: history,
    description: 'Who was America named after?',
    answers_attributes: [
      {value: 'Americana Dahra'},
      {value: 'Vasco Dagama'},
      {value: 'Amerigo Vespucci', is_correct: true},
      {value: 'John America'},
      {value: 'Ricard Amer'}
    ]
  }, 
  
  {
    quiz: history,
    description: 'Who was the 1st American president?',
    answers_attributes: [
      {value: 'George Washington', is_correct: true},
      {value: 'George Bush'},
      {value: 'Martin Luther'},
      {value: 'Abraham Lincoln'},
      {value: 'Barack Obama'}
    ]
  }, 
  
  {
    quiz: history,
    description: 'Who discovered America?',
    answers_attributes: [
      {value: 'Vasco'},
      {value: 'John Luck'},
      {value: 'Otto Von Bismark'},
      {value: 'Christopher Colombus', is_correct: true},
      {value: 'Amerigo Vespucci'}
    ]
  }, 
    
  {
    quiz: history,
    description: 'Who prophecied that America will one day have a black president?',
    answers_attributes: [
      {value: 'Christopher Columbus'},
      {value: 'Martin Luther', is_correct: true},
      {value: 'Martin Lucas Jr'},
      {value: 'King Author'},
      {value: 'Wendy Mall'}
    ]
  }, 
  
  {
    quiz: history,
    description: 'When did the American civil war end?',
    answers_attributes: [
      {value: '1965'},
      {value: '1875'},
      {value: '1865', is_correct: true},
      {value: '1960'},
      {value: '1869'}
    ]
  },
  
  { 
    quiz: geography,
    description: 'What is the highest mountain Africa?',
    answers_attributes: [
      {value: 'Mt Kilimanjaro', is_correct: true},
      {value: 'Mt Cameroon'},
      {value: 'Mt Kenya'},
      {value: 'Mt Everest'},
      {value: 'Greek Mt'}
    ]
  }, 
  
  { 
    quiz: geography,
    description: 'Where is mount Everest found?',
    answers_attributes: [
      {value: 'Africa'},
      {value: 'America'},
      {value: 'Asia', is_correct: true},
      {value: 'Oceans'},
      {value: 'Europe'}
    ]
  }, 
  
  { 
    quiz: geography,
    description: 'Where is the Kalahari desert found?',
    answers_attributes: [
      {value: 'North Africa'},
      {value: 'South America'},
      {value: 'East Africa'},
      {value: 'Southern Africa', is_correct: true},
      {value: 'South Africa'}
    ]
  }, 
  
  { 
    quiz: geography,
    description: 'How many weather conditions have USA?',
    answers_attributes: [
      {value: '2'},
      {value: '4', is_correct: true},
      {value: '3'},
      {value: '5'},
      {value: 'none of the above'}
    ]
  }, 
  
  { 
    quiz: geography,
    description: 'How many planets are in the universe?',
    answers_attributes: [
      {value: '9'},
      {value: '7'},
      {value: '5'},
      {value: '6'},
      {value: '8', is_correct: true}
    ]
  },
  
  {
    quiz: football,
    description: 'Which country won the 2022 edition of AFCON?',
    answers_attributes: [
      {value: 'Cameroon'}, 
      {value: 'Egypt'},
      {value: 'Algeria'},
      {value: 'Senegal', is_correct: true},
      {value: 'Tunisia'}
    ]
  },
  
  {
    quiz: football,
    description: 'For which club does Neymar Jr play as of March 2022?',
    answers_attributes: [
      {value: 'Inter'},
      {value: 'Santos'},
      {value: 'Barcelona'},
      {value: 'PSG', is_correct: true},
      {value: 'Chelsea'}
    ]
  }, 
  
  {
    quiz: football,
    description: 'Which organization governs world football?',
    answers_attributes: [
      {value: 'FIFA', is_correct: true},
      {value: 'CAF'},
      {value: 'CONCACAF'},
      {value: 'UEFA'},
      {value: 'FA'}
    ]
  }, 
  
  {
    quiz: football,
    description: 'Which country will host the 2022 FIFA World Cup?',
    answers_attributes: [
      {value: 'Egypt'},
      {value: 'Qatar', is_correct: true},
      {value: 'Brazil'},
      {value: 'England'},
      {value: 'South Africa'} 
    ]
  },
  
  {
    quiz: football,
    description: 'The manager of chelsea in December 2021 is?',
    answers_attributes: [
      {value: 'Frank Lampard', is_correct: true},
      {value: 'Antonio Conte'},
      {value: 'Jose Mourinho'},
      {value: 'Thomas Tuchel'},
      {value: 'Andre Villas'}
    ]
  }
]

Question.create!(questions)
