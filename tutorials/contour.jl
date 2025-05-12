using Bonito, WGLMakie

function as_html(io, session, app)
    dom = Bonito.session_dom(session, app)
    show(io, MIME"text/html"(), Bonito.Pretty(dom))
end

session = Session(NoConnection(); asset_server=NoServer())
sub = Session(session)

open("./contour.html", "w") do io
    app = App() do session

        n = 10
        volume = rand(Float32, n, n, n)
        fig, ax, plotobj = contour(volume, figure=(size=(700, 700),))

        # Return the plot and the slider
        return Bonito.record_states(session, DOM.div(fig))
    end;

    as_html(io, session, app)
end