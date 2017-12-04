

User.create(name: "sanchez", email: 'jon@gmail.com', password: 'codeplatoon')
Concert.create(title: 'Red Hot Chilli Peppers', description: '90s rock', ticket_info: 'free', api_id: 9999, concert_date: DateTime.now)
Concert.create(title: 'katy Perry', description: 'wearing many outfits', ticket_info: 'free', api_id: 9999, concert_date: DateTime.now)
MediaLink.create(concert_id: 1, user_id: 1, media_type: 'video', link:"https://www.youtube.com/embed/Q0oIoR9mLwc")
MediaLink.create(concert_id: 1, user_id: 1, media_type: 'video', link:'https://www.youtube.com/embed/mzJj5-lubeM')
MediaLink.create(concert_id: 1, user_id: 1, media_type: 'video', link:'https://www.youtube.com/embed/jZRdjZFffnQ')
rhcp = Band.create(title:'Red Hot Chili Peppers', description:'funk rock band from the 90s', twitter:'rhcp')
katyperry = Band.create(title:'Katy Perry', description:'pop singer famous for outrageous concerts', twitter:'katyperry')
ConcertBand.create(concert_id: 1, band_id: rhcp.id)
ConcertBand.create(concert_id: 2, band_id: katyperry.id)

