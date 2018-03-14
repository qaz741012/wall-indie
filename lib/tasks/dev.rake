namespace :dev do
  # 請先執行 rails dev:fake_user，可以產生 20 個資料完整的 User 紀錄
  # 其他測試用的假資料請依需要自行撰寫

  # task fake: :environment do
  task fake_user: :environment do
    20.times do |i|
      name = FFaker::Name::first_name
      file = File.open("#{Rails.root}/public/avatar/user#{i+1}.jpg")
      user = User.new(
        id: i+3,
        name: name,
        email: "#{name}@example.co",
        password: "12345678",
        avatar: file
      )
      user.save!
      puts user.name
    end
  end

  task fake_artist: :environment do
    Artist.destroy_all
    20.times do |i|
      name = FFaker::Name::first_name
      file = File.open("#{Rails.root}/public/avatar/user#{i+1}.jpg")
      artist = Artist.new(
        id: i+1,
        name: name,
        intro: FFaker::Lorem::sentence(20),
        photo: file
      )
      artist.save!
      puts artist.name
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

  task fake_music: :environment do
    Music.destroy_all
    Artist.all.each do |artist|
      (rand(20)+1).times do |i|
        name = FFaker::Name::first_name
        artist.musics.create!(
          name: name,
          intro: FFaker::Lorem::sentence(10),
          link: FFaker::InternetSE::company_name_single_word
          )
        puts "#{artist.name} says '#{Music.count}' "
      end
    end
    puts "Have created fake music"
  end

  # # task fake_reply: :environment do
  #   Reply.destroy_all
  #   Tweet.all.each do |tweet|
  #     (rand(10)+1).times do |i|
  #       tweet.replies.create!(
  #         comment: FFaker::Lorem.paragraph,
  #         user: User.all.sample
  #       )
  #     end
  #   end
  #   puts "have created fake replies"
  #   puts "now you have #{Reply.count} replies data"
  # # end

  task fake_favorit: :environment do
    Favorit.destroy_all
    User.all.each do |user|
      rand(50).times do |i|
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

  task fake_all: :environment do
    Rake::Task['db:seed'].execute
    Rake::Task['db:migrate'].execute
    Rake::Task['dev:fake_user'].execute
    Rake::Task['dev:fake_friendship'].execute
    Rake::Task['dev:fake_artist'].execute
    Rake::Task['dev:fake_music'].execute
    # Rake::Task['dev:fake_place'].execute
    Rake::Task['dev:fake_event'].execute
    # Rake::Task['dev:fake_show'].execute
    # Rake::Task['dev:fake_artist_followship'].execute
    # Rake::Task['dev:fake_event_followship'].execute
    Rake::Task['dev:fake_favorit'].execute
    # Rake::Task['db:seed'].execute
  end
  # # task fake_friendship: :environment do
  #   Friendship.destroy_all
  #   User.all.each do |user|
  #     rand_user = User.select{|x| x!=user}.sample(5)
  #     rand(5).times do |i|
  #       user.friendships.create!(
  #         user_id: user.id, 
  #         friend_id: rand_user[i].id)
  #     end
  #   end
   
  #   puts "have created fake friendship"
  #   puts "now you have #{Friendship.count} friendships data"
  # end

end
