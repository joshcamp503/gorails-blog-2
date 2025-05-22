require "test_helper"

class BlogPostTest < ActiveSupport::TestCase
  # 3 different ways of doing things here: hard code the create fixtures to test, write and use helper methods, or hard-code the test cases

  test "draft? returns true for draft blog post" do
    # binding.irb
    assert blog_posts(:draft).draft?
    # ^^^^^^ blog_posts(:draft) comes from blog_posts.yml fixtures
  end

  test "draft? returns false for published blog post" do 
    refute blog_posts(:published).draft?
  end

  test "draft? returns false for scheduled blog post" do 
    refute blog_posts(:scheduled).draft?
  end

  test "published? returns true for published blog post" do
    # binding.irb
    assert published_blog_post.published?
  end

  test "published? returns false for draft blog post" do 
    refute draft_blog_post.published?
  end

  test "published? returns false for scheduled blog post" do 
    refute scheduled_blog_post.published?
  end
  
  test "scheduled? returns true for scheduled blog post" do
    # binding.irb
    assert BlogPost.new(published_at: 1.year.from_now).scheduled?
  end

  test "scheduled? returns false for draft blog post" do 
    refute BlogPost.new(published_at: nil).scheduled?
  end

  test "scheduled? returns false for published blog post" do 
    refute BlogPost.new(published_at: 1.year.ago).scheduled?
  end

  def draft_blog_post
    BlogPost.new(published_at: nil)
  end

  def published_blog_post
    BlogPost.new(published_at: 1.year.ago)
  end

  def scheduled_blog_post
    BlogPost.new(published_at: 1.year.from_now)
  end

end
