"Get the English name of the object, or `nothing` if not applicable"
function english end

"Get the Danish name of the object, or `nothing` if not applicable"
function danish end

"Get the Latin name of an object, or `nothing` if not applicable"
function latin end

module Hosts
import Base.Enums: basetype

"""
Virus host animal.

This may be a species or a looser group of species (like "duck"). The Latin, English,
and Danish names can be gotten with the functions `latin`, `english` and `danish`.
If the name is not available in that language, it returns `nothing`.
"""
@enum Host::UInt8 begin
    mallard
    unknown_duck
    peregrine
    kestrel
    barnacle
    blackhead
    widgeon
    chicken
    herring_gull
    blackback
    gadwall
    taiga
    unknown_goose
    buzzard
    greylag
    pheasant
    whitetailed_eagle
    gannet
    mute_swan
    whooper_swan
    turkey
    red_knot
    eider
    moorhen
    coot
    pinkfoot
    jackdaw
    merganser
end

import ..english, ..latin, ..danish

let
    NAMES = Tuple{Host, Union{String, Nothing}, Vararg{String, 2}}[
        # Ducks
        (mallard, "Anas platyrhynchos", "Mallard", "Gråand"),
        (unknown_duck, nothing, "duck", "and"),
        (widgeon, "Mareca penelope", "Eurasian wigeon", "Pibeand"),
        (gadwall, "Mareca strepera", "Gadwall", "Knarand"),
        # Geese
        (barnacle, "Branta leucopsis", "Barnacle goose", "Bramgås"),
        (greylag, "Anser anser", "Greylag goose", "Grågås"),
        (taiga, "Anser fabalis", "Taiga bean goose", "Sædgås"),
        (pinkfoot, "Anser brachyrhynchus", "Pink-footed goose", "Kortnæbbet gås"),
        (unknown_goose, nothing, "goose", "gås"),
        # Birds of prey
        (peregrine, "Falco peregrinus", "Peregrine falcon", "Vandrefalk"),
        (kestrel, "Falco tinnunculus", "Common kestrel", "Tårnfalk"),
        (buzzard, "Buteo buteo", "Common buzzard", "Musvåge"),
        (whitetailed_eagle, "Haliaeetus albicilla", "White-tailed eagle", "Havørn"),
        # Gulls
        (blackhead, "Chroicocephalus ridibundus", "Black-headed gull", "Hættemåge"),
        (herring_gull, "Larus argentatus", "European herring gull", "Sølvmåge"),
        (blackback, "Larus marinus", "Great black-backed gull", "Svartbag"),
        # Commonly domesticated fowl
        (chicken, "Gallus gallus", "Chicken", "Høns"),
        (turkey, "Meleagris gallopavo", "Turkey", "Kalkun"),
        # Other
        (pheasant, "Phasianus colchicus", "Common pheasant", "Fasan"),
        (gannet, "Morus bassanus", "Northern gannet", "Sule"),
        (mute_swan, "Cygnus olor", "Mute swan", "Knopsvane"),
        (whooper_swan, "Cygnus cygnus", "Whooper swan", "Sangsvane"),
        (red_knot, "Calidris canutus", "Red knot", "Islandsk ryle"),
        (eider, "Somateria mollissima", "Common eider", "Edderfugl"),
        (moorhen, "Gallinula chloropus", "Common moorhen", "Grønbenet rørhøne"),
        (coot, "Fulica atra", "Eurasian coot", "Blishøne"),
        (jackdaw, "Coloeus monedula", "Western jackdaw", "Allike"),
        (merganser, "Mergus merganser", "Common merganser", "Stor skallesluger")
    ]
    N = length(instances(Host))
    @assert length(Set(map(first, NAMES))) == N
    for i in (:_LATIN, :_ENGLISH, :_DANISH)
        @eval const $i = Union{Nothing, String}[nothing for i in 1:$N]
    end
    for (host, latin, english, danish) in NAMES
        i = basetype(Host)(host)
        _LATIN[i + one(i)] = latin
        _ENGLISH[i + one(i)] = english
        _DANISH[i + one(i)] = danish
    end
    for i in (:latin, :english, :danish)
        arr = Symbol('_' * uppercase(String(i)))
        @eval $(i)(x::Host) = @inbounds $(arr)[basetype(Host)(x) + one(basetype(Host))]
    end
end

export Host
end # Hosts