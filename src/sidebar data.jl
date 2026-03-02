Dict(
    "en" => Dict(
        "docs" => [
            "Introduction" => collections["docs"].pages ∩ collections["introduction"].pages,
            "Pluto for education" => collections["docs"].pages ∩ collections["education"].pages,
            "Using Pluto" => collections["docs"].pages ∩ collections["navigation"].pages,
            "Writing a notebook" => collections["docs"].pages ∩ collections["writing"].pages,
            "Reproducibility" => collections["docs"].pages ∩ collections["reproducibility"].pages,
            "Editor" => collections["docs"].pages ∩ collections["editor"].pages,
            "Publishing" => collections["docs"].pages ∩ collections["publishing"].pages,
            "Advanced: Widgets" => collections["docs"].pages ∩ collections["advanced"].pages ∩ collections["widgets"].pages,
            "Advanced: Internals" => collections["docs"].pages ∩ collections["advanced"].pages ∩ collections["internals"].pages,
        ],
        # "examples" => [
        #     "Getting started" => collections["examples"].pages,
        # ],
    )
)