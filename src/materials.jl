module Materials

import ..english, ..danish, ..dedup_categories

const _MATERIALS = Tuple{String, Union{String, Nothing}}[
    ("Abortmateriale", "Abortion material"),
    ("Andet", "Other"),
    ("Bakterieisolat", "Bacterial isolate"),
    ("Bitestikel", "Epididymis"),
    ("Blod", "Blood"),
    ("Blodstreng", "Blood string"),
    ("Caecal tonsil", "Cecal tonsil"),
    ("Cervix uteri, svaberprøve", "Cervix uteri, swab sample"),
    ("Cystemateriale", "Cyst material"),
    ("EDTA-blod", "EDTA blood"),
    ("Ekstrahereret DNA/RNA", "Extracted DNA/RNA"),
    ("Embryo skyllevæske", "Embryo washing fluids"),
    ("FJERKRÆTEST", nothing),
    ("Foder", "Feed"),
    ("Fossa clitoridis, svaberprøve", "Fossa clitoridis, swab sample"),
    ("Fossa glandis, svaberprøve", "Fossa glandis, swab sample"),
    ("Fosterpool", "Fetus pool"),
    ("Fugleklat", "Bird dropping"),
    ("Fæces", "Feces"),
    ("Fæcessvaber", "Faeces swab"),
    ("Fødeavre", nothing),
    ("Fødevare", "Food"),
    ("Heparinblod", "Heparin blood"),
    ("Hjerne", "Brain"),
    ("Hjernesvaber", "Brain swabs"),
    ("Hjerte", "Heart"),
    ("Hoved", "Head"),
    ("Hudskrab", "Skin scraping"),
    ("Høstet allantoisvæske", "Harvested allantoic fluid"),
    ("Kadaver(e)", "Cadaver(s)"),
    ("Kadaver/organer", "Cadaver/organs"),
    ("Kloaksvaber", "Cloacal swab"),
    ("Kloaksvaber x 10", "Cloacal swab x 10"),
    ("Kloaksvaber x 2", "Cloacal swab x 2"),
    ("Kloaksvaber x 3", "Cloacal swab x 3"),
    ("Kloaksvaber x 3", "Cloacal swab x 3"),
    ("Kloaksvaber x 4", "Cloacal swab x 4"),
    ("Kloaksvaber x 4", "Cloacal swab x 4"),
    ("Kloaksvaber x 5", "Cloacal swab x 5"),
    ("Kloaksvaber x 6", "Cloacal swab x 6"),
    ("Kloaksvaber x 6", "Cloacal swab x 6"),
    ("Kloaksvaber x 7", "Cloacal swab x 7"),
    ("Kloaksvaber x 8", "Cloacal swab x 8"),
    ("Kloaksvaber x 9", "Cloacal swab x 9"),
    ("Krøslymfeknude", "Mesenteric lymph node"),
    ("Kødsaft", "Meat juices"),
    ("Kødsaft fra lunge", "Meat juice from lung"),
    ("Ledvæske", "Joint fluid"),
    ("Lever", "Liver"),
    ("Luftprøve", "Air sampling"),
    ("Luftsække", "Air sacs"),
    ("Lunge", "Lung"),
    ("Lymfeknude", "Lymph node"),
    ("Løbeindhold", "Abomasal content"),
    ("Milt", "Spleen"),
    ("Mixed", "Mixed"),
    ("Mundhuleskrab", "Scraping from mouth cavity"),
    ("Mælk, individuel", "Milk, individual"),
    ("Mælk, tank", "Milk, tank"),
    ("NN", "NN"),
    ("Nyre", "Kidney"),
    ("Næsesvaber", "Nasal swab"),
    ("Næsesvaber x 10", "Nasal swab x 10"),
    ("Næsesvaber x 2", "Nasal swab x 2"),
    ("Næsesvaber x 3", "Nasal swab x 3"),
    ("Næsesvaber x 4", "Nasal swab x 4"),
    ("Næsesvaber x 5", "Nasal swab x 5"),
    ("Næsesvaber x 6", "Nasal swab x 6"),
    ("Næsesvaber x 7", "Nasal swab x 7"),
    ("Næsesvaber x 8", "Nasal swab x 8"),
    ("Næsesvaber x 9", "Nasal swab x 9"),
    ("Organmateriale", "Organ material"),
    ("Organpool", "Organ pool"),
    ("Ovarier", "Ovaries"),
    ("Pels", "Fur"),
    ("Placenta", "Placenta"),
    ("Plasma", "Plasma"),
    ("Pleuravæske", "Pleural fluid"),
    ("Pool af fugleklatter", "Pool of bird droppings"),
    ("Pool af fæces", "Feces pool"),
    ("Pool af hjerne", "Pool of brain tissue"),
    ("Pool af kloaksvabere", "Pool of cloacal swabs"),
    ("Pool af lever", "Pool of liver"),
    ("Pool af lever, milt, nyre", "Pool of liver, spleen, kidney"),
    ("Pool af lever, milt, nyre fra flere dyr", "Pool of liver, spleen, kidney from several animals"),
    ("Pool af lunge", "Pool of lung tissue"),
    ("Pool af milt", "Pool of spleen"),
    ("Pool af nyre", "Pool of kidney"),
    ("Pool af næsesvabere", nothing),
    ("Pool af næsesvabere", "Pool of nasal swabs"),
    ("Pool af serum", "Pool of serum"),
    ("Pool af svabere", "Pool of swab samples"),
    ("Pool af svælgsvabere", "Pool of throat swabs"),
    ("Pool af tarm", "Pool of intestine"),
    ("Pool af trachea", "Pool of tracheal tissue"),
    ("Pool af tracheal- og kloaksvaber", "Pool of tracheal and cloacal swab"),
    ("Pool af trachealsvabere", "Pool of tracheal swabs"),
    ("Pool af caecale tonsiller", "Pool of cecal tonsils"), # NOTE: space-like char '\ua0'
    ("Processing fluid", "Processing fluid"),
    ("Præputium, svaberprøve", "Preputium, swab sample"),
    ("Rektalsvaber", "Rectal swab"),
    ("Råsæd", "Raw semen"),
    ("Serum", "Serum"),
    ("Sinus clitoridis, svaberprøve", "Sinus clitoridis, swab sample"),
    ("Sinus urethralis, svaberprøve", "Sinus urethralis, swab sample"),
    ("Skylleprøve af forhud", "Preputial washing"),
    ("Snabelskyl", "Trunk wash sample"),
    ("Spyt", "Saliva"),
    ("Spytsvaber", "Oral fluid swab"),
    ("Svaberprøve fra bronchie", "Swab sample from bronchi"),
    ("Svaberprøver", "Swab samples"),
    ("Svaberprøver cervix uteri", nothing),
    ("Svælgsvaber", "Throat swab"),
    ("Svælgsvaber x 10", "Throat swab x 10"),
    ("Svælgsvaber x 2", "Throat swab x 2"),
    ("Svælgsvaber x 3", "Throat swab x 3"),
    ("Svælgsvaber x 4", "Throat swab x 4"),
    ("Svælgsvaber x 5", "Throat swab x 5"),
    ("Svælgsvaber x 6", "Throat swab x 6"),
    ("Svælgsvaber x 7", "Throat swab x 7"),
    ("Svælgsvaber x 8", "Throat swab x 8"),
    ("Svælgsvaber x 9", "Throat swab x 9"),
    ("Sæd", "Semen"),
    ("Sædstrå", "Semen straw"),
    ("Tankmælk", "Tank milk"),
    ("Tarm", "Intestine"),
    ("Tarmpool", "Intestine pool"),
    ("TEST-API-Materiale", "TEST-API-Materiale"),
    ("TEST-API-Materiale2", "TEST-API-Materiale2"),
    ("Testikel", "Testicle"),
    ("Testikel og bitestikel", "Testicle and epididymis"),
    ("Testikel, bitestikel, lymfeknude og milt", "Testicle, epididymis, lymph node and spleen"),
    ("Testikelsaft", "Testicle juice"),
    ("Tonsil", "Tonsil"),
    ("Trachea", "Trachea"),
    ("Trachealskyl", "Tracheal flush"),
    ("Trachealsvaber", "Tracheal swab"),
    ("Trachealsvaber x 10", "Tracheal swab x 10"),
    ("Trachealsvaber x 2", "Tracheal swab x 2"),
    ("Trachealsvaber x 3", "Tracheal swab x 3"),
    ("Trachealsvaber x 4", "Tracheal swab x 4"),
    ("Trachealsvaber x 5", "Tracheal swab x 5"),
    ("Trachealsvaber x 6", "Tracheal swab x 6"),
    ("Trachealsvaber x 7", "Tracheal swab x 7"),
    ("Trachealsvaber x 8", "Tracheal swab x 8"),
    ("Trachealsvaber x 9", "Tracheal swab x 9"),
    ("Urethra, svaberprøve", "Urethral swab sample"),
    ("Urin", "Urine"),
    ("Uterussvaber", "Uterine swab"),
    ("Vagina/præputium, svaberprøve", "Vagina/preputium, swab sample"),
    ("Virusisolat dyrket i celler", "Virus isolated in cell culture"),
    ("Virusisolat dyrket i æg", "Virus isolated in embryonated eggs"),
    ("Væv", "Tissue"),
] |> dedup_categories

expr = :(@enum Material::UInt16)
for (sym, da, en) in _MATERIALS
    push!(expr.args, sym)
end
eval(expr)

@doc """
Material

Enum type representing the materials given in VETLIMS. Can be created with `parse(Material, s)`,
but the string `s` must match exactly.  The canonical representation is in Danish.
Can be displayed using `danish` and `english`.
""" Material 

danish(x::Material) = @inbounds _MATERIALS[Integer(x) + 1][2]
english(x::Material) = @inbounds _MATERIALS[Integer(x) + 1][3]

Base.print(io::IO, x::Material) = print(io, danish(x))

const _MATERIAL_DICT = Dict(danish(i) => i for i in instances(Material))
function Base.parse(::Type{Material}, s::AbstractString)
    v = get(_MATERIAL_DICT, s, nothing)
    v === nothing ? error("Cannot parse \"", s, "\" as Material") : v
end

export Material
end # module