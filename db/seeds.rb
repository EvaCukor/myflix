comedy = Category.create(name: 'Comedy')
sci_fi = Category.create(name: 'Science Fiction')
crime = Category.create(name: 'Crime')
animation = Category.create(name: 'Animation')

Video.create!(title: 'South Park',
             description: 'Follows the misadventures of four irreverent grade-schoolers in the quiet, dysfunctional town of South Park, Colorado.',
             small_cover_url: 'south_park.jpg',
             large_cover_url: 'south_park_large.jpg',
             category: animation)

Video.create!(title: 'Family Guy',
             description: 'In a wacky Rhode Island town, a dysfunctional family strive to cope with everyday life as they are thrown from one crazy scenario to another.',
             small_cover_url: 'family_guy.jpg',
             large_cover_url: 'family_guy_large.jpg',
             category: comedy)

futurama = Video.create!(title: 'Futurama',
             description: 'Fry, a pizza guy is accidentally frozen in 1999 and thawed out New Year\'s Eve 2999.',
             small_cover_url: 'futurama.jpg',
             large_cover_url: 'futurama_large.jpg',
             category: sci_fi)

monk = Video.create!(title: 'Monk',
             description: 'Adrian Monk is a brilliant San Francisco detective, whose obsessive compulsive disorder just happens to get in the way.',
             small_cover_url: 'monk.jpg',
             large_cover_url: 'monk_large.jpg',
             category: crime)
             
6.times {Video.create!(title: 'Family Guy',
             description: 'In a wacky Rhode Island town, a dysfunctional family strive to cope with everyday life as they are thrown from one crazy scenario to another.',
             small_cover_url: 'family_guy.jpg',
             large_cover_url: 'family_guy_large.jpg',
             category: comedy)}
             
eva = User.create(full_name: 'Eva Cukor', password: 'password', email: 'cukor@email.com')

Review.create(user: eva, video: monk, rating: 3, contents: 'This is a really good TV show.')
Review.create(user: eva, video: futurama, rating: 5, contents: 'This is a very funny TV show!')