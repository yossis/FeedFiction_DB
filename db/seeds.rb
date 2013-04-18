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

InviteText.find_or_create_by_title_and_content_and_story_type('Great stuff!',"Invite friends to continue this story. It's much more fun.",1)
InviteText.find_or_create_by_title_and_content_and_story_type('Witty!','Think about friends that could pick up where you left off and invite them.',1)
InviteText.find_or_create_by_title_and_content_and_story_type('Beautiful!','You should try writing with friends. Invite them now.',1)
InviteText.find_or_create_by_title_and_content_and_story_type('Cool!',"Invite your friends to continue. Don't forget to start a new story, more stories means more fun for everyone!",1)
InviteText.find_or_create_by_title_and_content_and_story_type('WOW!','Would be great if you invite your best friend to continue.',1)
InviteText.find_or_create_by_title_and_content_and_story_type('Brilliant.','See if your friends are online, which one of them could take the story forward?',1)
InviteText.find_or_create_by_title_and_content_and_story_type('Wow!','Invite a couple of friends and see where the story goes.',1)
InviteText.find_or_create_by_title_and_content_and_story_type('Just gorgeous!','If you had to invite just one friend to continue the story, who would you pick?',1)
InviteText.find_or_create_by_title_and_content_and_story_type('That was unique.','Eager to find an ending? Invite someone you know.',1)
InviteText.find_or_create_by_title_and_content_and_story_type('What a twist!','Who of your friends could continue the story in this direction?',1)
InviteText.find_or_create_by_title_and_content_and_story_type('That was nice.','If your friends are online, just invite them. It could be fun to see how they continue the story.',1)
InviteText.find_or_create_by_title_and_content_and_story_type('Really amazing.','Sometimes you need just one feeder to complete the whole story. Now, who would that be?',1)

InviteText.find_or_create_by_title_and_content_and_story_type('What a story!','It really deserves to be shared with your friends.',2)
InviteText.find_or_create_by_title_and_content_and_story_type('Surprising End!','Now you should let the world enjoy it.',2)
InviteText.find_or_create_by_title_and_content_and_story_type('You did great!',"It's time to be generous and share the story.",2)
InviteText.find_or_create_by_title_and_content_and_story_type('Super ending!','Your friends need to see how talented you are.',2)
InviteText.find_or_create_by_title_and_content_and_story_type('What a great ending!','Friendship means sharing, so go ahead and share the story with friends.',2)
InviteText.find_or_create_by_title_and_content_and_story_type('You are so talented!',"It's time for your friends to see it.",2)
InviteText.find_or_create_by_title_and_content_and_story_type('This was beautiful.','Your friends would love it.',2)
InviteText.find_or_create_by_title_and_content_and_story_type('That was pretty.','You must share the story with your friends.',2)
InviteText.find_or_create_by_title_and_content_and_story_type('You are gifted!','Do your friends and family know you write? Tell them.',2)
InviteText.find_or_create_by_title_and_content_and_story_type('Interesting!','How about starting a new story? You might get new followers.',2)
InviteText.find_or_create_by_title_and_content_and_story_type("Feels great doesn't it?",'Why not tell you friends about it and make them feel great too?',2)
InviteText.find_or_create_by_title_and_content_and_story_type('Very impressive!','Your friends need to read it.',2)