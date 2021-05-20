
"""Implementatoin of GreekOrthography's augment function for literary Greek.

$(SIGNATURES)    

# Parameters

- `ortho` An instance of a `GreekOrthography`
- `s` An optional string to augment.  If is not included, the function returns
a default augment string that can be applied to verb forms starting with a consonant
(except note that ρ doubles after augment in standard literary Greek orthography).
"""
function augment(ortho::LiteraryGreekOrthography; s = nothing)
    if isnothing(s)
        nfkc("ἐ")
    else
        normalized = nfkc(s)
        codepts = graphemes(normalized) |> collect
        stripped = Unicode.normalize(s; stripmark=true)
        if normalized[1] == 'ῥ'
            string("ἐρρ", join(codepts[2:end], "")) |> nfkc

        elseif normalized[1] in PolytonicGreek.LG_CONSONANTS
            string("ἐ", join(codepts, "")) |> nfkc

        #elseif startswith(stripped, "αι")


        elseif stripped[1] == "α"
            string("ἠ", join(codepts[2:end], "")) |> nfkc

        else
            @warn "Don't know how to augment string $s yet."
            nothing
        end
    end
end