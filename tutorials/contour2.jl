using WGLMakie, Bonito

root = "docs"         # folder that will hold your static site
mkpath(root)          # creates it (and parents) if it doesn’t exist

html_path = joinpath(root, "contour.html")

function as_html(io, session, app)
    dom = Bonito.session_dom(session, app)
    show(io, MIME"text/html"(), Bonito.Pretty(dom))
end

open(html_path, "w") do io
    println(io, "<!doctype html>")
    asset_server = Bonito.AssetFolder(root, dirname(html_path))

    session = Session(NoConnection(); asset_server = asset_server)
    app = App() do sess
        n = 10
        volume = rand(n, n, n)
        fig, _, _ = contour(volume, figure = (size = (700, 700),))
        Bonito.DOM.div(fig)
    end

    as_html(io, session, app)
end
