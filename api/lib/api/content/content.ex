defmodule Api.Content do
  @moduledoc """
  The Content context.
  """

  import Ecto.Query, warn: false
  alias Api.Repo

  alias Api.Content.Post

  @doc """
  Returns the list of posts.

  ## Examples

      iex> list_posts()
      [%Post{}, ...]

  """
  def list_posts do
    Repo.all(Post)
  end

  @doc """
  Gets a single post.

  Raises `Ecto.NoResultsError` if the Post does not exist.

  ## Examples
Examples
      iex> get_post!(123)
      %Post{}

      iex> get_post!(456)
      ** (Ecto.NoResultsError)

  """
  def get_post!(id) do
    post = Repo.get!(Post, id)
    Repo.preload(post, :images)
  end

  def get_total_posts() do
    Repo.one(from p in Post, select: count("*"))
  end

  def get_random_post() do
    query = Ecto.Adapters.SQL.query!(
      Repo,
      "SELECT id FROM posts ORDER BY RANDOM() LIMIT 1",
      [])
    %Postgrex.Result{rows: [[id]]} = query
    id
  end

  @doc """
  Creates a post.

  ## Examples

      iex> create_post(%{field: value})
      {:ok, %Post{}}

      iex> create_post(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_post(attrs \\ %{}) do
    %Post{}
    |> Post.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a post.

  ## Examples

      iex> update_post(post, %{field: new_value})
      {:ok, %Post{}}

      iex> update_post(post, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Post.

  ## Examples

      iex> delete_post(post)
      {:ok, %Post{}}

      iex> delete_post(post)
      {:error, %Ecto.Changeset{}}

  """
  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking post changes.

  ## Examples

      iex> change_post(post)
      %Ecto.Changeset{source: %Post{}}

  """
  def change_post(%Post{} = post) do
    Post.changeset(post, %{})
  end

  alias Api.Content.Image

  @doc """
  Returns the list of images.

  ## Examples

      iex> list_images()
      [%Image{}, ...]

  """
  def list_images do
    Repo.all(Image)
  end

  @doc """
  Gets a single image.

  Raises `Ecto.NoResultsError` if the Image does not exist.

  ## Examples

      iex> get_image!(123)
      %Image{}

      iex> get_image!(456)
      ** (Ecto.NoResultsError)

  """
  def get_image!(id), do: Repo.get!(Image, id)

  @doc """
  Creates a image.

  ## Examples

      iex> create_image(%{field: value})
      {:ok, %Image{}}

      iex> create_image(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_image(attrs \\ %{}) do
    %Image{}
    |> Image.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a image.

  ## Examples

      iex> update_image(image, %{field: new_value})
      {:ok, %Image{}}

      iex> update_image(image, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_image(%Image{} = image, attrs) do
    image
    |> Image.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Image.

  ## Examples

      iex> delete_image(image)
      {:ok, %Image{}}

      iex> delete_image(image)
      {:error, %Ecto.Changeset{}}

  """
  def delete_image(%Image{} = image) do
    Repo.delete(image)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking image changes.

  ## Examples

      iex> change_image(image)
      %Ecto.Changeset{source: %Image{}}

  """
  def change_image(%Image{} = image) do
    Image.changeset(image, %{})
  end

  alias Api.Content.PendingPost

  @doc """
  Returns the list of pending.

  ## Examples

      iex> list_pending()
      [%PendingPost{}, ...]

  """
  def list_pending do
    Repo.all(PendingPost)
  end

  @doc """
  Gets a single pending_post.

  Raises `Ecto.NoResultsError` if the Pending post does not exist.

  ## Examples

      iex> get_pending_post!(123)
      %PendingPost{}

      iex> get_pending_post!(456)
      ** (Ecto.NoResultsError)

  """
  def get_pending_post!(id), do: Repo.get!(PendingPost, id)

  @doc """
  Creates a pending_post.

  ## Examples

      iex> create_pending_post(%{field: value})
      {:ok, %PendingPost{}}

      iex> create_pending_post(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_pending_post(attrs \\ %{}) do
    %PendingPost{}
    |> PendingPost.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a pending_post.

  ## Examples

      iex> update_pending_post(pending_post, %{field: new_value})
      {:ok, %PendingPost{}}

      iex> update_pending_post(pending_post, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_pending_post(%PendingPost{} = pending_post, attrs) do
    pending_post
    |> PendingPost.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a PendingPost.

  ## Examples

      iex> delete_pending_post(pending_post)
      {:ok, %PendingPost{}}

      iex> delete_pending_post(pending_post)
      {:error, %Ecto.Changeset{}}

  """
  def delete_pending_post(%PendingPost{} = pending_post) do
    Repo.delete(pending_post)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking pending_post changes.

  ## Examples

      iex> change_pending_post(pending_post)
      %Ecto.Changeset{source: %PendingPost{}}

  """
  def change_pending_post(%PendingPost{} = pending_post) do
    PendingPost.changeset(pending_post, %{})
  end

  def create_both(title, caption, filename) do
    {:ok, post} = Api.Content.create_post(%{title: title, caption: caption})
    Api.Content.create_image(%{image: filename, post_id: post.id)
  end
 
end
