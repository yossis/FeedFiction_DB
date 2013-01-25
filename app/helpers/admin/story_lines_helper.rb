module Admin::StoryLinesHelper
	def faker_for_select(user)
		#Admin::Faker.all.map {|u| [ u.user.name , u.user.id ]}

		html_options = "<option data-image=\"#{current_user.avatar}\" value=\"#{current_user.id}\">#{current_user.name}</options>\n" unless(user.nil? && user==current_user)
		html_options += "<option data-image=\"#{user.avatar}\" value=\"#{user.id}\" selected>#{user.name}</options>\n" unless user.nil?
		Admin::Faker.all.map do |e|
			html_options += "<option data-image=\"#{e.user.avatar}\" value=\"#{e.user_id}\" selected>#{e.user.name}</options>\n" if user!=e.user
		end
		html_options.html_safe
	end
end
