module UsersHelper
	def load_image(user)
		image_url= "https://instagram.fhyd5-1.fna.fbcdn.net/v/t51.2885-19/s150x150/67077307_363518411242106_8033793394398461952_n.jpg?_nc_ht=instagram.fhyd5-1.fna.fbcdn.net&_nc_ohc=-WUY-5gRLz8AX9c5Dt1&oh=8baca55d316c1c1a67e46ff15af4c50a&oe=5EEBCECE"
		return image_tag(image_url, alt: user.name, class: "img-thumbnail")
	end
end
