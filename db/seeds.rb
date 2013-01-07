# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

['Animals', 'Art', 'Biographies', 'Business', 'Brands',
 'Cars & Motorcycles', 'Celebrities', 'Christian', 'Christmas', 
 'Comics', 'Confessions', 'Cookbooks', 'Crafts', 'Crime', 'Computers',
 'Design', 'Dieting', 'DIY', 'Dreams', 'Education', 'Entertainment', 
 'Fables', 'Family', 'Fantasy', 'Fashion', 'Fiction', 
 'Music & Books', 'Food & Drink', 'Gardening', 'Gay & Lesbian', 'Geek', 
 'Gothic', 'Health & Fitness', 'History', 'Hobbies', 'Holidays & Events', 
 'Home', 'Horror', 'Humor', 'Investing', 'Kids', 'Law', 'Literature', 
 'Linkedin', 'Medicine', 'Memoirs', 'Mystery', 'Nature', 'Outdoors', 
 'Photography', 'Places', 'Politics', 'Professional', 'Relationships', 
 'Religion', 'Romance', 'Science', 'Science Fiction', 'Spirituality', 'Spy', 
 'Social Networks', 'Sports', 'Tattoos', 'Technical', 'Technology', 'Teens', 
 'Thriller', 'Travel', 'TV', 'Twitter', 'Vacation', 'Weddings', 
 'Westerns', 'Other'].each do |category|
	Category.find_or_create_by_name category
end

#Create image types:
['Facebook', 'Upload','Instagram'].each do |u|
	ImageType.find_or_create_by_name u
end 


['Story', 'Comment', 'Like' , 'Follow'].each do |t|
	NotificationType.find_or_create_by_name t
end 

['Sexually explicit content', 'Graphic violence' , 'Offensive language' ,'Violation of Terms of Use' ,'Other'].each do |f|
	FlagReason.find_or_create_by_name f
end 

['Profile Pictures', 'Stories'].each do |t|
	AlbumType.find_or_create_by_name t
end 
