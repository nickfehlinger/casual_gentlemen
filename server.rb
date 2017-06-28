require 'sinatra'
# using SendGrid's Ruby Library
# https://github.com/sendgrid/sendgrid-ruby
require 'sendgrid-ruby'
include SendGrid

# Universal
before do
	@products = {
		knife:{name: "Knife", image: "/images/knife.jpg", description: "Hi. I'm a Knife. I'm sharp and light and quick to bite, so stop trying to decide on a style and pick me up, It'll be worthwhile. If you've ever seen 127 hours you know how important it is to have good blade, you never know when you have to cut off a limb or even do a quick shave.", hook: "Multi-purpose knife, for cutting all types of bullshit out of your life", categories: ["Tools"]},
		whiskey_stones:{name: "Whiskey stones", image: "/images/whiskey-stones.jpg", description: "We care about your whiskey. It is always there for you, and so are we. We have an amazing invention to make sure you can appreciate your whiskey for longer and keep the quality long after pouring a glass. They are stones. They are extraordinary things which can hold freezing temperatures for a substantial amount of time and keeps your drink cold without watering it out.", hook: "Amaxing new technology to keep your whiskey cold!!!", categories: ["Drinks","Tools"]},
		drone:{name: "Drone", image: "/images/drone.jpg", description: "If you havent gotten one of these yet, you haven't fulfilled your childhood yet. This is the ultimate toy for men to enjoy without being ridiculed or put down. Mainly because they are that fucking awesome. So take advantage of your life and make sure everybody knows that you are the shit.", hook: "Did you fall from heaven? Because you look like you fell from a few hundred miles up.", categories: ["Toys"]},
		hot_sauce:{name: "Hot Sauce", image: "/images/hotsauce.jpg", description: "Are you always looking for a firey hot sauce to spice up your life? Are you the type of man with a tabasco sauce in your back pocket ready to throw onto anything you have for breakfast lunch or dinner? Well then we have the perfect match for you. This kit gives you the power to control the spice level and amount you make. It truly makes you a man.", hook: "Hey mami', lets tango", categories: ["Food"]},
		wine_opener:{name: "Wine Opener", image: "/images/wine.jpeg", description: "What is this? Well its a wine opener. Its nothing special, but it will take that amazing bottle of wine and allow it to pour into your glass so you can have a good time. It will be the adam to your eve, the chocolate to your cake, and the peanut butter to your jelly. It isn't the magic, but it opens the bottle that makes the magic happen.", hook: "If you like dancing, come check me out, ill pop open some bottles of wine and show you a good time.", categories: ["Drinks"]},
		sock_game:{name: "Sock Game", image: "/images/socks.jpg", description: "Is your sock game on point? When you sit down and your socks are peaking out of your pants, do women trip over themselves in leg-shaking excitement? If not then these are for you. You need that extra spizazz that just brings some fire into your life. Don't just be another suit, bring some sock game into everyones life.", hook: "You aren't dressed to the nines without some fire in your shoes.", categories: ["Fashion"]},
		tie_clip:{name: "Tie Clip", image: "/images/clip.jpg", description: "You know your favorite tie? The one you pull out when you know you're on stud level 10,000. Are you going to let it flop around, get in your food and coffee and risk a stain or rip? No. No you absolutely will not if you have any respect for yourself as a gentleman. So this is why we bring you our tie clip. It looks fly, and is the best wingman out there. It will always leave you satisfied at the end of the night. Even if you're alone, you'll look in the mirror and realize 'Damn i look good'.", hook: "Make your tie look fly! Accessorize!!", categories: ["Fashion"]},
		beard_grooming_set:{name: "Beard Grooming Set", image: "/images/beard.jpg", description: "The question is if you're a gentleman or a hipster. A gentleman has an idea of self worth and will make sure he is well groomed and presentable at all times, making sure any facial hair adds to his features rather than hide them. And a hipster will let his beard grow out because he is telling the world he doesnt care what you think, and that he can get by in the world without conforming to your guidelines on how to live his life. So I ask you... Are you a gentleman... or someone who is rebellious long after anyone gives a fuck.", hook: "If anyone has ever said you have a rat on your lip, you need our help.", categories: ["Fashion", "Tools"]},
		fedora:{name: "Fedora", image: "/images/hats.jpg", description: "If you're the type of gentleman which enjoys looking classy and sharp, then check out our selection of fedoras, which has a hipster vibe while letting everybody know you look good and you know it.", hook: "Slide into my brim, and i'll show you how to dress with style.", categories: ["Fashion"]},
		skagen:{name: "Skagen Watch", image: "/images/skagen.jpg", description: "If you're a gentleman, you don't need a huge piece of bling on your wrist. You need an expensive timepiece which is sleek and classy. Something that shows the world you know what looks good, but don't need to flaunt it because you already knew what you are worth.", hook: "Hey there good looking, it's about time we got together.", categories: ["Fashion"]},
		mustache:{name: "The Stache", image: "/images/stache.jpeg", description: "We know how it feels to desperately need to be a man. And as a gentleman it is your duty to show the world you can handle your own. Which always starts with your facial hair. If you want to be a respected member of society, people need to know that you have some hair before they care. And this may be very difficult, especially if you havent started smoking yet. So we give you the Stache. It is the ultimate mustache, turning your pinchable baby face into a symbol of power and manlihood. Making boys into men, and Biebers into lumberjacks for 100 years.", hook: "Make woman swoon with the Stache.", categories: ["Fashion", "Tools"]},
		wooden_sunglasses:{name: "Wooden Sunglasses", image: "/images/sunglasses.jpg", description: "If you are a true gentleman you will have a pair of our wooden sunglasses to let everyone know you are willing to throw money away just for style. They look fantastic as well, but to be real they are mostly bought because of your insecurity and lack of confidence in your style. So pick up a pair today and hide from the world.", hook: "Protect against the shade you get every day, from everyone.", categories: ["Fashion", "Tools"]},

	}
	@categories = @products.reduce([]) do |arr,(key,hash)|
		arr | hash[:categories]
	end
	@n = 0
	@nav = [{link: "/", text: "Home"},{link: "/about", text: "About Us"},{link: "/category", text: "Browse By Category"},{link: "/p/" + @products.keys.sample.to_s, text: "Find A Random Product"}]
end

# Hans
get '/' do
@title = "SiteName"

(@prod1,@prod2,@prod3,@prod4,@prod5,@prod6,@prod7, @prod8, @prod9, @prod10) = @products.keys.sample(10)
erb :home
end

# Steven
get '/category' do
	@title = "Categories"

erb :categories

end
get '/c/:category' do
	@category = @categories[@n].to_sym
	@title = params[:category]

	erb :category
end
# Nick
get '/about' do
	@title = "About Us"

erb :about
end

post '/about' do
#get from address from form
	from = Email.new(email: params[:email])
	to = Email.new(email: 'nfehlinger@gmail.com')
#get subject from our form
	subject = params[:subject]
#get content from form
	content = Content.new(type: 'text/plain', value: <<-EMAILBODY
NAME: #{params[:name]}

COMMENT: #{params[:comment]}
EMAILBODY
)
	mail = Mail.new(from, subject, to, content)

	sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
	response = sg.client.mail._('send').post(request_body: mail.to_json)
	puts response.status_code
	puts response.body
	puts response.headers

	redirect "/"

end

get '/p/:product' do
@product = @products[params[:product].to_sym]
@title = @product[:name]
erb :product

end
