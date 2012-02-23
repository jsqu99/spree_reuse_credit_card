describe 'blog post page' do
  it 'lets the user post a comment', :js => true do
    visit blog_post_path(blog_posts(:first_post).id)
    fill_in 'Author', :with => 'J. Random Hacker'
    fill_in 'Comment', :with => 'Awesome post!'
    click_on 'Submit'  # this be an Ajax button -- requires Selenium
    page.should have_content('has been submitted')
    page.should have_content('Awesome post!')
  end
end
