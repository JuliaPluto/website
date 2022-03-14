Dict(
    "manual" => [
        "Introduction" => collections["manual"].pages ∩ collections["introduction"].pages,
        "Reproducibility" => collections["manual"].pages ∩ collections["reproducibility"].pages,
        "Advanced: Widgets" => collections["manual"].pages ∩ collections["advanced"].pages ∩ collections["widgets"].pages,
    ],
    "examples" => [
        "Getting started" => collections["examples"].pages,
    ],
    "blog" => [
        "Asdfsafd" => collections["blog"].pages
    ],
)