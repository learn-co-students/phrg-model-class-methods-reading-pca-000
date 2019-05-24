# frozen_string_literal: true

class Post < ActiveRecord::Base
  validate :title_case
  before_validation :make_title_case
  belongs_to :author

  # put new code here
  def self.by_author(author_id)
    where(author: author_id)
  end

  def self.from_today
    where("created_at >=?", Time.zone.today.beginning_of_day)
  end

  def self.old_news
    where("created_at <?", Time.zone.today.beginning_of_day)
  end

private

  def title_case
    return unless title.split.any? { |w| w[0].upcase != w[0] }

    errors.add(:title, "Title must be in title case")
  end

  def make_title_case
    self.title = title.titlecase
  end
end
