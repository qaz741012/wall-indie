namespace :dev do
  task img: :environment do
    agent = Mechanize.new
    url = 'https://thewall.tw/shows'
    page = agent.get(url)
    item = page.search('.show-item')[0]
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
    place_data = { "name" => place,
                   "address" => "臺灣臺北市羅斯福路四段200號B1" }

    begin
      time = info[3-n].text[2..-1]
    rescue NoMethodError
      time = "Need to Check"
    end

    test_save_data(artists, place_data, name, photo, date, week, price, time)

    puts "Finish the wall crawling"
  end
end


def test_save_data(artists, place_data, name, photo, date, week, price, time)
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

    Place.create(name: place_data["name"],
                 address: place_data["address"] )
    puts "Create place #{place_data["name"]}"


  # 存 Event

    Event.create( name: name,
                  remote_photo_url: photo,
                  date: date,
                  week: week,
                  price: price,
                  time: time )
    puts "Create event #{name}"

    # Event有建再存 Cession
    Cession.create( event_id: Event.find_by_name(name).id,
                    place_id: Place.find_by_name(place_data["name"]).id )
    puts "Create cession!"

    # Event有建再存 Show
    if artists != "Need to Check"
      artists.each do |artist|
        Show.create( event_id: Event.find_by_name(name).id,
                     artist_id: Artist.find_by_name(artist).id )
        puts "Create shows!"
      end
    end
    puts "image cutting"
    image_square_shave(Event.find_by_name(name).photo)
    puts "cutting end"

end

def image_square_shave(photo)
  path = photo.path
  image = MiniMagick::Image.new(path)
  h = image[:height]
  w = image[:width]
  image.combine_options do |img|
    if h >= w
      shave_off = (h - w) / 2
      img.shave "0x#{shave_off}"
    else
      shave_off = (w - h) / 2
      img.shave "#{shave_off}x0"
    end
    img.resize "400x400"
  end
end
