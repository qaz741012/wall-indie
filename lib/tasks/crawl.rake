namespace :crawl do

  # 爬 the wall
  task the_wall: :environment do
    agent = Mechanize.new
    url = 'https://thewall.tw/shows'
    page = agent.get(url)
    page.search('.show-item').each do |item|
      photo = item.search('.poster img').attr("src").value
      date = "2018/" + item.search('.date').text[0..4]
      week = item.search('.date').text[6]
      name = item.search('.title').text

      info = item.search('tbody tr')
      if info[0].text[0..1] == "演出"
        artists = info[0].text[2..-1].split(', ')
        n = 0
      else
        artists = "Need to Check"
        n = 1
      end
      price = info[1-n].text[2..-1]
      place = "The Wall-" + info[2-n].text[2..-1]
      begin
        time = info[3-n].text[2..-1]
      rescue NoMethodError
        time = "Need to Check"
      end

      # 存 Artist
      if artists != "Need to Check"
        artists.each do |artist|
          if !Artist.find_by_name(artist)
            Artist.create(name: artist)
            puts "Create artist #{artist}"
          end
        end
      end

      # 存 Place
      if !Place.find_by_name(place)
        Place.create(name: place,
                     address: "臺北市羅斯福路四段200號B1")
        puts "Create place #{place}"
      end

      # 存 Event
      if !Event.find_by_name(name)
        Event.create( name: name,
                      photo: photo,
                      date: date,
                      week: week,
                      price: price,
                      time: time, )
        puts "Create event #{name}"

        # Event有建再存 Cession
        Cession.create( event_id: Event.find_by_name(name).id,
                        place_id: Place.find_by_name(place).id )
        puts "Create cession!"

        # Event有建再存 Show
        if artists != "Need to Check"
          artists.each do |artist|
            Show.create( event_id: Event.find_by_name(name).id,
                         artist_id: Artist.find_by_name(artist).id )
            puts "Create shows!"
          end
        end
      end

      puts "Finish the wall crawling"
    end
  end



end