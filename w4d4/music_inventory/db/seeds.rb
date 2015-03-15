class Array
  def random(n = 1)
    result = []

    n.times do
      index = (0...length).to_a.sample
      result << shuffle[index]
    end

    result
  end
end

password_digest = BCrypt::Password.create('password')


User.create([
  {
    email: 'ssschupbach@gmail.com',
    password_digest: password_digest,
    session_token: SecureRandom.urlsafe_base64(16)
  },
  {
    email: 'scottyschup@gmail.com',
    password_digest: password_digest,
    session_token: SecureRandom.urlsafe_base64(16)
  }
])

bands = Band.create([
  { name: 'The Strokes' },
  { name: 'The Smashing Pumpkins' },
  { name: 'The Beatles' },
  { name: 'The National' }
])

albums = Album.create([
  { name: 'Is This It?', band_id: 1, album_type: 'studio' },
  { name: 'Angles', band_id: 1, album_type: 'studio' },
  { name: 'Siamese Dream', band_id: 2, album_type: 'studio' },
  { name: 'Abbey Road', band_id: 3, album_type: 'studio' },
  { name: 'White Album', band_id: 3, album_type: 'live' },
  { name: 'Revolver', band_id: 3, album_type: 'studio' },
  { name: 'Trouble Will Find Me', band_id: 4, album_type: 'studio' },
  { name: 'High Violet', band_id: 4, album_type: 'studio' }
])

tracks = albums.length.times do |i|
  chars = ('a'..'z').to_a + [' '] * 10 + ['e'] * 4
  (7..14).to_a.sample.times do |j|
    track_type = j > 10 ? 'bonus' : 'regular'

    lyrics_length = (500..1500).to_a.sample
    lyrics = chars.random(lyrics_length).join

    Track.create({
      name: "Track #{j + 1}",
      album_id: (i + 1),
      track_type: track_type,
      lyrics: lyrics
    })
  end
end
