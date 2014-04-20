require 'spec_helper'

# describe "StaticPages" do
#   describe "GET /static_pages" do
#     it "works! (now write some real specs)" do
#       # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
#       get static_pages_index_path
#       response.status.should be(200)
#     end
#   end
# end

describe "Static pages" do

	subject { page }

	shared_examples_for "all static pages" do
		it { should have_selector('h1', text: heading) }
		it { should have_title(full_title(page_title)) }
	end

	describe "Home page" do
		before { visit root_path }

		let(:heading) { 'Sample Application' }
		let(:page_title) { '' }

		it_should_behave_like "all static pages"
		it { should_not have_title(' | Home') }

		describe "for signed-in users" do
			let(:user) { FactoryGirl.create(:user) }
			before do
				FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
				FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
				sign_in user
				visit root_path
			end

			it "should render the user's feed" do
				user.feed.each do |item|
					expect(page).to have_selector("li##{item.id}", text: item.content)
				end
			end

			it "should show the sidebar info with user name and micropost count" do
					expect(page).to  have_selector('section h1', text: user.name)
					#expect(page).to have_selector('section span', text: pluralize(Micropost.count.to_s, "micropost"))
					expect(page).to have_content("micropost".pluralize(user.feed.count)) #{http://stackoverflow.com/questions/14236438/rails-rspec-factorygirl-pluralize-test}
			end
		end
	end

	describe "Help page" do
		before { visit help_path }

		let(:heading) { 'Help' }
		let(:page_title) { 'Help' }

		it_should_behave_like "all static pages"
	end

	describe "About page" do
		before { visit about_path }

		let(:heading) { 'About Us' }
		let(:page_title) { 'About Us' }

		it_should_behave_like "all static pages"
	end

	describe "Contact page" do
		before { visit contact_path }

		let(:heading) { 'Contact Us' }
		let(:page_title) { 'Contact Us' }

		it_should_behave_like "all static pages"
	end

	it "should have the right links on the layout" do
		visit root_path
		
		click_link "About"
		expect(page).to have_title(full_title('About Us'))
		
		click_link "Help"
		expect(page).to have_title(full_title('Help'))
		
		click_link "Contact"
		expect(page).to have_title(full_title('Contact Us'))
		
		click_link "Home"
		
		click_link "Sign up now!"
		expect(page).to have_title(full_title('Sign Up'))

		click_link "Sample Application"
		expect(page).to have_title('Ruby on Rails Tutorial Sample Application')
	end
end