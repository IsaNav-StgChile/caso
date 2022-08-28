
require 'uri'
require 'net/http'
require 'json'
require 'nokogiri'

def request(uri, api_key = "K6j0PyEOPtrGodgBdrx5qr6Detq9L7d7Ffoi02pQ")
    url = URI("#{url}&api_key=#{api_key}")

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    https.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    request["cache-control"] = 'no-cache'
    request["Postman-Token"] = '2178e596-b98d-4395-bfa7-e0ac0e2df059'

    response = https.request(request)

    JSON.parse(response.read_body)
end

# Realizamos un request a https:// 
# y obtenemos el arreglo con hashes de fotos.
data =
request("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos
?sol=10")

# Generamos un arreglo a partir de las fotos del hash.
url_photos = photos.map { |photo| photo['url'] }

# Iteramos el arreglo con las fotos y guardamos sus 
# resultados en un archivo
# * Al momento de guardar agregaremos las etiquetas de HTML
file = File.open('./index.html', 'w')

file.write("<!DOCTYPE html>\n")
file.write("<html lang=\"en\">\n")

file.write("<head>\n")
file.write("\t<meta charset=\"UTF-8\">\n")
file.write("\t<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n")
file.write("\t<title>Photos</title>\n")
file.write("</head>\n")

file.write("<body>\n")

file.write("\t<ul>\n")
url_photos.each do |photo|
    file.write("\t\t<li><img src=\"#{photo}\" /></li>\n")
end
file.write("\t</ul>\n")

file.write("</body>\n")
file.write("</html>\n")

file.close
