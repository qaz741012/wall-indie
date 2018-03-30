namespace :dev do
  task fake_all: :environment do
    Rake::Task['dev:fake_user'].execute
    Rake::Task['dev:fake_friendship'].execute
    # Rake::Task['dev:fake_artist'].execute
    # Rake::Task['dev:fake_music'].execute
    # Rake::Task['dev:fake_place'].execute
    # Rake::Task['dev:fake_event'].execute
    # Rake::Task['dev:fake_cession'].execute
    # Rake::Task['dev:fake_show'].execute
    Rake::Task['dev:fake_favorit'].execute
    Rake::Task['dev:fake_artist_followship'].execute
    Rake::Task['dev:fake_event_followship'].execute
  end

  task fake_user: :environment do
    100.times do |i|
      name = FFaker::Name::first_name
      file = File.new(Rails.root.join('app', 'assets', 'images', "pic1_#{rand(72).to_s.rjust(3,'0')}.jpg"))
      # file = File.open("#{Rails.root}/public/avatar/user#{(i+1)/19}.jpg")
      user = User.new(
        id: i+3,
        name: name,
        email: FFaker::Internet.email,
        password: "12345678",
        avatar: file,
        # 繞過使用者email認證
        confirmed_at: Time.now
      )
      user.save!
      puts user.name
    end
  end

  task fake_friendship: :environment do
    Friendship.destroy_all
    num_users = User.count/5
    User.all.each do |user|
      rand_user = User.select{|x| x!=user}.sample(num_users)
      rand(num_users).times do |i|
        user.friendships.create!(
          user_id: user.id,
          friend_id: rand_user[i].id)
      end
    end
    puts "have created fake friendship"
    puts "now you have #{Friendship.count} friendships data"
  end

  task fake_artist: :environment do
    Artist.destroy_all
    20.times do |i|
      file = File.new(Rails.root.join('app', 'assets', 'images', "user#{rand(19).to_s}.jpg"))
      artist = Artist.new(
        id: i+1,
        name: FFaker::Music::artist,
        intro: FFaker::Lorem::sentence(20),
        photo: file
      )
      artist.save!
      puts artist.name
    end
  end

  task fake_music: :environment do
    Music.destroy_all
    Artist.all.each do |artist|
      (rand(20)+1).times do |i|
        artist.musics.create!(
          name: FFaker::Music::song,
          intro: FFaker::Lorem::sentence(10),
          link: FFaker::InternetSE::company_name_single_word
          )
        puts "#{artist.name} says '#{Music.count}' "
      end
    end
    puts "Have created fake music"
  end

  task fake_place: :environment do

    20.times do |i|
      place = Place.new(
        id: i+1,
        name: FFaker::Name::last_name,
        address: FFaker::Address::street_address,
        tel: FFaker::PhoneNumberAU::phone_number,
        info: FFaker::Lorem::sentence(20),
      )
      place.save!
      puts place.name
    end
  end

  task fake_event: :environment do
      file = File.new(Rails.root.join('app', 'assets', 'images', "indie#{rand(3).to_s}.jpeg"))
      event = Event.new(
        name: FFaker::Music::album,
        intro: FFaker::Lorem::sentence(20),
        date: FFaker::Time::date,
        time: FFaker::Time::datetime,
        ticket_link: FFaker::Internet::http_url,
        organizer: FFaker::InternetSE::company_name_single_word,
        photo: file
      )
      event.save!
      puts event.name
  end

  task fake_cession: :environment do
    # Cession.destroy_all
    Place.all.each do |place|
      rand(5).times do |i|
        place.cessions.create!(
          place_id: place.id,
          event_id: Event.all.sample.id)
      end
    end
    # Artist.all.each do |artist|
    #   artist.likes_count = Like.where(artist_id: artist.id).count
    #   artist.save
    # end
    puts "have created fake cessions"
    puts "now you have #{Cession.count} cessions data"
  end

  task fake_show: :environment do
    Show.destroy_all
    Event.all.each do |event|
      rand_artist = Event.select{|x| x!=event}.sample(5)
      rand(5).times do |i|
        event.shows.create!(
          event_id: event.id,
          artist_id: rand_artist[i].id)
      end
    end
    puts "have created fake Show"
    puts "now you have #{Show.count} shows data"
  end

  task fake_favorit: :environment do
    Favorit.destroy_all
    num_artists = Artist.count
    rand_artists = Artist.all.sample(num_artists)
    User.all.each do |user|
      rand(num_artists/5).times do |i|
        user.favorits.create!(
          user_id: user.id,
          artist_id: rand_artists[i].id)
      end
    end
    # Artist.all.each do |artist|
    #   artist.likes_count = Like.where(artist_id: artist.id).count
    #   artist.save
    # end
    puts "have created fake favorits"
    puts "now you have #{Favorit.count} favorits data"
  end

  task fake_artist_followship: :environment do
    ArtistFollowship.destroy_all
    num_artists = Artist.count
    rand_artists = Artist.all.sample(num_artists)
    User.all.each do |user|
      rand(num_artists/5).times do |i|
        user.artist_followships.create!(
          user_id: user.id,
          artist_id: rand_artists[i].id)
      end
    end
    # Artist.all.each do |artist|
    #   artist.likes_count = Like.where(artist_id: artist.id).count
    #   artist.save
    # end
    puts "have created fake artist_followships"
    puts "now you have #{ArtistFollowship.count} favorits data"
  end

  task fake_event_followship: :environment do
    EventFollowship.destroy_all
    num_evets = Event.count/5
    rand_events = Event.all.sample(num_evets)
    User.all.each do |user|
      rand(num_evets).times do |i|
        user.event_followships.create!(
          user_id: user.id,
          event_id: rand_events[i].id)
      end
    end
    # Artist.all.each do |artist|
    #   artist.likes_count = Like.where(artist_id: artist.id).count
    #   artist.save
    # end
    puts "have created fake event_followships"
    puts "now you have #{EventFollowship.count} event_followships data"
  end



end
