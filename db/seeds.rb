

# rubocop:disable Lint/Syntax, Layout/SpaceInsideArrayLiteralBrackets
=begin
require 'faker'

User.destroy_all
Post.destroy_all
Comment.destroy_all
Reaction.destroy_all

# 20 usuarios
20.times do
  User.create!(
    email: Faker::Internet.unique.email,
    password: Faker::Internet.password(min_length: 6, max_length: 8),
    name: Faker::Name.name,
    role: 0 # todos usuarios normales
  )
end

# 1 administrador
User.create!(
  email: "admin@admin.com",
  password: "123456",
  name: "carlos",
  role: 1 # rol de admin
)

# 50 posts
users = User.where(role: 0) # solo autenticados
50.times do
  Post.create!(
    title: Faker::Hipster.unique.sentence(word_count: 4),
    content: Faker::Hipster.unique.paragraph(sentence_count: 10),
    available: [ true, false ].sample,
    user: users.sample
  )
end

# 100 comentarios
posts = Post.all
users = User.all
100.times do
  Comment.create!(
    content: Faker::Hipster.unique.sentence(word_count: 10),
    post: posts.sample,
    user: [ users.sample, nil ].sample # los comentarios son de usuarios y visitas
  )
end


# 30 reacciones
users = User.all
posts = Post.all

kinds = Reaction::Kinds

30.times do
  user = users.sample
  post = posts.sample

  unless Reaction.exists?(user: user, post: post)
    Reaction.create!(
      kind: kinds.sample,
      post: post,
      user: user
    )
  end
end

puts "Se han creado 30 reacciones de forma exitosa"

puts "Seed completado: Creados #{User.count} usuarios, #{Post.count} posts, #{Comment.count} comentarios, y #{Reaction.count} reacciones."

# rubocop:enable Layout/SpaceInsideArrayLiteralBrackets
=end

require 'httparty'
require 'open-uri'

api_key = 'live_84PwgQujN4PnZmW6i3x6879QbFVrbjtr7i6bqMZMTqZ3K1XzMhldW28IEeJVduvb'

Post.find_each do |post|
  next if post.image.attached? # Evitar duplicados

  begin
    # Hacer la solicitud a la API para obtener una imagen de gato
    response = HTTParty.get("https://api.thecatapi.com/v1/images/search", headers: { "x-api-key" => api_key })

    if response.success?
      cat_image_url = response[0]["url"]

      # Abre la imagen obtenida de la API
      file = URI.open(cat_image_url)

      # Adjunta la imagen al post
      post.image.attach(io: file, filename: "cat_image_#{post.id}.jpg", content_type: 'image/jpg')

      # Guarda el post con la imagen
      post.save!
      puts "Imagen de gato asignada al post ##{post.id}"
    else
      puts "Error al obtener la imagen de gato para el post ##{post.id}"
    end

  rescue => e
    puts "Error al cargar la imagen para el post ##{post.id}: #{e.message}"
  end
end

puts "Seed completado con imágenes de gatos."
