defmodule WhoisdaisyWeb.PageController do
  use WhoisdaisyWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end

  def imprint(conn, _params) do
    # Use the same layout-free rendering as the home page
    render(conn, :imprint, layout: false)
  end
end
