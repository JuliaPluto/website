Dict(
    "docs" => [
        "Introduction" => collections["docs"].pages ∩ collections["introduction"].pages,
        "Reproducibility" => collections["docs"].pages ∩ collections["reproducibility"].pages,
        "Advanced: Widgets" => collections["docs"].pages ∩ collections["advanced"].pages ∩ collections["widgets"].pages,
    ],
    # "examples" => [
    #     "Getting started" => collections["examples"].pages,
    # ],
    "blog" => [
        "Asdfsafd" => collections["blog"].pages
    ],
)