defmodule ApiWeb.PostController do
  use ApiWeb, :controller

  alias Api.Content
  alias Api.Content.Post

  action_fallback ApiWeb.FallbackController

  def index(conn, _params) do
    posts = Content.list_posts()
    render(conn, "index.json", posts: posts)
  end

  def create(conn, %{"post" => post_params}) do
    with {:ok, %Post{} = post} <- Content.create_post(post_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", post_path(conn, :show, post))
      |> render("show.json", post: post)
    end
  end

  def show(conn, %{"id" => id}) do
    post = Content.get_post!(id)
    render(conn, "show.json", post: post)
  end

  def get_post_count(conn, %{}) do
    total = Content.get_total_posts()
    render(conn, "show.json", total: total)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Content.get_post!(id)

    with {:ok, %Post{} = post} <- Content.update_post(post, post_params) do
      render(conn, "show.json", post: post)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Content.get_post!(id)
    with {:ok, %Post{}} <- Content.delete_post(post) do
      send_resp(conn, :no_content, "")
    end
  end
end
