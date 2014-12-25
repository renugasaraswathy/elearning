namespace :set_up_system do
  desc "TODO"
  task init_code: :environment do
  desc "Load the default invite codes in to the current environment's database"
	  # Delete existing entries
	  InviteCode.delete_all

	  #Load activities fixtures
	  require 'active_record/fixtures'
	  ActiveRecord::Base.establish_connection(Rails.env.to_sym)
	  ActiveRecord::Fixtures.create_fixtures('lib/fixtures', 'invite_code')

	  puts "Invite Codes Created"
end

task init_users: :environment do 
	@user=User.new(:employee_id=>'admin',:first_name=>'Admin',:email=>'elearn@tcs.com',:last_name=>'System',:password=>'learn123',:sign_up_code=>InviteCode.first.code)
	if @user.save
		puts "Admin User created"
	else
		puts @user.errors.full_messages
	end
end

	task :start => [:environment, 'db:create', 'db:migrate','init_code','init_users']
end
