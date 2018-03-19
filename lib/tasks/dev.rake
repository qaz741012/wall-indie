namespace :dev do

  task fake_user: :environment do
    User.destroy_all
    20.times do |i|
      name = FFaker::Name::first_name
      file = File.open("#{Rails.root}/public/avatar/user#{i+1}.jpg")
      user = User.new(
        id: i+3,
        name: name,
        email: "#{name}@example.co",
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
    User.all.each do |user|
      rand_user = User.select{|x| x!=user}.sample(5)
      rand(5).times do |i|
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
      file = File.open("#{Rails.root}/public/avatar/user#{i+1}.jpg")
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
    Place.destroy_all
    20.times do |i|
      name = FFaker::Name::last_name

      place = Place.new(
        id: i+1,
        name: name,
        address: FFaker::Address::street_address,
        tel: FFaker::PhoneNumberAU::phone_number,
        info: FFaker::Lorem::sentence(20),
      )
      place.save!
      puts place.name
    end
  end

  task fake_event: :environment do
    Event.destroy_all
    20.times do |i|
      name = FFaker::Name::first_name
      file = File.open("#{Rails.root}/public/avatar/user#{i+1}.jpg")

      event = Event.new(
        id: i+1,
        name: name,
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
  end

  task fake_cession: :environment do
    Cession.destroy_all
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
    User.all.each do |user|
      rand(5).times do |i|
        user.favorits.create!(
          user_id: user.id,
          artist_id: Artist.all.sample.id)
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
    User.all.each do |user|
      rand(5).times do |i|
        user.artist_followships.create!(
          user_id: user.id,
          artist_id: Artist.all.sample.id)
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
    User.all.each do |user|
      rand(5).times do |i|
        user.event_followships.create!(
          user_id: user.id,
          event_id: Event.all.sample.id)
      end
    end
    # Artist.all.each do |artist|
    #   artist.likes_count = Like.where(artist_id: artist.id).count
    #   artist.save
    # end
    puts "have created fake event_followships"
    puts "now you have #{EventFollowship.count} event_followships data"
  end

  task fake_all: :environment do
    Rake::Task['db:migrate'].execute
    Rake::Task['db:seed'].execute
    Rake::Task['dev:fake_user'].execute
    Rake::Task['dev:fake_friendship'].execute
    Rake::Task['dev:fake_artist'].execute
    Rake::Task['dev:fake_music'].execute
    Rake::Task['dev:fake_place'].execute
    Rake::Task['dev:fake_event'].execute
    Rake::Task['dev:fake_cession'].execute
    Rake::Task['dev:fake_show'].execute
    Rake::Task['dev:fake_favorit'].execute
    Rake::Task['dev:fake_artist_followship'].execute
    Rake::Task['dev:fake_event_followship'].execute
  end

end
