class BlogPost < ApplicationRecord
  has_rich_text :content

  validates :title, presence: true
  validates :content, presence: true

  scope :sorted, -> { order("published_at desc NULLS LAST").order(updated_at: :desc) }
  scope :draft, -> { where(published_at: nil) }
  # ^^^^^^^^^^ -> this allows you to call BlogPost.draft
  scope :published, -> { where("published_at <= ?", Time.current) }
  scope :scheduled, -> { where("published_at > ?", Time.current) }

  def draft?
    published_at.nil?
  end

  def published?
    published_at? && published_at <= Time.current
  end

  def scheduled?
    published_at? && published_at > Time.current
  end
end

# Noted for scheduling blog_post publishing
#
# 'status' string field
# - draft
# - published
# - scheduled
#
# 'published_at' datetime field
# - nil
# - 1.year.ago
# - 1.year.from_now
