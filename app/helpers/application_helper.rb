# frozen_string_literal: true

module ApplicationHelper
  def user_is_an_author?(user)
    user == current_user
  end
end
