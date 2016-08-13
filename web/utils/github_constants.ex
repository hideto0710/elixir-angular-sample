defmodule FridayFront.GithubConstants do
  def issues_fields do
    ~w(id url repository_url labels_url comments_url html_url number state title body)
  end
end
