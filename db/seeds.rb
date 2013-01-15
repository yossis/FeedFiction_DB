# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

['Animals', 'Brands','Cars & Motorcycles','Confessions','Cool','Fashion',
'Fiction','Food & Drink','Good & Bad','Holidays & Vacation','Home & Family',
'Humor','Life','Love','Luck','Relationships','Money','Mystery & Fantasy','Nature',
'Politics','Sports & Fitness','Teachers & Students','Thriller','Truth (TBT)',
'Wisdom','Work'].each do |category|
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
